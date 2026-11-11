# BỘ GIÁO DỤC VÀ ĐÀO TẠO
# TRƯỜNG ĐẠI HỌC VĂN HIẾN - KHOA CÔNG NGHỆ THÔNG TIN

---

## BÁO CÁO HỌC PHẦN: CHUYÊN ĐỀ 1 - KHAI THÁC HỆ CƠ SỞ DỮ LIỆU
**MÃ LỚP HỌC PHẦN:** INT51309 (6 TÍN CHỈ)  
**NĂM HỌC:** 2026 – 2027 | **HỌC KỲ:** HK01  
**ĐỀ TÀI:** THIẾT KẾ, TỐI ƯU VÀ KHAI THÁC CƠ SỞ DỮ LIỆU HỆ THỐNG QUẢN LÝ KHÁCH SẠN AN NHIÊN  
**GIẢNG VIÊN HƯỚNG DẪN:** ThS. LƯƠNG THÁI HIỀN (Email: hienlt@vhu.edu.vn)  
**SINH VIÊN PHỤ TRÁCH:** LÊ TRẦN TUẤN MINH (Trưởng nhóm - MSSV: 221A010993)  
**LỚP:** 11A1021 / T-ONLINE 29  
**TP. HỒ CHÍ MINH – NĂM 2026**

---

### MẪU 02: LỜI CẢM ƠN
Lời đầu tiên, em xin gửi lời cảm ơn chân thành và sâu sắc nhất đến Ban Giám hiệu cùng toàn thể quý Thầy Cô Khoa Công nghệ Thông tin – Trường Đại học Văn Hiến, những người đã truyền đạt những nền tảng tri thức quý báu về hệ cơ sở dữ liệu và công nghệ phần mềm trong suốt quá trình em học tập tại trường.

Đặc biệt, em xin bày tỏ lòng biết ơn sâu sắc đến **Thầy ThS. Lương Thái Hiền** – Giảng viên trực tiếp hướng dẫn học phần Chuyên đề 1. Thầy đã dành nhiều thời gian theo dõi sát sao, tận tình định hướng phương pháp tư duy kiến trúc, chỉ bảo chi tiết từ khâu chuẩn hóa lược đồ dữ liệu, thiết kế giao dịch ACID, cho đến việc lập trình các thủ tục và hàm nghiệp vụ an toàn. Những lời khuyên của Thầy là kim chỉ nam giúp em hoàn thành phần công việc của mình đúng tiến độ và đạt chuẩn mực khoa học.

Mặc dù đã rất nỗ lực hoàn thành phần việc được giao, song do kiến thức và kinh nghiệm thực tiễn còn bước đầu trau dồi nên báo cáo khó tránh khỏi những thiếu sót nhất định. Em rất mong nhận được những ý kiến đóng góp quý báu từ Thầy để hoàn thiện hơn nữa.

*Tp. Hồ Chí Minh, ngày ... tháng ... năm 2026*  
**Sinh viên thực hiện:**  
**Lê Trần Tuấn Minh**

---

### MẪU 03: LỜI CAM ĐOAN
> *"Tôi cam đoan đây là công trình nghiên cứu của riêng tôi, do tôi tự thực hiện, không sao chép, vay mượn từ các công trình nghiên cứu khoa học khác. Đảm bảo mọi tài liệu tham khảo đều được trích dẫn, ghi chú đầy đủ."*

Toàn bộ các nội dung trong phần báo cáo này bao gồm: Khảo sát nghiệp vụ khách sạn An Nhiên, thiết kế sơ đồ ERD 10 bảng, lập bảng từ điển dữ liệu, các phép chứng minh toán học chuẩn hóa dữ liệu (1NF, 2NF, 3NF, BCNF), cùng mã nguồn và giải thuật của 2 Hàm và 2 Stored Procedures giao dịch ACID (`sp_ThucHienCheckIn`, `sp_ThucHienCheckOut`, `fn_TimPhongTrong`, `fn_TinhToanChiPhiDatPhong`) hoàn toàn do bản thân em tự nghiên cứu, thiết kế và kiểm thử thực nghiệm trên hệ quản trị PostgreSQL 15+ (Supabase Cloud).

Mọi thông tin tham khảo trích dẫn đều có nguồn gốc rõ ràng. Em xin hoàn toàn chịu trách nhiệm trước Nhà trường và Khoa về tính trung thực của lời cam đoan này.

*Tp. Hồ Chí Minh, ngày ... tháng ... năm 2026*  
**Sinh viên thực hiện:**  
*(Ký và ghi rõ họ tên)*  
**Lê Trần Tuấn Minh**

---

### BẢNG PHÂN CÔNG NHIỆM VỤ CỦA LÊ TRẦN TUẤN MINH
| Hạng mục | Chi tiết công việc phụ trách | Sản phẩm đầu ra | Tỷ lệ hoàn thành |
| :--- | :--- | :--- | :---: |
| **Kỹ thuật CSDL** | • Thiết kế 10 bảng thực thể CSDL cốt lõi và quan hệ PK/FK<br>• Lập trình Hàm tìm phòng trống `fn_TimPhongTrong`<br>• Lập trình Hàm tính chi phí & cọc `fn_TinhToanChiPhiDatPhong`<br>• Lập trình Thủ tục Check-in nhận phòng `sp_ThucHienCheckIn` (ACID)<br>• Lập trình Thủ tục Check-out quyết toán `sp_ThucHienCheckOut` (ACID) | • `supabase_schema_and_data.sql`<br>• `tuanminh_functions_and_procedures.sql`<br>• Nhánh Git `tuanminh` trên GitHub | **100%** (Xuất sắc) |
| **Báo cáo Thuyết minh** | • Biên soạn Phần I: Mở đầu (đầy đủ 7 mục)<br>• Biên soạn Chương 1: Giới thiệu chung và Khảo sát nghiệp vụ<br>• Biên soạn Chương 3 (Mục 3.1 - 3.5): ERD, Data Dictionary, Chứng minh 3NF/BCNF<br>• Biên soạn Chương 4 (Mục 4.3): Giải thuật & Kịch bản kiểm thử Stored Procedures | File báo cáo thuyết minh hoàn chỉnh nộp Thầy | **100%** (Xuất sắc) |

---

# PHẦN I: MỞ ĐẦU (1 - 2 TRANG CHUẨN KHOA)

