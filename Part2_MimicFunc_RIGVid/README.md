# Part 2 — Video Imitation: MimicFunc và RIGVid

| Paper | Venue | Code gốc | Trạng thái tái lập |
|---|---|---|---|
| MimicFunc | CoRL 2025 | https://github.com/mkt1412/FUNCTO_public | Chạy được (`RUN_MODE = "dino"`, không cần API key) |
| RIGVid | ICLR 2026 | https://github.com/shivanshpatel35/rigvid | Chưa cài được môi trường (RollingDepth + FoundationPose), chưa có số liệu tái lập |

## Báo cáo
[`report/Report_part2_MimicFunc_and_RIGVid.pdf`](report/Report_part2_MimicFunc_and_RIGVid.pdf): tóm tắt, so sánh, kết quả tái lập, ca thất bại, giới hạn.

## Cách chạy lại

Cả hai notebook chạy trên Google Colab (GPU).

### MimicFunc — `notebooks/MimicFunc_reproduction.ipynb`
1. Mở notebook trên Colab, chọn runtime GPU.
2. Chạy lần lượt các ô. Notebook tự clone `FUNCTO_public` và cài thư viện.
3. `RUN_MODE = "dino"` thay GPT-4o bằng DINOv2 (không cần key). `RUN_MODE = "gpt4o"` cần `OPENAI_API_KEY` trong Colab secrets.
4. Repo gốc gọi OWLv2/SAM/SD-DINO qua server nội bộ, nên notebook viết lại `owlv2.py` và `sam.py` chạy cục bộ.

Kết quả (`abl_dino_k8_sam`): Mask IoU tool/target 0.952/0.994, sai số quỹ đạo 0.023 m / 36.17°, Pour proxy đạt. Các cấu hình mask hình hộp (`*_box`) chọn nhầm keypoint.

### RIGVid — `notebooks/Rigvid.ipynb`
Notebook cài RollingDepth và FoundationPose rồi chạy pipeline. Môi trường chưa cài thành công nên chưa có kết quả tái lập; số liệu trong báo cáo lấy từ paper.

## Ghi chú
- `MimicFunc_reproduction.ipynb` nặng (~22 MB) do chứa output hình ảnh.
- Hình/số liệu xuất thêm đặt trong `results/`.
