# EyeCode Research Entry Task - Video Imitation 2

Submission: source code, technical report, and demo videos.

| Part | Nội dung | Thư mục |
|---|---|---|
| 1 | ROSOrin Pro Gazebo simulation (SLAM, map, navigation) | [`Part1_ROSOrin_Pro/`](Part1_ROSOrin_Pro) |
| 2 | Đọc, so sánh và tái hiện MimicFunc (CoRL 2025) và RIGVid (ICLR 2026) | [`Part2_MimicFunc_RIGVid/`](Part2_MimicFunc_RIGVid) |

## Demo videos

Video hơi ồn nên mọi người tắt tiếng trước khi mở.

| Video | Link |
|---|---|
| Part 1 - ROSOrin Pro simulation demo | https://youtu.be/5-m_gu8l4IE|
| Part 2 - MimicFunc reproduction demo | https://youtu.be/9rYkmEh90qs|

## Cấu trúc repo

```
.
├── README.md
├── Part1_ROSOrin_Pro/
│   ├── README.md          # setup, lệnh chạy, vấn đề gặp phải
│   ├── src/               # package / launch files
│   ├── config/            # cấu hình SLAM, navigation
│   ├── maps/              # map đã lưu (.pgm/.yaml)
│   ├── demo/              # ảnh chụp, link videos
│   └── report/            # báo cáo ngắn Part 1
└── Part2_MimicFunc_RIGVid/
    ├── README.md          # hướng dẫn tái lập
    ├── notebooks/
    │   ├── MimicFunc_reproduction.ipynb
    │   └── Rigvid.ipynb
    ├── report/
    │   └── Report_part2_MimicFunc_and_RIGVid.pdf
    └── results/           # ảnh/số liệu xuất ra
```

## Báo cáo kỹ thuật

 `Part1_ROSOrin_Pro/report/` và `Part2_MimicFunc_RIGVid/report/`