### 1. Lý do chọn đề tài (Tính cấp thiết của đề tài)
Ngành kinh doanh dịch vụ khách sạn hiện đại đòi hỏi tốc độ xử lý giao dịch tức thời và độ chính xác dữ liệu tuyệt đối. Mọi thao tác thường nhật của bộ phận lễ tân từ việc tra cứu buồng phòng khả dụng, tiếp nhận tiền cọc, làm thủ tục nhận phòng (Check-in), tính toán chi phí các dịch vụ phụ trợ phát sinh (minibar, giặt ủi, điểm tâm), khấu trừ mã giảm giá (voucher) cho đến thủ tục trả phòng quyết toán (Check-out) đều tác động trực tiếp đến dòng tiền doanh thu và mức độ hài lòng của khách hàng.

Tuy nhiên, trên thực tế nhiều cơ sở lưu trú vừa và nhỏ vẫn quản lý buồng phòng và giao dịch dựa trên sổ sách ghi chép hoặc các bảng tính Excel rời rạc. Cách làm thủ công này bộc lộ những rủi ro đặc biệt nghiêm trọng: xung đột lịch buồng phòng (Double-booking) khi hai nhân viên cùng phân phối một phòng trống cho hai khách khác nhau trong cùng một khoảng ngày; tranh chấp số lượng mã voucher ưu đãi khi nhiều khách hàng cùng áp dụng một mã duy nhất vào cùng một thời điểm; hoặc nhân viên quên cập nhật trạng thái phòng khiến phòng đã khách trả nhưng hệ thống vẫn báo bận, làm sụt giảm công suất khai thác kinh doanh.

Để giải quyết triệt để các rủi ro trên, việc thiết kế một cơ sở dữ liệu quan hệ đạt chuẩn hóa cao (tối thiểu 3NF/BCNF), đồng thời khai thác sâu các tính năng nâng cao của hệ quản trị như Stored Procedures, Functions, Triggers toàn vẹn dữ liệu, kiểm soát giao dịch theo chuẩn ACID và tối ưu hóa câu truy vấn bằng chỉ mục đa cột là giải pháp cốt lõi mang tính cấp thiết hàng đầu.

### 2. Mục đích nghiên cứu
- Thiết kế và cài đặt hoàn chỉnh cơ sở dữ liệu quan hệ cho Hệ thống Quản lý Khách sạn An Nhiên đạt chuẩn hóa 3NF/BCNF, loại trừ triệt để các hiện tượng dị thường khi thêm, sửa và xóa dữ liệu.
- Tự động hóa các nghiệp vụ lễ tân và lưu trú bằng các Stored Procedures và Functions có kiểm soát giao dịch ACID, loại bỏ hoàn toàn các sai sót do thao tác thủ công.
- Cung cấp khả năng tìm kiếm buồng phòng trống thông minh theo thời gian thực và tự động hóa quy trình quyết toán doanh thu.

### 3. Đối tượng nghiên cứu
- Dữ liệu quản lý khách sạn: Thông tin khách hàng, sơ đồ buồng phòng theo tầng và loại phòng, hồ sơ đặt phòng, phiếu thu đặt cọc, bảng kê chi tiết dịch vụ, mã giảm giá và hóa đơn thanh toán.
- Hệ quản trị cơ sở dữ liệu quan hệ PostgreSQL phiên bản 15+ triển khai trên nền tảng điện toán đám mây Supabase Cloud.

### 4. Nhiệm vụ nghiên cứu
- Khảo sát toàn diện quy trình vận hành và nghiệp vụ thực tế tại Khách sạn An Nhiên.
- Xây dựng sơ đồ thực thể quan hệ (ERD) gồm 10 bảng thực thể cốt lõi và lập bảng từ điển dữ liệu chi tiết cho từng thuộc tính.
- Chứng minh toán học tính chuẩn hóa của lược đồ cơ sở dữ liệu đạt các dạng chuẩn 1NF, 2NF, 3NF và BCNF.
- Lập trình 2 Hàm tìm phòng/tính cọc và 2 Thủ tục giao dịch Check-in/Check-out an toàn (ACID).
- Thực hiện kiểm thử kịch bản giao dịch thực tế trên Supabase SQL Editor.

### 5. Phương pháp nghiên cứu
- Phương pháp nghiên cứu lý thuyết: Nghiên cứu lý thuyết cơ sở dữ liệu quan hệ, lý thuyết phụ thuộc hàm của Codd, các dạng chuẩn hóa dữ liệu và kiến trúc giao dịch ACID.
- Phương pháp nghiên cứu thực nghiệm: Cài đặt và thực thi toàn bộ kịch bản SQL trực tiếp trên hệ thống PostgreSQL 15+ thông qua Supabase SQL Editor, tiến hành kiểm thử các trường hợp dữ liệu biên và đo lường thời gian thực thi.

### 6. Các kết quả đạt được của đề tài
- Xây dựng thành công cơ sở dữ liệu hoàn chỉnh gồm 10 bảng thực thể có ràng buộc toàn vẹn chặt chẽ, đáp ứng đầy đủ yêu cầu quản lý khách sạn hiện đại.
- Hiện thực hoàn chỉnh 2 hàm thông minh và 2 thủ tục nghiệp vụ giao dịch kiểm soát hoàn toàn vòng đời nhận phòng và quyết toán buồng phòng.
- Đóng gói toàn bộ mã nguồn chuyên đề và quản lý phiên bản chuyên nghiệp trên nhánh Git `tuanminh`: https://github.com/TuanMinh685/ChuyenDe1/tree/tuanminh.

### 7. Kết cấu của báo cáo Chuyên đề 1
Báo cáo được bố cục thành 4 chương nội dung chính:
- **Chương 1:** Giới thiệu chung về đề tài.
- **Chương 2:** Tổng hợp kiến thức liên quan.
- **Chương 3:** Phân tích nhiệm vụ và lựa chọn giải pháp.
- **Chương 4:** Thiết kế, hiện thực và đánh giá kết quả thực nghiệm.
Cuối báo cáo là Phần III: Kết luận và đề nghị, Danh mục tài liệu tham khảo và Phần Phụ lục.

---

# CHƯƠNG 1. GIỚI THIỆU CHUNG VỀ ĐỀ TÀI

### 1.1. Bối cảnh ra đời và nhu cầu thực tiễn
Trong bối cảnh nền kinh tế du lịch và dịch vụ phát triển mạnh mẽ, khách sạn An Nhiên định vị là chuỗi khách sạn boutique tiêu chuẩn 3 - 4 sao, quy mô từ 30 đến 100 phòng tại các đô thị du lịch trọng điểm. Để cạnh tranh và tối ưu hóa chi phí vận hành, ban giám đốc khách sạn đặt mục tiêu chuyển đổi số toàn diện công tác quản lý lễ tân, buồng phòng và tài chính.

