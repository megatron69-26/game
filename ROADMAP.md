# KẾ HOẠCH PHÁT TRIỂN CHI TIẾT (MASTER ROADMAP)

Bản kế hoạch này bám sát 100% Sơ đồ luồng (FLOWCHART.md) và được chia thành các **Đầu việc thi công (Task Breakdown)** cụ thể cho cả 2 vai trò: 🎨 Artist (Bạn - Xếp cảnh/3D) và 💻 Coder (Tôi - Lập trình).

---

## 🌍 PHẦN 1: HỆ THỐNG CỐT LÕI (GLOBAL/AUTOLOAD)
*Hệ thống chạy ngầm để giữ dữ liệu khi chuyển cảnh giữa Map và Combat.*
- [ ] 💻 **Tạo `RunManager.gd` (Autoload):** Lưu trữ số Tiền (Chips), Máu tối đa của Player, và Bộ Bài Gốc (Master Deck - để biết bạn đã mua/xoá lá bài nào trong Shop).
- [ ] 💻 **Tạo `Enums.gd` (Global):** Chứa các định nghĩa trạng thái game (TURN_PLAYER, TURN_DEALER, CALCULATING, SHOOTING).

---

## 🛒 PHẦN 2: SCENE CỬA HÀNG & BẢN ĐỒ (`Shop.tscn`)
*(Tương ứng Node: `Shop` trên Flowchart)*
- [ ] 🎨 **Dựng Scene:** Một căn phòng 3D nhỏ hoặc màn hình sau cốp xe. Có quầy trưng bày Đạn (Bullets) và Vật Phẩm (Items).
- [ ] 🎨 **Tạo Text/UI 3D:** Hiển thị giá tiền của từng món đồ và số Tiền Player đang có.
- [ ] 💻 **Code `ShopManager.gd`:** Lập trình hệ thống click vào đồ vật 3D để Mua (Trừ tiền, đẩy item vào Inventory ở `RunManager`).
- [ ] 💻 **Chức năng Độ Bài (Deck Builder):** Bỏ tiền để xoá 1 lá bài rác khỏi Master Deck.
- [ ] 🎨/💻 **Nút "Vào Bàn":** Bấm vào cửa để `get_tree().change_scene_to_file("res://Scenes/BanChoi.tscn")`.

---

## ⚔️ PHẦN 3: SCENE CHIẾN ĐẤU (`BanChoi.tscn`)
*Chiếm 90% thời lượng game, bám sát các luồng rẽ nhánh trong Flowchart.*

### Module 3.1: Setup Bàn & Khởi tạo (Node `InitRound`)
- [ ] 🎨 **Dựng Scene:** Đặt bàn, ghế, Dealer, Camera FPS, Máy đo HP.
- [ ] 💻 **Code `GameManager.gd`:** Lấy dữ liệu từ `RunManager`. Set máu 2 bên.
- [ ] 💻 **Code `DeckManager.gd`:** Sinh ra (Instantiate) 52 lá bài vật lý. Hàm xào bài (Shuffle). Hàm chia 5 lá lơ lửng trước mặt Player, úp 5 lá trước Dealer.

### Module 3.2: Tương tác Bài 3D (Nodes `ActionP`, `CheckDiscard`, `DiscardCards`)
- [ ] 🎨 **Scene `Card3D.tscn`:** Root `Area3D`, chứa `MeshInstance3D` (cái thẻ) và `CollisionShape3D`.
- [ ] 💻 **Code `Card3D.gd`:** Hàm `on_hover` (nhô lên), `on_click` (chọn bài/đổi màu viền).
- [ ] 🎨 **Nút tương tác:** Tạo Chuông (Discard) và Cần gạt (Play Hand) trên bàn bằng 3D.
- [ ] 💻 **Code `PlayerController.gd`:** Phóng Raycast 3D để click chuột. Trừ điểm Action khi bấm Chuông (Discard). Vứt bài cũ vào Mộ, bốc bài mới từ Deck.

### Module 3.3: Tính Điểm (Node `CalcScore`)
- [ ] 🎨 **Máy tính điểm:** TextMesh 3D nổi giữa bàn.
- [ ] 💻 **Code `PokerLogic.gd`:** Nhận mảng 5 lá bài đang chọn. Thuật toán phân tích bài (Xảnh, Thùng, Đôi...). Trả về kết quả: `Total Score = Base x Mult`. Đẩy số lên máy tính 3D.

### Module 3.4: Kho Đồ & Nạp Đạn (Nodes `UseItem`, `OpenInv`)
- [ ] 🎨 **Vali Đạn:** Hoạt ảnh mở vali. Chứa các viên đạn màu khác nhau.
- [ ] 💻 **Code `Inventory.gd`:** Hiển thị các viên đạn/vật phẩm người chơi đã mua từ `Shop`.
- [ ] 💻 **Tác dụng Item:** Code chức năng cầm Kính lúp xem lén 2 lá đầu của Deck, uống bia để vứt 1 lá bài...

### Module 3.5: Bóp Cò & Trả Giá (Nodes `Aim`, `EffectDealer`, `EffectPlayer`)
- [ ] 🎨 **Khẩu Shotgun:** Animation lên nòng, chĩa về phía trước (Địch) hoặc chĩa vào mình (Player). VFX Lửa nổ, Khói.
- [ ] 💻 **Code `GunManager.gd`:** Lấy `Total Score` từ Module 3.3, nhân với Nội tại Đạn (VD: Đạn Rỗng x2, Đạn Độc = Poison).
- [ ] 💻 **Trừ Máu:** Trừ HP trên máy đếm. Thêm trạng thái (Stun/Choáng).

### Module 3.6: Lượt Dealer AI (Nodes `AIAction`, `AICalcScore`, `AIChooseBullet`)
- [ ] 🎨 **Animation Dealer:** Tay bốc bài, lật bài, cầm súng, cầm vật phẩm, bị bắn nát mặt.
- [ ] 💻 **Code `DealerAI.gd`:** 
    - Đọc bài: Tự ghép Sảnh/Thùng/Đôi. Nếu bài rác -> Discard.
    - Dùng Item: Biết dùng kính lúp trước khi bốc đạn.
    - Ra quyết định: Bắn ai? (Dựa trên số Score kiếm được và máu hiện tại).

### Module 3.7: Vòng lặp & Dọn dẹp (Nodes `Cleanup`, `CheckDeath`, `Refresh`)
- [ ] 💻 **Code Cleanup:** Code hiệu ứng gom các lá bài đã đánh ném vào Mộ (Discard Pile). Lệnh bốc bù lại cho đủ 5 lá.
- [ ] 💻 **Check Hết Deck:** Nếu `Deck == 0`, lấy toàn bộ bài từ Mộ, gọi lại hàm Shuffle, đặt lại quỹ Discard. Chuyển Lượt (Turn Pass).
- [ ] 💻 **Check Chết:** Nếu `HP == 0` -> Kích hoạt màn hình End Game. Nếu Player thắng -> Load lại `Shop.tscn`.

---

## ✅ TIÊU CHÍ ĐÁNH GIÁ (Definition of Done)
Kế hoạch này đã đủ chi tiết đến mức độ **Node-level** (Chỉ rõ dùng Area3D, TextMesh) và **Script-level** (Tên từng file code và hàm cần viết). Chúng ta có thể dùng file này như một Check-list hàng ngày. Đánh dấu `[x]` vào ô nào đã hoàn thành.
