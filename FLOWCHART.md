# Sơ đồ Luồng Game (Core Loop)

Sơ đồ này mô tả vòng lặp cốt lõi của game (Core Loop), kết hợp cơ chế Cửa hàng (Shop), Tính điểm (Poker/Balatro) và Bắn súng (Buckshot Roulette). Bạn có thể xem biểu đồ trực quan bằng cách cài extention Mermaid trên VSCode hoặc dán vào [Mermaid Live](https://mermaid.live).

```mermaid
graph TD
    Start([Bắt đầu Game]) --> Shop["Cửa hàng (Mua Đạn & Vật phẩm)"]
    Shop --> InitRound["Khởi tạo: Trộn 1 Deck chung, Chia mỗi bên 5 lá, Cài đặt HP"]
    InitRound --> PlayerTurn((LƯỢT NGƯỜI CHƠI))

    %% --- LƯỢT NGƯỜI CHƠI ---
    PlayerTurn --> CheckStatusP{"Bị Trói/Choáng?"}
    CheckStatusP -- Có --> DealerTurn((LƯỢT DEALER))
    CheckStatusP -- Không --> ActionP{"Chọn Hành Động"}

    ActionP -- "Dùng Vật Phẩm" --> UseItem["Kính lúp, Bia, Thuốc..."] --> ActionP
    
    ActionP -- "Đổi Bài (Discard)" --> CheckDiscard{"Còn lượt Discard?"}
    CheckDiscard -- Còn --> DiscardCards["Bỏ N lá, Rút N lá từ Deck chung"] --> ActionP
    CheckDiscard -- Hết --> ActionP

    ActionP -- "Play Hand (Khai Hoả)" --> CalcScore["Tính Điểm Poker (Base x Mult)"]
    CalcScore --> OpenInv["Mở Vali: Chọn 1 viên Đạn (Bullet)"]
    OpenInv --> Aim{"Chọn Mục Tiêu"}

    Aim -- "Bắn Dealer (Đạn Xuyên, Đạn Độc...)" --> EffectDealer["Dealer chịu Sát thương & Hiệu ứng"]
    Aim -- "Tự bắn mình (Đạn Hồi máu, Buff...)" --> EffectPlayer["Người chơi Hồi máu & Nhận Buff"]

    EffectDealer --> Cleanup
    EffectPlayer --> Cleanup

    %% --- XỬ LÝ DỌN BÀI & KIỂM TRA ---
    Cleanup["Đưa bài đã đánh vào Mộ, Rút lại cho đủ 5 lá"] --> CheckDeath{"Trạng thái Máu"}
    
    CheckDeath -- "Dealer HP = 0" --> Win([CHIẾN THẮNG - Mở Shop màn sau])
    CheckDeath -- "Player HP = 0" --> Lose([GAME OVER])
    CheckDeath -- "Chưa ai chết" --> CheckDeck{"Deck chung hết bài?"}

    CheckDeck -- "Hết (Kết thúc Vòng)" --> Refresh["Xào lại Deck, Reset số lần Discard, Bơm thêm Item"]
    Refresh --> TurnPassCheck{"Ai vừa khai hoả?"}
    CheckDeck -- "Còn bài" --> TurnPassCheck
    
    TurnPassCheck -- "Người chơi vừa bắn" --> DealerTurn
    TurnPassCheck -- "Dealer vừa bắn" --> PlayerTurn

    %% --- LƯỢT DEALER ---
    DealerTurn --> CheckStatusD{"Bị Trói/Choáng?"}
    CheckStatusD -- Có --> PlayerTurn
    CheckStatusD -- Không --> AIAction["AI Suy nghĩ: Đổi bài, Dùng Item"]
    AIAction --> AICalcScore["AI Play Hand & Tính Điểm Poker"]
    AICalcScore --> AIChooseBullet["AI Mở Vali Chọn Đạn"]
    AIChooseBullet --> AIAim{"Chọn Mục Tiêu"}

    AIAim -- "Bắn Người chơi" --> AIEffectPlayer["Người chơi chịu Sát thương / Hiệu ứng"]
    AIAim -- "Tự bắn mình" --> AIEffectDealer["Dealer Hồi máu / Nhận Buff"]

    AIEffectPlayer --> Cleanup
    AIEffectDealer --> Cleanup
```