Nhu cầu thực tiễn đặt ra là cần có một hệ thống cơ sở dữ liệu tập trung, đảm bảo dữ liệu luôn nhất quán trong thời gian thực, cho phép bộ phận lễ tân tại quầy thao tác đặt phòng, nhận phòng và thanh toán chỉ trong vài thao tác chuột. Đồng thời, ban giám đốc cần có ngay các con số thống kê tức thời về doanh thu tiền phòng, doanh thu dịch vụ, tỷ lệ lấp đầy phòng theo từng phân khúc để kịp thời đưa ra các chiến lược giá linh hoạt theo mùa vụ.

### 1.2. Khảo sát hiện trạng và quy trình nghiệp vụ khách sạn An Nhiên
Qua quá trình khảo sát trực tiếp, quy trình vận hành của Khách sạn An Nhiên bao gồm các phân hệ nghiệp vụ cốt lõi sau:

**a) Nghiệp vụ Quản lý buồng phòng và loại phòng:**  
Khách sạn phân bổ các phòng vật lý theo từng Tầng (Tầng 1, Tầng 2, Tầng 3...) và thuộc một Loại phòng cụ thể (Phòng Standard Đơn, Phòng Superior Đôi, Phòng Suite Gia đình). Mỗi loại phòng có đơn giá niêm yết theo đêm (GiaMotDem), sức chứa tối đa và diện tích tiêu chuẩn. Mỗi buồng phòng tại mọi thời điểm đều được gán một trong bốn trạng thái vận hành: 'Hoạt động/Trống' (sẵn sàng đón khách), 'Đang sử dụng' (đang có khách ở), 'Chờ dọn dẹp' (khách vừa trả phòng, nhân viên buồng phòng đang vệ sinh), và 'Bảo trì' (hư hỏng thiết bị, tạm ngừng kinh doanh).

**b) Nghiệp vụ Đặt phòng (Reservation) và Đặt cọc:**  
Khi khách hàng có nhu cầu lưu trú, nhân viên tiếp nhận thông tin họ tên, số điện thoại, số CCCD/Hộ chiếu và quốc tịch. Nhân viên chọn ngày nhận phòng (NgayNhan) và ngày trả phòng (NgayTra). Hệ thống tự động tính số đêm lưu trú: `SoDem = GREATEST(1, NgayTra - NgayNhan)`. Để giữ phòng chắc chắn, khách hàng phải thanh toán khoản tiền đặt cọc tối thiểu bằng 30% tổng chi phí lưu trú dự kiến. Khi tiếp nhận cọc thành công, đơn đặt phòng được tạo ở trạng thái 'Đã đặt'.

**c) Nghiệp vụ Nhận phòng (Check-in):**  
Vào ngày nhận phòng, khách đến quầy lễ tân xuất trình giấy tờ tùy thân. Nhân viên kiểm tra đơn đặt phòng trên hệ thống. Khi lễ tân bấm xác nhận nhận phòng, hệ thống tự động kiểm tra điều kiện an toàn, đổi trạng thái đơn sang 'Đang ở', ghi nhận thời gian nhận phòng thực tế (GioNhanThucTe) và đồng thời chuyển trạng thái buồng phòng vật lý sang 'Đang sử dụng'.

**d) Nghiệp vụ Sử dụng dịch vụ phát sinh và Quyết toán (Check-out):**  
Trong suốt thời gian lưu trú, khách hàng có thể sử dụng các dịch vụ gia tăng như nước uống/đồ ăn nhẹ tại minibar, dịch vụ giặt là hấp sấy, đặt suất ăn sáng buffet hoặc dịch vụ xe đưa đón sân bay. Mọi khoản chi phí dịch vụ đều được lễ tân ghi nhận vào chi tiết hóa đơn tương ứng với phòng của khách.  
Khi khách làm thủ tục Check-out trả phòng, hệ thống tự động thực hiện quyết toán:  
$$\text{Tổng tiền thanh toán} = \text{Tiền phòng thực tế} + \text{Tổng tiền dịch vụ} - \text{Tiền cọc đã thu} - \text{Tiền giảm giá voucher}$$  
Khách hàng thanh toán số tiền còn lại qua tiền mặt, thẻ ngân hàng hoặc quét mã QR. Sau khi thanh toán hoàn tất, đơn đặt phòng chuyển sang 'Đã trả', hóa đơn chuyển sang 'Đã thanh toán', và phòng lập tức được chuyển trạng thái sang 'Chờ dọn dẹp' để báo cho bộ phận buồng phòng.

### 1.3. Mục tiêu và phạm vi nghiên cứu của đề tài
- **Phạm vi dữ liệu:** Xử lý toàn bộ các thực thể: Khách hàng, Buồng phòng, Loại phòng, Đặt phòng, Phiếu cọc, Hóa đơn, Dịch vụ, Voucher và Phân quyền tài khoản.
- **Mục tiêu kỹ thuật của Tuấn Minh:** Xây dựng thành công hệ thống bảng đạt chuẩn 3NF/BCNF, thiết lập các ràng buộc toàn vẹn và lập trình các thủ tục/hàm giao dịch ACID đảm bảo tự động hóa hoàn toàn quy trình Check-in và Check-out.

---

# CHƯƠNG 3. PHÂN TÍCH NHIỆM VỤ VÀ LỰA CHỌN GIẢI PHÁP (MỤC 3.1 – 3.5)

### 3.1. Phân tích các yêu cầu chức năng và phi chức năng của hệ CSDL
Từ khảo sát nghiệp vụ thực tế, hệ thống cơ sở dữ liệu cần giải quyết 4 bài toán kỹ thuật trọng tâm:
1. **Bài toán Quản lý trạng thái và tính khả dụng của phòng:** Loại trừ phòng đang có khách ở hoặc đã có đơn đặt trùng khoảng ngày.
2. **Bài toán Toàn vẹn tham chiếu và lịch sử giao dịch:** Dù loại phòng thay đổi giá niêm yết trong tương lai thì các đơn đặt phòng và hóa đơn trong quá khứ không được phép thay đổi số liệu doanh thu.
3. **Bài toán Giao dịch an toàn (Transaction Processing):** Quy trình nhận phòng và trả phòng liên quan đến nhiều bảng dữ liệu khác nhau, nếu một bước gặp lỗi thì toàn bộ giao dịch phải được khôi phục (ROLLBACK), không để lại dữ liệu rác.
4. **Bài toán Khấu trừ cọc và Voucher:** Đảm bảo số tiền cọc 30% và voucher ưu đãi được trừ chính xác vào hóa đơn quyết toán cuối cùng.

