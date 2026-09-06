# ROADMAP — TỆ NẠN

## Cách đọc roadmap

Mỗi đầu việc tương ứng với đúng một bước phát triển. Trong một đầu việc, hai
track được thực hiện song song:

- **Track 3D — Human:** model, scene, layout, transform, camera, ánh sáng,
  material và nghiệm thu visual.
- **Track Logic — Codex → Agy:** kiến trúc, prompt, GDScript, tích hợp logic,
  test và báo cáo.

Không track nào mặc định phải đi trước track còn lại. Nếu có phụ thuộc, đầu việc
phải ghi rõ phụ thuộc đó. Hai track chỉ hợp nhất tại checkpoint cuối của đầu
việc.

### Definition of Done

Một đầu việc chỉ được đóng khi:

1. Codex xác nhận code/test đạt yêu cầu.
2. Human nghiệm thu visual nếu đầu việc có thay đổi 3D.
3. Hai track đã tích hợp được với nhau nếu có điểm kết nối.
4. Gemini/Agy đã báo cáo file thay đổi, test đã chạy và lỗi còn lại.
5. Codex cập nhật trạng thái Git/tài liệu khi cần.

Nếu đầu việc không có thay đổi visual, Track 3D được đánh dấu `N/A` và Human
xác nhận không có phần visual cần nghiệm thu.

---

## ĐẦU VIỆC 1 — Roadmap bước 1: Nền tảng chạy được

**Mục tiêu:** biến prototype hiện tại thành một scene combat có thể chạy, chia
được 5 lá và có điểm kết nối rõ giữa scene với code.

### Track 1-3D — Human

- Gán model bàn, deck và các node cần thiết trong `ban_choi.tscn`.
- Xác nhận `DeckSpawnPoint` nằm đúng vị trí mong muốn.
- Hoàn thiện `Card3D.tscn` ở mức greybox và collision.
- Kiểm tra camera, ánh sáng và khả năng nhìn thấy lá bài.
- Nghiệm thu hiệu ứng lá bài bay ra và hover.

### Track 1-Logic — Codex → Agy

- Gắn `GameManager.gd` vào root combat.
- Gán `card_3d.tscn` vào `card_template`.
- Sửa lỗi chia 5 lá và quản lý vị trí runtime.
- Không tự thay đổi transform/model/material.
- Chạy scene, nhấn Space và báo cáo kết quả.

**Dependencies:** Không có.

**Checkpoint đóng việc:** F5 chạy được, Space chia 5 lá, Human xác nhận visual
và Codex xác nhận test pass.

---

## ĐẦU VIỆC 2 — Roadmap bước 2: Dữ liệu và bộ bài

**Mục tiêu:** có bộ bài 52 lá, hand của Player/Dealer, draw/discard và dữ liệu
lá bài độc lập với model 3D.

### Track 2-3D — Human

- Hoàn thiện visual Card3D ở mức cần thiết để hiển thị rank/suit.
- Xác nhận vùng tương tác và trạng thái selected/hovered.
- Không cần chờ code để tiếp tục chỉnh visual.

### Track 2-Logic — Codex → Agy

- Tạo `CardData`, rank, suit và card identity.
- Tạo `DeckManager` với draw pile và discard pile.
- Implement shuffle có RNG có thể inject để test deterministic.
- Implement deal 5 lá cho Player và Dealer.
- Tách dữ liệu gameplay khỏi `Card3D`.
- Viết test cho 52 lá, không trùng card và draw/discard.

**Dependencies:** ĐẦU VIỆC 1.

**Checkpoint đóng việc:** deck hoạt động độc lập, hand được tạo đúng, Card3D
hiển thị được dữ liệu cơ bản và test pass.

---

## ĐẦU VIỆC 3 — Roadmap bước 3: Poker scoring

**Mục tiêu:** nhận diện hand Poker và tạo Score theo công thức Base/Mult.

### Track 3-3D — Human

- Dựng khu vực hiển thị hand Player/Dealer.
- Dựng bảng hiển thị `Base x Mult = Score` nếu muốn.
- Nghiệm thu khả năng đọc hand và score trên bàn.

### Track 3-Logic — Codex → Agy

- Tạo `PokerLogic.gd` dạng pure logic, không phụ thuộc scene.
- Hỗ trợ các Poker hand trong phạm vi đã chốt.
- Định nghĩa bảng Base/Mult rõ ràng trong data/constants.
- Viết test cho từng hand và các trường hợp biên.

**Dependencies:** ĐẦU VIỆC 2.

**Checkpoint đóng việc:** cùng một hand luôn cho kết quả deterministic; score
hiển thị được nếu Track 3D đã dựng bảng score.

---

## ĐẦU VIỆC 4 — Roadmap bước 4: Turn state machine

**Mục tiêu:** điều khiển vòng đời một round và việc đổi lượt.

### Track 4-3D — Human

- Dựng/đặt vùng hoặc vật thể biểu thị Player turn, Dealer turn, discard và play.
- Nghiệm thu trạng thái UI/visual khi đổi lượt.

### Track 4-Logic — Codex → Agy

- Tạo state machine cho `PLAYER_TURN`, `DEALER_TURN`, `DISCARD`, `PLAY_HAND`,
  `RESOLVE`, `CLEANUP`, `WIN`, `LOSE`.
- Chặn action không hợp lệ theo state.
- Xử lý skip turn và chuyển lượt cơ bản.
- Viết test cho thứ tự state và transition không hợp lệ.

