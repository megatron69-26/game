# AI HANDOVER — TỆ NẠN

## 1. Thông tin project

- **Tên:** Tệ Nạn
- **Engine:** Godot 4.x
- **Thể loại:** 3D tabletop roguelike
- **Project:** `C:\Users\khoid\OneDrive\Documents\tệ-nạn`
- **Git remote:** `https://github.com/megatron69-26/game`
- **Roadmap chính:** [ROADMAP.md](ROADMAP.md)

Concept kết hợp không khí tabletop của Buckshot Roulette, scoring Poker kiểu
Balatro và progression map kiểu Slay the Spire. Player và Dealer dùng chung một
deck; hand Poker tạo Score; bullet quyết định Score biến thành damage, heal hoặc
status effect.

## 2. Phân công cố định

### Human

Human là owner của toàn bộ visual/3D:

- model, texture, material
- scene tree và layout
- transform, camera, lighting
- animation/VFX visual
- nghiệm thu cảm giác hình ảnh trong Godot Editor

### Codex

Codex là Lead Programmer/Technical Director:

- quyết định architecture và gameplay rules
- chia roadmap thành đầu việc có số thứ tự
- viết prompt/task cho Agy
- review code, diff, log và test report
- quản lý dependencies, Git, tài liệu và Definition of Done
- không tự giả định tọa độ/transform khi chưa thấy viewport

### Agy / Gemini

Agy là Execution Engineer:

- viết/sửa GDScript theo task
- sửa scene/resource link chỉ khi task cho phép
- chạy test và đọc error log
- báo cáo files changed, tests và unresolved issues
- không tự thiết kế gameplay mới
- không tự đổi transform, visual, asset hoặc architecture

## 3. Quy trình một đầu việc

Mỗi đầu việc map với đúng một bước trong `ROADMAP.md` và có hai track song song:

```text
ĐẦU VIỆC N
├── Track N-3D — Human
└── Track N-Logic — Codex → Agy
```

Hai track không cần chờ nhau, nhưng dependencies phải được ghi rõ. Đầu việc chỉ
đóng tại checkpoint cuối khi:

1. Codex xác nhận code/test pass.
2. Human nghiệm thu visual nếu có Track 3D.
3. Hai track đã tích hợp được với nhau.
4. Agy đã gửi báo cáo kết quả.

Nếu không có thay đổi visual, Track 3D được đánh dấu `N/A`.

## 4. Format task gửi cho Agy

Mỗi prompt phải có:

```text
ĐẦU VIỆC N — tên và roadmap step

Objective:

Track:

Allowed files:

Do not modify:

Requirements:

Dependencies:

Tests/acceptance criteria:

Required report:
- files changed
- implementation summary
- tests run and result
- unresolved issues
```

Agy phải dừng và hỏi lại nếu task mơ hồ hoặc phát hiện yêu cầu ngoài phạm vi.

## 5. Trạng thái hiện tại

Project đã có scene combat, `Card3D.gd`, `GameManager.gd`, `card_3d.tscn` và
`ban_choi.tscn`. Prototype hiện đang ở **ĐẦU VIỆC 1**: ổn định scene và chức
năng chia 5 lá. Các hệ thống Deck, Poker, turn, bullet, inventory, Dealer AI,
cleanup và progression chưa hoàn tất.

Asset trong `Assets/` được giữ local và bị Git ignore vì có nguồn trích xuất từ
game gốc; không commit/public khi chưa có quyền sử dụng phù hợp.

## 6. Quy tắc dừng

Agy kết thúc báo cáo bằng `[WAIT_FOR_HUMAN]` khi:

- task đã đạt acceptance criteria;
- cần Human nghiệm thu visual;
- cần quyết định gameplay/architecture;
- gặp lỗi hoặc thiếu resource ngoài phạm vi.

Không tự tạo vòng lặp trao đổi vô hạn giữa các agent.