### 3.2. So sánh và lựa chọn giải pháp hệ quản trị cơ sở dữ liệu
Nhóm đã tiến hành đánh giá so sánh giữa 3 hệ quản trị CSDL phổ biến:
- **MS SQL Server:** Mạnh mẽ trên Windows, tuy nhiên chi phí bản quyền thương mại rất cao, khó khăn khi triển khai Cloud phi tập trung.
- **MySQL 8.0:** Miễn phí nhưng ngôn ngữ thủ tục lưu trữ hạn chế, cơ chế xử lý ngoại lệ (Exception) không linh hoạt bằng PostgreSQL.
- **PostgreSQL 15+ (Supabase Cloud):** Hệ quản trị CSDL quan hệ mã nguồn mở tiên tiến nhất, hỗ trợ kiểu dữ liệu đa dạng (JSONB, Array, UUID), cơ chế lập trình thủ tục PL/pgSQL cực kỳ mạnh mẽ, hỗ trợ đầy đủ chuẩn ACID, có sẵn Connection Pooler và công cụ phân tích truy vấn `EXPLAIN ANALYZE` sâu sắc.
==> **Lựa chọn:** Nhóm quyết định lựa chọn **PostgreSQL 15+ trên nền tảng Supabase Cloud**.

### 3.3. Thiết kế mô hình quan hệ thực thể (Sơ đồ ERD)
Lược đồ CSDL Quản lý Khách sạn An Nhiên gồm 10 bảng thực thể cốt lõi:
- `LoaiPhong` (1) ──── (N) `Phong`: Một loại phòng có nhiều buồng phòng.
- `Phong` (1) ──── (N) `DatPhong`: Một phòng có thể được đặt nhiều lần theo các khoảng ngày khác nhau.
- `KhachHang` (1) ──── (N) `DatPhong`: Một khách hàng có thể thực hiện nhiều lượt đặt phòng.
- `NhanVien` (1) ──── (N) `DatPhong`: Nhân viên tiếp nhận đơn đặt phòng.
- `NhanVien` (1) ──── (1) `TaiKhoan`: Mỗi nhân viên có một tài khoản hệ thống.
- `DatPhong` (1) ──── (1) `HoaDon`: Mỗi đơn hoàn tất lưu trú được quyết toán bằng một hóa đơn duy nhất.
- `HoaDon` (1) ──── (N) `ChiTietHoaDon`: Một hóa đơn gồm nhiều dòng chi tiết dịch vụ.
- `DichVu` (1) ──── (N) `ChiTietHoaDon`: Dịch vụ xuất hiện trên chi tiết hóa đơn.
- `Voucher` (1) ──── (N) `HoaDon`: Mã voucher được áp dụng cho hóa đơn.
- `PhuongThucThanhToan` (1) ──── (N) `HoaDon`: Hóa đơn được thanh toán qua một phương thức xác định.

### 3.4. Từ điển dữ liệu chi tiết của 10 bảng thực thể cốt lõi

**Bảng 3.1: Từ điển dữ liệu bảng `LoaiPhong`**
| Tên thuộc tính | Kiểu dữ liệu | Khóa | Ràng buộc toàn vẹn | Ý nghĩa nghiệp vụ |
| :--- | :--- | :---: | :--- | :--- |
| `MaLoai` | `SERIAL` | **PK** | NOT NULL | Mã loại phòng (Khóa chính tự tăng) |
| `TenLoai` | `VARCHAR(50)`| | NOT NULL, UNIQUE | Tên hạng phòng (Standard, Deluxe, VIP) |
| `GiaMotDem` | `NUMERIC(18,2)`| | CHECK (GiaMotDem > 0) | Đơn giá niêm yết cho một đêm lưu trú |
| `SoNguoiToiDa`| `INT` | | CHECK (SoNguoiToiDa >= 1) | Số lượng khách ở tối đa quy định |
| `DienTich` | `NUMERIC(6,2)`| | CHECK (DienTich > 0) | Diện tích phòng tính theo mét vuông |

**Bảng 3.2: Từ điển dữ liệu bảng `Phong`**
| Tên thuộc tính | Kiểu dữ liệu | Khóa | Ràng buộc toàn vẹn | Ý nghĩa nghiệp vụ |
| :--- | :--- | :---: | :--- | :--- |
| `MaPhong` | `SERIAL` | **PK** | NOT NULL | Mã định danh buồng phòng |
| `SoPhong` | `VARCHAR(20)` | **UK** | NOT NULL, UNIQUE | Số phòng vật lý (Ví dụ: P101, P201, P305) |
| `Tang` | `INT` | | CHECK (Tang >= 1) | Tầng của phòng |
| `MaLoai` | `INT` | **FK** | NOT NULL, REFERENCES LoaiPhong | Khóa ngoại tham chiếu đến loại phòng |
| `TinhTrang` | `VARCHAR(30)` | | DEFAULT 'Hoạt động' | Trạng thái: Hoạt động, Đang ở, Chờ dọn, Bảo trì |

**Bảng 3.3: Từ điển dữ liệu bảng `KhachHang`**
| Tên thuộc tính | Kiểu dữ liệu | Khóa | Ràng buộc toàn vẹn | Ý nghĩa nghiệp vụ |
| :--- | :--- | :---: | :--- | :--- |
| `MaKH` | `SERIAL` | **PK** | NOT NULL | Mã định danh khách hàng tự tăng |
| `HoTen` | `VARCHAR(100)`| | NOT NULL | Họ và tên khách lưu trú |
| `SoDienThoai` | `VARCHAR(15)` | | NOT NULL | Số điện thoại liên lạc |
| `CCCD` | `VARCHAR(20)` | **UK** | NOT NULL, UNIQUE | Số CCCD hoặc Hộ chiếu định danh cá nhân |
| `QuocTich` | `VARCHAR(50)` | | DEFAULT 'Việt Nam' | Quốc tịch khách hàng |

