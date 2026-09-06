# KẾ HOẠCH PHÁT TRIỂN (TRACKING CHECKLIST)

---

## 🌍 PHẦN 1: HỆ THỐNG GLOBAL
- [ ] 💻 Code `RunManager.gd` (Lưu Tiền, Max HP, Master Deck).
- [ ] 💻 Code `Enums.gd` (Định nghĩa Game States).

---

## 🛒 PHẦN 2: SCENE CỬA HÀNG (`Shop.tscn`)
- [ ] 🎨 Dựng Scene Cửa hàng (Quầy đạn, Kệ vật phẩm).
- [ ] 🎨 Tạo Text3D hiển thị Giá tiền & Ví tiền.
- [ ] 🎨 Tạo cửa phòng (Tương tác Next Scene).
- [ ] 💻 Code `ShopManager.gd` (Giao dịch, ném đồ vào Inventory).
- [ ] 💻 Code chức năng Xóa bài (Deck Builder).

---

## ⚔️ PHẦN 3: SCENE CHIẾN ĐẤU (`BanChoi.tscn`)

### 3.1: Setup Bàn & Khởi tạo
- [ ] 🎨 Dựng Scene môi trường (Bàn, Ghế, Đèn, Dealer, Camera, Máy đo HP).
- [ ] 💻 Code `GameManager.gd` (Gắn HP, Khởi tạo ván).
- [ ] 💻 Code `DeckManager.gd` (Sinh bài, Xào bài, Chia bài lơ lửng).

### 3.2: Tương tác Bài 3D
- [ ] 🎨 Dựng Scene `Card3D.tscn` (Mesh lá bài, Hitbox).
- [ ] 🎨 Dựng vật thể tương tác: Chuông (Discard) và Cần gạt (Play Hand).
- [ ] 💻 Code `Card3D.gd` (Logic Hover, Click).
- [ ] 💻 Code `PlayerController.gd` (Raycast chọn bài, Discard, Rút bài bù).

### 3.3: Tính Điểm
- [ ] 🎨 Dựng Máy tính điểm (Hiện text Base x Mult).
- [ ] 💻 Code `PokerLogic.gd` (Thuật toán nhận diện Combo bài, xuất Damage).

### 3.4: Kho Đồ & Nạp Đạn
- [ ] 🎨 Dựng model & Hoạt ảnh Vali mở/đóng.
- [ ] 🎨 Dựng model Đạn & Các vật phẩm (Bia, Kính lúp, Thuốc...).
- [ ] 💻 Code `Inventory.gd` (Quản lý đạn/đồ mang từ Shop vào).
- [ ] 💻 Code tính năng cho từng loại Vật phẩm.

### 3.5: Bóp Cò & Sát Thương
- [ ] 🎨 Hoạt ảnh Súng (Lên nòng, Chĩa địch, Tự bẻ nòng).
- [ ] 🎨 VFX Súng nổ, Màn hình máu.
- [ ] 💻 Code `GunManager.gd` (Tính sát thương cuối dựa trên loại Đạn).
- [ ] 💻 Code logic Trừ máu & Áp dụng Hiệu ứng (Choáng/Độc).

### 3.6: Lượt Dealer AI
- [ ] 🎨 Hoạt ảnh Dealer (Bốc bài, Lật bài, Cầm súng, Chết, Trúng đạn).
- [ ] 💻 Code `DealerAI.gd` (Não AI: Đọc bài, tự tìm Combo tốt nhất).
- [ ] 💻 Code logic Quyết định mục tiêu bắn & Xài Item.

### 3.7: Vòng lặp & Dọn dẹp
- [ ] 💻 Code `Cleanup` (Gom bài ném vào Mộ).
- [ ] 💻 Code Reset Deck (Khi rút hết bài chung).
- [ ] 💻 Code `GameState` (Check Win/Lose, Đổi Turn).
