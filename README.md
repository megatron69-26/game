# Đề Án: Poker Roulette (Tên Tạm)

Một nguyên mẫu (Prototype) trò chơi lấy cảm hứng từ sự căng thẳng nghẹt thở của **Buckshot Roulette**, hệ thống tính điểm của **Balatro**, và cấu trúc đi map của **Slay The Spire**.

## Giới Thiệu
Thay vì nạp đạn thật/giả ngẫu nhiên, người chơi và AI (Dealer) sẽ thi đấu **Poker** dùng chung một bộ bài (Deck). Sức mạnh của hand bài tạo ra Điểm (Score). Người chơi sau đó sẽ nạp các loại **Đạn Đặc Biệt (Bullets)** đã mua trong Shop vào súng, quyết định bắn đối thủ (gây sát thương/hiệu ứng) hoặc tự bắn mình (để hồi máu/nhận buff) dựa trên số Điểm vừa kiếm được.

## Tài liệu Thiết kế
- Xem luồng trò chơi chi tiết tại: [FLOWCHART.md](FLOWCHART.md)
- Xem logic cơ chế, danh sách đạn và item tại: [GAMEPLAY_LOGIC.md](GAMEPLAY_LOGIC.md)

## Các bước tiếp theo để phát triển (Roadmap)
1. Dựng Greybox (Khối hộp) trên Godot hoặc Unity để test Core Loop.
2. Thiết kế UI: Bảng điểm (Base x Mult), Vali chứa Đạn, Bàn tay cầm bài.
3. Code State Machine cho Game Manager.
4. Tích hợp 3D Model thật từ bản decompile (chỉ dùng nội bộ để test hình ảnh).