**Bảng 3.4: Từ điển dữ liệu bảng `DatPhong`**
| Tên thuộc tính | Kiểu dữ liệu | Khóa | Ràng buộc toàn vẹn | Ý nghĩa nghiệp vụ |
| :--- | :--- | :---: | :--- | :--- |
| `MaDatPhong` | `SERIAL` | **PK** | NOT NULL | Khóa chính tự tăng của đơn đặt phòng |
| `MaDat` | `VARCHAR(20)` | **UK** | NOT NULL, UNIQUE | Mã đơn thân thiện (DP-YYYYMMDD-XXX) |
| `MaKH` | `INT` | **FK** | NOT NULL, REFERENCES KhachHang | Khách hàng đứng tên đặt phòng |
| `MaPhong` | `INT` | **FK** | NOT NULL, REFERENCES Phong | Phòng vật lý được phân bổ |
| `NgayNhan` | `DATE` | | NOT NULL | Ngày dự kiến nhận phòng |
| `NgayTra` | `DATE` | | NOT NULL, CHECK (NgayTra > NgayNhan) | Ngày dự kiến trả phòng |
| `SoDem` | `INT` | | GENERATED ALWAYS AS (...) STORED | Tự tính: GREATEST(1, NgayTra - NgayNhan) |
| `TongTien` | `NUMERIC(18,2)`| | CHECK (TongTien >= 0) | Tổng tiền phòng ước tính của cả đợt |
| `TienCoc` | `NUMERIC(18,2)`| | DEFAULT 0, CHECK (TienCoc >= 0) | Số tiền đặt cọc trước (30%) |
| `TrangThai` | `VARCHAR(20)` | | CHECK IN ('Đã đặt','Đang ở','Đã trả','Đã hủy') | Vòng đời của đơn đặt phòng |
| `GioNhanThucTe`| `TIMESTAMP` | | NULL | Thời điểm lễ tân làm thủ tục Check-in |
| `GioTraThucTe` | `TIMESTAMP` | | NULL | Thời điểm khách làm thủ tục Check-out |

**Bảng 3.5: Từ điển dữ liệu bảng `HoaDon`**
| Tên thuộc tính | Kiểu dữ liệu | Khóa | Ràng buộc toàn vẹn | Ý nghĩa nghiệp vụ |
| :--- | :--- | :---: | :--- | :--- |
| `MaHoaDon` | `VARCHAR(20)` | **PK** | NOT NULL | Mã hóa đơn quyết toán (HDYYYYMMDDXXXX) |
| `MaDatPhong` | `VARCHAR(30)` | | NULL | Mã đơn đặt phòng tương ứng |
| `NgayLap` | `TIMESTAMP` | | DEFAULT CURRENT_TIMESTAMP | Thời điểm lập hóa đơn |
| `NgayThanhToan`| `TIMESTAMP` | | NULL | Thời điểm hoàn tất thanh toán |
| `TienPhong` | `NUMERIC(18,2)`| | NOT NULL, CHECK (TienPhong >= 0) | Tổng tiền phòng thực tế |
| `TienDichVu` | `NUMERIC(18,2)`| | DEFAULT 0, CHECK (TienDichVu >= 0) | Tổng tiền các dịch vụ phát sinh |
| `TienGiamGia` | `NUMERIC(18,2)`| | DEFAULT 0 | Giá trị giảm trừ từ mã Voucher |
| `TienDatCoc` | `NUMERIC(18,2)`| | DEFAULT 0 | Số tiền cọc đã khấu trừ ra |
| `TongTien` | `NUMERIC(18,2)`| | NOT NULL | `= TienPhong + TienDichVu - TienCoc - GiamGia` |
| `MaPTTT` | `VARCHAR(10)` | **FK** | NOT NULL, REFERENCES PhuongThucThanhToan | Phương thức: VNPAY, MOMO, TM, POS |
| `MaVoucher` | `INT` | **FK** | NULL, REFERENCES Voucher | Mã voucher áp dụng cho hóa đơn |
| `TrangThai` | `VARCHAR(30)` | | DEFAULT 'Đã thanh toán' | Trạng thái hóa đơn |

### 3.5. Chứng minh chuẩn hóa dữ liệu (1NF - 2NF - 3NF - BCNF)
Để chứng minh hệ thống đạt chuẩn hóa, ta phân tích quan hệ đại diện chứa nhiều thuộc tính giao dịch:
Xét quan hệ tổng quát:  
$$R(\underline{MaDatPhong}, MaKH, HoTen, CCCD, MaPhong, SoPhong, MaLoai, TenLoai, GiaMotDem, NgayNhan, NgayTra, TienPhong, TienCoc)$$

**1. Chứng minh đạt Dạng chuẩn 1 (1NF):**  
- *Định nghĩa:* Một quan hệ đạt 1NF nếu và chỉ nếu tất cả các thuộc tính đều mang giá trị nguyên tố (Atomic values), không chứa cột đa trị hay nhóm lặp.  
- *Phân tích:* Trong thiết kế, các thông tin đa trị như "Dịch vụ đã sử dụng" không được lưu dưới dạng chuỗi ngăn cách trong bảng `HoaDon`, mà được tách thành bảng riêng biệt `ChiTietHoaDon`. Mỗi ô dữ liệu trong toàn bộ 10 bảng đều chỉ lưu đúng 1 giá trị đơn lẻ thuộc miền giá trị cơ bản (INTEGER, VARCHAR, NUMERIC, DATE, TIMESTAMP). Do đó, lược đồ đạt chuẩn **1NF**.

**2. Chứng minh đạt Dạng chuẩn 2 (2NF):**  
- *Định nghĩa:* Một quan hệ đạt 2NF nếu nó đã đạt 1NF và mọi thuộc tính không khóa đều phụ thuộc hàm đầy đủ vào khóa chính toàn bộ (Full Functional Dependency), không phụ thuộc vào bất kỳ một tập con thực sự nào của khóa chính.  
- *Phân tích:*  
  + Trong bảng `DatPhong`, khóa chính là đơn khóa `MaDatPhong` (chỉ gồm 1 thuộc tính). Do khóa chính không phải là khóa ghép nên không thể tồn tại hiện tượng phụ thuộc hàm từng phần vào khóa. Mọi thuộc tính không khóa (`NgayNhan`, `NgayTra`, `TongTien`, `TienCoc`...) đều phụ thuộc hàm đầy đủ vào `MaDatPhong`.  
  + Trong bảng chi tiết `ChiTietHoaDon`, khóa chính là đơn khóa `MaCTHD` tự tăng, các thuộc tính `SoLuong`, `DonGia`, `ThanhTien` phụ thuộc toàn bộ vào `MaCTHD`.  
  Do đó, toàn bộ cơ sở dữ liệu đạt chuẩn **2NF**.

