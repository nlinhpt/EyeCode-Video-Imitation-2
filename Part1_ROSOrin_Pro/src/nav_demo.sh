#!/bin/bash
ACTION=/navigate_to_pose
OUT=~/ros2_ws/nav_results.csv

# ---- Toa do ----
GOALS=(
  "A  1.0  0.5   0"
  "P1 1.5 -1.0  90"
  "P2 0.0 -2.0 180"
  "P3 -1.0 0.0 -90"
)
# -------------------------------------------

echo "name,goal_x,goal_y,yaw_deg,status,seconds,clock,final_x,final_y,error_m" > "$OUT"

final_pose() {
  timeout 6 ros2 topic echo /amcl_pose --once --field pose.pose.position 2>/dev/null \
    | awk '/^x:/{x=$2} /^y:/{y=$2} END{if(x!="") printf "%.3f %.3f", x, y}'
}

send_goal() {
  local name=$1 x=$2 y=$3 yaw=$4
  local qz qw start end secs clock log status fp fx fy err
  qz=$(python3 -c "import math;print(math.sin(math.radians($yaw)/2))")
  qw=$(python3 -c "import math;print(math.cos(math.radians($yaw)/2))")
  clock=$(date +%H:%M:%S)
  start=$(date +%s.%N)
  log=$(ros2 action send_goal $ACTION nav2_msgs/action/NavigateToPose \
    "{pose: {header: {frame_id: map}, pose: {position: {x: $x, y: $y, z: 0.0}, orientation: {z: $qz, w: $qw}}}}" 2>&1)
  end=$(date +%s.%N)
  secs=$(python3 -c "print(round($end-$start,1))")
  status=$(echo "$log" | grep -o "Goal finished with status: [A-Z]*" | awk '{print $5}')
  if [ -z "$status" ]; then
    echo "$log" | grep -qi "rejected" && status=REJECTED || status=UNKNOWN
  fi
  fp=$(final_pose); fx=${fp% *}; fy=${fp#* }
  if [ -n "$fp" ]; then
    err=$(python3 -c "import math;print(round(math.hypot($fx-$x,$fy-$y),2))")
  else
    fx=""; fy=""; err=""
  fi
  echo "$name,$x,$y,$yaw,$status,$secs,$clock,$fx,$fy,$err" | tee -a "$OUT"
}

ros2 node list | grep -E "amcl|bt_navigator|controller_server|planner_server" || \
  echo "CANH BAO: khong thay node Nav2"
ros2 action list | grep -q "$ACTION" || { echo "Khong thay action $ACTION"; exit 1; }

for g in "${GOALS[@]}"; do
  set -- $g
  read -p ">> Bam Enter de gui diem $1 (x=$2 y=$3 yaw=$4)..." _
  send_goal "$1" "$2" "$3" "$4"
done

echo
awk -F, 'NR>1 {n++; if($5=="SUCCEEDED"){ok++; t+=$6}}
  END{printf "Den dich: %d/%d\n", ok, n;
      if(ok>0) printf "Thoi gian trung binh: %.1f s\n", t/ok}' "$OUT"
echo "File ket qua: $OUT"