**Dependencies:** ĐẦU VIỆC 2 và 3.

**Checkpoint đóng việc:** một round giả lập chạy từ deal đến đổi lượt/resolve mà
không cần bullet thật.

---

## ĐẦU VIỆC 5 — Roadmap bước 5: Bullet và damage

**Mục tiêu:** biến Score thành damage/heal/status effect thông qua bullet.

### Track 5-3D — Human

- Dựng visual shotgun, bullet và target interaction.
- Dựng animation/VFX placeholder nếu muốn.
- Nghiệm thu feedback bắn trúng, tự bắn và áp dụng hiệu ứng.

### Track 5-Logic — Codex → Agy

- Tạo data/type cho Hollow Point, Toxic Shell, Rubber Slug, Leech Round và
  Stimpack.
- Tạo combat resolver.
- Implement damage, heal, poison, stun và modifier.
- Quy định rõ thứ tự resolve effect.
- Viết test cho từng bullet và trường hợp Player tự bắn mình.

**Dependencies:** ĐẦU VIỆC 3 và 4.

**Checkpoint đóng việc:** Score resolve thành kết quả combat deterministic và
Player/Dealer thay đổi HP/status đúng.

---

## ĐẦU VIỆC 6 — Roadmap bước 6: Inventory và item

**Mục tiêu:** quản lý bullet/item được mua và dùng trong combat.

### Track 6-3D — Human

- Dựng briefcase/vali và khu vực item.
- Đặt model bullet, kính lúp, bia, cưa, thuốc và còng nếu có.
- Nghiệm thu mở vali, chọn item và feedback dùng item.

### Track 6-Logic — Codex → Agy

- Tạo `Inventory.gd`.
- Implement số lượng, consume, preview và invalid-use handling.
- Implement Magnifier, Beer, Handsaw, Cigarettes và Handcuffs.
- Nối item với turn state và combat resolver.
- Viết test consume, không đủ item và skip turn.

**Dependencies:** ĐẦU VIỆC 4 và 5.

**Checkpoint đóng việc:** item dùng được trong round thật, không làm hỏng state
machine và inventory cập nhật chính xác.

---

## ĐẦU VIỆC 7 — Roadmap bước 7: Dealer AI

**Mục tiêu:** Dealer tự chơi một lượt hợp lệ và ra quyết định mục tiêu.

### Track 7-3D — Human

- Dựng animation/feedback Dealer bốc bài, dùng item và cầm súng.
- Nghiệm thu timing và readability của hành động AI.

### Track 7-Logic — Codex → Agy

- Tạo `DealerAI.gd` với decision pipeline rõ ràng.
- Đánh giá hand, discard, item usage và target selection.
- Tôn trọng thông tin Dealer thực sự được phép biết.
- Không dùng random không deterministic trong test.
- Viết test cho các tình huống AI cơ bản.

**Dependencies:** ĐẦU VIỆC 4, 5 và 6.

**Checkpoint đóng việc:** Player chơi được một trận tối thiểu với Dealer AI.

---

## ĐẦU VIỆC 8 — Roadmap bước 8: Cleanup, round và kết thúc trận

**Mục tiêu:** hoàn thiện vòng lặp trận đấu: dọn bài, reset deck, thắng/thua và
đổi round.

### Track 8-3D — Human

- Dựng feedback win/lose, reset bàn và chuyển round.
- Nghiệm thu object visual trở về trạng thái đúng.

### Track 8-Logic — Codex → Agy

- Implement cleanup hand/discard.
- Reset hoặc reshuffle deck theo luật đã chốt.
- Implement HP zero, win/lose và round transition.
- Đảm bảo không còn node card hoặc listener rác.
- Viết test cho deck empty, death và reset round.

**Dependencies:** ĐẦU VIỆC 7.

**Checkpoint đóng việc:** một trận hoàn chỉnh có thể bắt đầu, kết thúc và reset.

---

## ĐẦU VIỆC 9 — Roadmap bước 9: Run, Shop và progression

**Mục tiêu:** nối combat thành một run roguelike có tiền, shop và tiến trình map.

### Track 9-3D — Human

- Dựng Main Menu, Map, Shop và các điểm chuyển scene.
- Dựng quầy đạn, item, ví tiền và feedback mua hàng.
- Nghiệm thu luồng Menu → Map/Shop → Combat → kết quả.

### Track 9-Logic — Codex → Agy

- Tạo `RunManager` lưu tiền, max HP, master deck và progression.
- Tạo global state/enums nếu cần.
- Tạo `ShopManager` và giao dịch.
- Implement deck builder/remove card.
- Implement map node và scene transition.
- Viết test cho tiền, mua hàng, save/restore và progression.

**Dependencies:** ĐẦU VIỆC 8.

**Checkpoint đóng việc:** chơi được một run tối thiểu từ menu đến combat, thắng/
thua rồi quay lại progression.

---

## Quy tắc Git

- Mỗi đầu việc nên có commit riêng.
- Không force-push, `reset --hard` hoặc xóa thay đổi của Human.
- Không commit `Assets/` khi chưa xác nhận license.
- Track 3D và Track Logic có thể commit riêng, nhưng chỉ đánh dấu đầu việc
  hoàn tất tại checkpoint hợp nhất.
- Codex review trước khi merge hoặc chuyển đầu việc.