**3. Chứng minh đạt Dạng chuẩn 3 (3NF):**  
- *Định nghĩa:* Một quan hệ đạt 3NF nếu nó đã đạt 2NF và không tồn tại bất kỳ phụ thuộc hàm bắc cầu nào giữa các thuộc tính không khóa ($X \rightarrow Y$ và $Y \rightarrow Z$).  
- *Phân tích:*  
  Trong bài toán buồng phòng, nếu ta lưu `TenLoai` và `GiaMotDem` trực tiếp trong bảng `Phong`, sẽ phát sinh phụ thuộc hàm bắc cầu:  
  $$MaPhong \rightarrow MaLoai \quad \text{và} \quad MaLoai \rightarrow (TenLoai, GiaMotDem) \implies MaPhong \rightarrow (TenLoai, GiaMotDem)$$  
  (trong đó `MaLoai` không phải là khóa chính của bảng `Phong`).  
  *Giải pháp thiết kế:* Em đã tách riêng thực thể `LoaiPhong(MaLoai, TenLoai, GiaMotDem, SoNguoiToiDa)`. Bảng `Phong` chỉ giữ lại khóa ngoại `MaLoai`. Khi đơn giá một loại phòng thay đổi, ta chỉ cập nhật tại 1 dòng duy nhất trong `LoaiPhong`, loại trừ triệt để dị thường cập nhật (Update Anomaly).  
  Tương tự, thông tin khách hàng (`HoTen`, `SoDienThoai`, `CCCD`) được tách ra bảng `KhachHang` chứ không lưu lặp lại trong `DatPhong`. Do đó, không tồn tại phụ thuộc bắc cầu, lược đồ đạt chuẩn **3NF**.

**4. Chứng minh đạt Dạng chuẩn Boyce-Codd (BCNF):**  
- *Định nghĩa:* Một quan hệ đạt BCNF nếu đối với mọi phụ thuộc hàm không tầm thường $X \rightarrow Y$, vế trái $X$ bắt buộc phải là một Siêu khóa (Superkey).  
- *Phân tích:* Trong tất cả 10 bảng của hệ thống, các phụ thuộc hàm đều có vế trái là Khóa chính (`MaLoai`, `MaPhong`, `MaKH`, `MaDatPhong`, `MaHoaDon`...) hoặc Khóa ứng viên thay thế (`SoPhong`, `CCCD`, `MaDat`). Không có bất kỳ thuộc tính không khóa nào xác định được thuộc tính khóa. Do đó, cơ sở dữ liệu đạt chuẩn **BCNF**.

---

# CHƯƠNG 4: MỤC 4.3 - HIỆN THỰC THỦ TỤC VÀ HÀM NGHIỆP VỤ GIAO DỊCH AN TOÀN (ACID)

### 4.3.1. Hàm tìm kiếm phòng trống thông minh (`fn_TimPhongTrong`)
- **Mục đích:** Tìm kiếm danh sách buồng phòng đang sẵn sàng đón khách trong một khoảng ngày cụ thể, thỏa mãn điều kiện số người ở và loại phòng mong muốn.
- **Thuật toán loại trừ giao thoa thời gian (Interval Overlap Condition):**  
  Phòng khả dụng là phòng không tồn tại bất kỳ đơn đặt phòng nào đang ở trạng thái 'Đã đặt' hoặc 'Đang ở' thỏa mãn điều kiện:
  $$\text{NgayNhanYeuCau} < \text{DatPhong.NgayTra} \quad \text{VÀ} \quad \text{NgayTraYeuCau} > \text{DatPhong.NgayNhan}$$
- **Mã nguồn PL/pgSQL:**
```sql
CREATE OR REPLACE FUNCTION fn_TimPhongTrong(
    p_NgayNhan DATE,
    p_NgayTra  DATE,
    p_SoNguoi  INT DEFAULT 1,
    p_MaLoai   INT DEFAULT NULL
)
RETURNS TABLE (
    MaPhong       INT,
    SoPhong       VARCHAR(20),
    Tang          INT,
    MaLoai        INT,
    TenLoai       VARCHAR(50),
    GiaMotDem     NUMERIC(18,2),
    SoNguoiToiDa  INT,
    MoTaGiuong    VARCHAR(100),
    DienTich      NUMERIC(6,2),
    TinhTrang     VARCHAR(30)
) AS $$
BEGIN
    IF p_NgayNhan >= p_NgayTra THEN
        RAISE EXCEPTION 'Ngày nhận phòng (%) phải trước ngày trả phòng (%)!', p_NgayNhan, p_NgayTra;
    END IF;

    RETURN QUERY
    SELECT 
        p.MaPhong, p.SoPhong, p.Tang, p.MaLoai,
        lp.TenLoai, lp.GiaMotDem, lp.SoNguoiToiDa,
        p.MoTaGiuong, p.DienTich, p.TinhTrang
    FROM Phong p
    JOIN LoaiPhong lp ON p.MaLoai = lp.MaLoai
    WHERE p.TinhTrang IN ('Hoạt động', 'Trống', 'Đã dọn dẹp')
      AND (p_MaLoai IS NULL OR p.MaLoai = p_MaLoai)
      AND (lp.SoNguoiToiDa >= p_SoNguoi)
      AND NOT EXISTS (
          SELECT 1 FROM DatPhong dp
          WHERE dp.MaPhong = p.MaPhong
            AND dp.TrangThai IN ('Đã đặt', 'Đang ở')
            AND (p_NgayNhan < dp.NgayTra AND p_NgayTra > dp.NgayNhan)
      )
    ORDER BY p.Tang, p.SoPhong;
END;
$$ LANGUAGE plpgsql;
```

