# Lõi Gameplay (Core Logic): Poker x Buckshot Roulette

Trò chơi là sự kết hợp giữa **Quản lý tài nguyên (Balatro/Slay the Spire)** và **Đấu trí sinh tử (Buckshot Roulette)**.

## 1. CÔNG THỨC SÁT THƯƠNG
Sát thương thực tế được tính qua 2 bước:
> **Total Score** = `(Base_Poker_Hand + Cấp thẻ bài) x Mult_Poker_Hand`
> **Final Damage / Effect** = `Total Score` chịu tác động bởi `Loại Đạn (Bullet)`

## 2. HỆ THỐNG ĐẠN DƯỢC (Bullets)
Đạn được mua trong Shop và lưu trong Vali (Inventory). Mỗi khi Play Hand, người chơi lắp 1 viên đạn vào để kích hoạt hiệu ứng:
*   🔴 **Đạn Rỗng (Hollow Point):** Nhân đôi Total Score (`Final Damage = Score x 2`). 
*   🟢 **Đạn Độc (Toxic Shell):** Gây sát thương ban đầu = 50%, 50% còn lại trừ dần vào 3 lượt tiếp theo (Poison).
*   🟡 **Đạn Cao Su (Rubber Slug):** Sát thương thấp, nhưng nếu Score vượt mốc nhất định sẽ làm Choáng (Stun) đối thủ 1 lượt.
*   🩸 **Đạn Ma Cà Rồng (Leech Round):** Gây sát thương và hồi máu bằng 30% lượng sát thương đó.
*   💉 **Đạn Hồi Máu (Stimpack):** **Đạn dùng để tự bắn mình**. Chuyển toàn bộ Total Score thành Máu (Heal) hoặc hệ số Mult cộng dồn cho hiệp sau.

## 3. CHIẾN THUẬT "CHUNG DECK"
*   Cả Player và Dealer dùng chung 1 bộ bài (Deck).
*   **Hệ quả:** Nếu bạn giữ bài đẹp (VD: 3 lá Át) trên tay hoặc đổi chúng vào mộ, Dealer sẽ mất cơ hội bốc được lá Át.

## 4. VẬT PHẨM BỔ TRỢ (Supplies)
Các vật phẩm lấy cảm hứng từ Buckshot Roulette nhưng điều chỉnh cho Poker:
*   🔎 **Kính lúp:** Lật xem lén 1 lá bài trên tay đối thủ hoặc 2 lá trên đỉnh Deck chung.
*   🍺 **Bia:** Bốc 1 lá trên đỉnh Deck ném thẳng vào Mộ (Đốt bài - Burn).
*   🪚 **Cưa tay:** Tăng sức mạnh của viên đạn tiếp theo.
*   🚬 **Thuốc lá:** Hồi máu trực tiếp (Một lượng nhỏ).
*   🔗 **Còng tay:** Khoá lượt (Skip turn) đối thủ. Mất quyền Discard và Play Hand.
