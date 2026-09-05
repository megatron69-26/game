# Kế Hoạch Phát Triển (Master Roadmap)

Bảng kế hoạch này phân rã các bước thi công game dựa trên Flowchart. Dự án đi theo hướng **100% 3D Tabletop** (Tương tác vật lý Diegetic, không dùng UI 2D).

---

## PHẦN 1: SETUP BÀN CHƠI & BỘ BÀI (Init Round)
*Cốt lõi để tạo ra cảm giác "ngồi đánh bài trong phòng kín".*

| Thành phần | 🧊 3D Models & Assets | 🎬 Animation / Kĩ xảo | 💻 Code Logic |
| :--- | :--- | :--- | :--- |
| **Bàn chơi** | Bàn, Ánh sáng đèn trần (Spotlight), Môi trường xung quanh. | Ánh sáng nhấp nháy ngẫu nhiên. Camera rung nhẹ. | `GameManager.gd`: Quản lý State của ván đấu. |
| **Máy đo máu** | 2 cỗ máy hiện số máu (Player và Dealer) + Màn hình hiện Score. | Nhảy số cuộn (Lerp số). Dây điện tóe lửa khi mất máu. | Cập nhật số liệu hiển thị lên vật thể 3D. |
| **Cọc bài chung** | Cọc bài úp (Deck), Cọc bài lật (Mộ). Tấm bài lẻ 3D (`Card3D.tscn`).| Lá bài bay từ Cọc chia về tay 2 người. Hiệu ứng tráo bài. | `DeckManager.gd`: Chứa mảng bài. Code rút bài, xào bài ngẫu nhiên. |

## PHẦN 2: LƯỢT NGƯỜI CHƠI - BỐC BÀI & CHỌN HÀNH ĐỘNG
*Tương tác trực tiếp bằng Raycast 3D.*

| Thành phần | 🧊 3D Models & Assets | 🎬 Animation / Kĩ xảo | 💻 Code Logic |
| :--- | :--- | :--- | :--- |
| **Xếp bài** | 5 lá bài lơ lửng ở mép dưới màn hình (tay người chơi). | Khi rê chuột (Hover): Lá bài nhô lên. Click: Bài bay ra giữa bàn. | `PlayerController.gd`: Phóng Raycast 3D để click chọn bài. |
| **Chốt hạ** | 1 cái "Chuông" (Đổi bài - Discard) và 1 cái "Cần gạt" (Play Hand). | Đập tay vào chuông. Kéo cần gạt đánh cạch. | Kiểm tra bài đang chọn. Trừ lượt Discard hoặc chuyển sang Tính điểm. |
| **Vật phẩm** | Kính lúp, Lon Bia, Còng Tay, Bao Thuốc... | Cầm lên, sử dụng, vứt ra khỏi bàn. | `ItemManager.gd`: Tác dụng trực tiếp lên Deck (Đốt bài) hoặc nhìn lén. |

## PHẦN 3: TÍNH ĐIỂM POKER & CHỌN ĐẠN (Play Hand -> Inventory)
*Chuyển từ tính toán sang sát phạt.*

| Thành phần | 🧊 3D Models & Assets | 🎬 Animation / Kĩ xảo | 💻 Code Logic |
| :--- | :--- | :--- | :--- |
| **Bộ đếm điểm** | TextMesh nổi giữa bàn hiện: `BASE x MULT = DAMAGE` | Lá bài rực sáng khi tạo thành Combo (Sảnh, Thùng...). | `PokerLogic.gd`: Thuật toán chấm điểm bài. Chốt ra lượng Damage. |
| **Vali Đạn** | Vali xách tay. Các viên đạn với màu sắc khác nhau. | Vali mở chốt. Người chơi gắp đạn. Băng đạn trên bàn. | Lưu trữ số đạn mang theo từ Shop. Code trừ số lượng đạn khi gắp. |
| **Khẩu Súng** | Súng Shotgun. | Lấy đạn nhét vào nòng. Lên đạn (Pump) nghe tiếng cạch cạch. | `GunManager.gd`: Nhận sát thương đã tính + Áp dụng nội tại đạn. |

## PHẦN 4: KHAI HOẢ (Aim & Shoot)
*Sự dứt khoát, bạo lực và hiệu ứng trả giá.*

| Thành phần | 🧊 3D Models & Assets | 🎬 Animation / Kĩ xảo | 💻 Code Logic |
| :--- | :--- | :--- | :--- |
| **Mục Tiêu** | Tương tác chĩa súng về phía Dealer hoặc bẻ nòng tự chĩa. | Chuyển động súng chĩa tới lui. | Kiểm tra mục tiêu lựa chọn (Self hay Dealer). |
| **Hiệu Ứng Bắn** | VFX Tia lửa súng, Particle Khói. | Màn hình rung bần bật, súng giật lùi. Dealer văng ngửa ra sau. | Trừ máu. Gây hiệu ứng (Stun/Poison). Check `HP <= 0`. |
| **Chết/Gục** | Mesh mặt Dealer bị vỡ. Dây truyền máu đứt. | Gục đầu xuống bàn (Dealer). Màn hình đỏ ngòm, sụp tối (Player). | `GameState.gd`: Quyết định Game Over, Thắng, hay Dọn bài qua lượt. |

## PHẦN 5: LƯỢT AI DEALER (Dealer Turn)
*Dealer biết chơi bài thay vì nổ súng ngẫu nhiên.*

| Thành phần | 🧊 3D Models & Assets | 🎬 Animation / Kĩ xảo | 💻 Code Logic |
| :--- | :--- | :--- | :--- |
| **Bot Đánh Bài** | Bàn tay Dealer. | Tay Dealer bốc bài úp trên bàn lật ngửa ra. | `DealerAI.gd`: Tự đọc 5 lá bài, cố gắng ghép đôi/xảnh. Nếu bài xấu -> Bấm Chuông Discard. |
| **Bot Dùng Đồ** | Các thao tác gắp đạn, cầm súng giống hệt người chơi. | Lên đạn, chĩa súng, hút thuốc. | Phân tích: Nếu Damage to -> Bắn Player. Damage nhỏ/Đạn hồi máu -> Tự bắn mình. |

---

## KẾ HOẠCH TÁC CHIẾN (Sprint Phasing)
1. **Giai đoạn 1 (Tuần 1):** Làm xong PHẦN 1 & PHẦN 2 (Khởi tạo lá bài 3D, chia bài lơ lửng, tính điểm Poker cơ bản).
2. **Giai đoạn 2 (Tuần 2):** Làm PHẦN 3 & 4 (Lắp đạn, hiệu ứng súng nổ, trừ máu).
3. **Giai đoạn 3 (Tuần 3):** Làm PHẦN 5 (Code trí tuệ nhân tạo AI cho Dealer).
4. **Giai đoạn 4 (Tuần 4):** Đánh bóng (Thêm Particle Khói, âm thanh, ánh sáng chớp tắt).