### 4.3.2. Hàm tính toán chi phí lưu trú & tiền cọc 30% (`fn_TinhToanChiPhiDatPhong`)
- **Mục đích:** Tự động tính số đêm lưu trú thực tế, cộng phụ thu khi đoàn khách có trẻ em hoặc vượt quá 2 người lớn, áp thuế VAT 10% và đề xuất mức cọc 30% làm tròn nghìn.
- **Mã nguồn PL/pgSQL:**
```sql
CREATE OR REPLACE FUNCTION fn_TinhToanChiPhiDatPhong(
    p_GiaMotDem   NUMERIC(18,2),
    p_NgayNhan    DATE,
    p_NgayTra     DATE,
    p_SoNguoiLon  INT DEFAULT 1,
    p_SoTreEm     INT DEFAULT 0,
    p_PhanTramVAT NUMERIC DEFAULT 0.10
)
RETURNS TABLE (
    SoDem         INT,
    TienPhongGoc  NUMERIC(18,2),
    PhuThuNguoi   NUMERIC(18,2),
    ThueVAT       NUMERIC(18,2),
    TongChiPhi    NUMERIC(18,2),
    TienCocDeXuat NUMERIC(18,2)
) AS $$
DECLARE
    v_SoDem INT;
    v_TienGoc NUMERIC(18,2);
    v_PhuThu NUMERIC(18,2) := 0;
    v_Thue NUMERIC(18,2) := 0;
    v_Tong NUMERIC(18,2) := 0;
BEGIN
    v_SoDem := GREATEST(1, (p_NgayTra - p_NgayNhan));
    v_TienGoc := p_GiaMotDem * v_SoDem;

    IF p_SoNguoiLon > 2 THEN
        v_PhuThu := v_PhuThu + ((p_SoNguoiLon - 2) * 150000 * v_SoDem);
    END IF;
    IF p_SoTreEm > 0 THEN
        v_PhuThu := v_PhuThu + (p_SoTreEm * 80000 * v_SoDem);
    END IF;

    v_Thue := (v_TienGoc + v_PhuThu) * p_PhanTramVAT;
    v_Tong := v_TienGoc + v_PhuThu + v_Thue;

    RETURN QUERY
    SELECT 
        v_SoDem, v_TienGoc, v_PhuThu, v_Thue, v_Tong,
        ROUND(v_Tong * 0.30, -3);
END;
$$ LANGUAGE plpgsql;
```

### 4.3.3. Thủ tục Check-in nhận phòng an toàn giao dịch ACID (`sp_ThucHienCheckIn`)
- **Ý nghĩa nghiệp vụ:** Đảm bảo giao dịch nhận phòng tuân thủ đầy đủ 4 tiêu chí ACID:
  + Khóa bản ghi với cơ chế `FOR UPDATE` chống tranh chấp sửa đổi đồng thời.
  + Bắt lỗi nghiêm ngặt nếu khách đến trước ngày ghi trên phiếu.
  + Kiểm tra phòng vật lý không có khách khác đang lưu trú chưa trả phòng.
  + Tự động đồng bộ: Đổi `DatPhong.TrangThai = 'Đang ở'`, gán `GioNhanThucTe` và chuyển `Phong.TinhTrang = 'Đang sử dụng'`.
- **Mã nguồn PL/pgSQL:**
```sql
CREATE OR REPLACE PROCEDURE sp_ThucHienCheckIn(
    p_MaDatPhong INT,
    p_MaNhanVien INT DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_TrangThai VARCHAR(20);
    v_NgayNhan DATE;
    v_MaPhong INT;
    v_SoPhong VARCHAR(20);
BEGIN
    SELECT dp.TrangThai, dp.NgayNhan, dp.MaPhong, p.SoPhong
    INTO v_TrangThai, v_NgayNhan, v_MaPhong, v_SoPhong
    FROM DatPhong dp
    JOIN Phong p ON dp.MaPhong = p.MaPhong
    WHERE dp.MaDatPhong = p_MaDatPhong
    FOR UPDATE;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Không tìm thấy đơn đặt phòng có mã: %', p_MaDatPhong;
    END IF;
    IF v_TrangThai <> 'Đã đặt' THEN
        RAISE EXCEPTION 'Đơn phòng đang ở trạng thái "%", không thể thực hiện nhận phòng!', v_TrangThai;
    END IF;
    IF v_NgayNhan > CURRENT_DATE THEN
        RAISE EXCEPTION 'Chưa đến ngày nhận phòng (Ngày nhận: %)!', v_NgayNhan;
    END IF;

    IF EXISTS (SELECT 1 FROM DatPhong WHERE MaPhong = v_MaPhong AND TrangThai = 'Đang ở' AND MaDatPhong <> p_MaDatPhong) THEN
        RAISE EXCEPTION 'Phòng % hiện đang có khách lưu trú chưa trả phòng!', v_SoPhong;
    END IF;

    UPDATE DatPhong
    SET TrangThai = 'Đang ở',
        GioNhanThucTe = CURRENT_TIMESTAMP,
        MaNhanVien = COALESCE(p_MaNhanVien, MaNhanVien)
    WHERE MaDatPhong = p_MaDatPhong;

    UPDATE Phong
    SET TinhTrang = 'Đang sử dụng'
    WHERE MaPhong = v_MaPhong;

    RAISE NOTICE 'Đã thực hiện Check-in thành công cho đơn đặt phòng % (Phòng %)', p_MaDatPhong, v_SoPhong;
END;
$$;
```

### 4.3.4. Thủ tục Check-out quyết toán hóa đơn (`sp_ThucHienCheckOut`)
- **Ý nghĩa nghiệp vụ:** Đóng gói toàn bộ quá trình thanh toán phức tạp vào một Transaction:
  + Lấy thông tin đơn đặt phòng đang ở và khóa dòng `FOR UPDATE`.
  + Tự động sinh mã hóa đơn chuẩn `HDYYYYMMDDXXXX`.
  + Tính tổng tiền dịch vụ phát sinh từ bảng `ChiTietHoaDon`.
  + Khấu trừ số tiền đặt cọc 30% khách đã trả trước và khấu trừ mã voucher giảm giá.
  + Ghi nhận hóa đơn thanh toán, đổi đơn phòng sang 'Đã trả' và trả buồng phòng về 'Chờ dọn dẹp'.
- **Mã nguồn PL/pgSQL:**
```sql
CREATE OR REPLACE PROCEDURE sp_ThucHienCheckOut(
    p_MaDatPhong   INT,
    p_MaPTTT       VARCHAR(10),
    p_MaVoucher    INT,
    INOUT p_MaHoaDon VARCHAR(20) DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_MaDat VARCHAR(20);
    v_MaPhong INT;
    v_SoPhong VARCHAR(20);
    v_TienPhong NUMERIC(18,2);
    v_TienCoc NUMERIC(18,2);
    v_TienDV NUMERIC(18,2) := 0;
    v_TienGiam NUMERIC(18,2) := 0;
    v_TongCanThu NUMERIC(18,2) := 0;
BEGIN
    SELECT dp.MaDat, dp.MaPhong, p.SoPhong, COALESCE(dp.TongTien, 0), COALESCE(dp.TienCoc, 0)
    INTO v_MaDat, v_MaPhong, v_SoPhong, v_TienPhong, v_TienCoc
    FROM DatPhong dp
    JOIN Phong p ON dp.MaPhong = p.MaPhong
    WHERE dp.MaDatPhong = p_MaDatPhong AND dp.TrangThai = 'Đang ở'
    FOR UPDATE;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Không tìm thấy đơn đặt phòng đang ở có mã: %!', p_MaDatPhong;
    END IF;

    IF p_MaHoaDon IS NULL OR p_MaHoaDon = '' THEN
        p_MaHoaDon := 'HD' || TO_CHAR(CURRENT_TIMESTAMP, 'YYYYMMDD') || LPAD(p_MaDatPhong::TEXT, 4, '0');
    END IF;

    SELECT COALESCE(SUM(ThanhTien), 0) INTO v_TienDV
    FROM ChiTietHoaDon
    WHERE MaHoaDon = p_MaHoaDon;

    IF p_MaVoucher IS NOT NULL THEN
        SELECT 
            CASE 
                WHEN LoaiGiam = 'PhanTram' THEN LEAST(v_TienPhong * (GiaTri / 100), v_TienPhong)
                ELSE LEAST(GiaTri, v_TienPhong)
            END
        INTO v_TienGiam
        FROM Voucher
        WHERE MaVoucher = p_MaVoucher AND TrangThai = TRUE;
    END IF;

    v_TongCanThu := GREATEST(0, (v_TienPhong + v_TienDV - v_TienCoc - v_TienGiam));

    INSERT INTO HoaDon (
        MaHoaDon, MaDatPhong, NgayLap, NgayThanhToan,
        TienPhong, TienDichVu, TienGiamGia, TienDatCoc, TongTien,
        MaPTTT, MaVoucher, TrangThai
    )
    VALUES (
        p_MaHoaDon, v_MaDat, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP,
        v_TienPhong, v_TienDV, v_TienGiam, v_TienCoc, v_TongCanThu,
        COALESCE(p_MaPTTT, 'TM'), p_MaVoucher, 'Đã thanh toán'
    )
    ON CONFLICT (MaHoaDon) DO UPDATE 
    SET NgayThanhToan = CURRENT_TIMESTAMP,
        TongTien = EXCLUDED.TongTien,
        TrangThai = 'Đã thanh toán';

    UPDATE DatPhong
    SET TrangThai = 'Đã trả',
        GioTraThucTe = CURRENT_TIMESTAMP
    WHERE MaDatPhong = p_MaDatPhong;

    UPDATE Phong
    SET TinhTrang = 'Chờ dọn dẹp'
    WHERE MaPhong = v_MaPhong;

    RAISE NOTICE 'Đã Check-out và xuất hóa đơn % thành công cho phòng %. Tổng thu: % VNĐ', 
        p_MaHoaDon, v_SoPhong, v_TongCanThu;
END;
$$;
```

### 4.3.5. Kịch bản kiểm thử thực nghiệm (Test Cases của Tuấn Minh)
Bảng ma trận kiểm thử Stored Procedures & Functions do Tuấn Minh phụ trách:

| Mã Test Case | Tên kiểm thử | Dữ liệu đầu vào | Kết quả mong đợi | Kết quả thực tế | Đánh giá |
| :---: | :--- | :--- | :--- | :--- | :---: |
| `TC-TM-01` | Tìm phòng trống hợp lệ | Ngày nhận: Mai, Ngày trả: 4 ngày sau, 2 khách | Trả về danh sách phòng trống, không trùng lịch | Trả về danh sách phòng khả dụng theo đúng tiêu chí | **Đạt (Pass)** |
| `TC-TM-02` | Bắt lỗi ngày nhận >= ngày trả | Ngày nhận: 10/11, Ngày trả: 05/11 | Bắn lỗi `RAISE EXCEPTION` ngày nhận phải trước ngày trả | Bắt lỗi chính xác, không cho phép thực thi | **Đạt (Pass)** |
| `TC-TM-03` | Tính chi phí & tiền cọc 30% | Giá 800k/đêm, 3 đêm, 3 người lớn, 1 trẻ em | Tính đúng phụ thu người lớn (150k), trẻ em (80k), cọc 30% | Tổng chi phí và tiền cọc tính chính xác 100% | **Đạt (Pass)** |
| `TC-TM-04` | Check-in nhận phòng thành công | Mã đơn đặt phòng đang ở trạng thái 'Đã đặt' | Đổi đơn sang 'Đang ở', phòng sang 'Đang sử dụng' | Cập nhật cả 2 bảng đồng bộ trong 1 transaction an toàn | **Đạt (Pass)** |
| `TC-TM-05` | Check-out xuất hóa đơn | Đơn phòng đang ở + Voucher giảm giá 10% | Xuất mã `HD...`, trừ tiền cọc, trừ voucher, phòng về 'Chờ dọn' | Hóa đơn tính chuẩn xác, phòng chuyển trạng thái chờ dọn | **Đạt (Pass)** |

---

# PHẦN PHỤ LỤC: KỊCH BẢN CÂU LỆNH DEMO TRƯỚC GIẢNG VIÊN HƯỚNG DẪN

```sql
-- ============================================================================
-- CÂU LỆNH SQL DEMO TRỰC TIẾP TRƯỚC THẦY LƯƠNG THÁI HIỀN
-- THỰC HIỆN: LÊ TRẦN TUẤN MINH
-- ============================================================================

-- 1. Demo Hàm tìm kiếm phòng trống theo ngày và sức chứa:
SELECT * FROM fn_TimPhongTrong(CURRENT_DATE + 1, CURRENT_DATE + 4, 2, NULL);

-- 2. Demo Hàm tính chi phí lưu trú, phụ thu và đề xuất tiền cọc 30%:
SELECT * FROM fn_TinhToanChiPhiDatPhong(800000, CURRENT_DATE, CURRENT_DATE + 3, 2, 1, 0.10);

-- 3. Demo Thủ tục Check-in nhận phòng có khóa giao dịch ACID:
CALL sp_ThucHienCheckIn(p_MaDatPhong := 1, p_MaNhanVien := 1);

-- 4. Demo Thủ tục Check-out quyết toán hóa đơn xuất mã HD duy nhất:
DO $$
DECLARE v_HD VARCHAR(20);
BEGIN
    CALL sp_ThucHienCheckOut(1, 'VNPAY', NULL, v_HD);
    RAISE NOTICE 'Mã hóa đơn vừa xuất thành công: %', v_HD;
END $$;
```
