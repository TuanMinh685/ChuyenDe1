# BỘ GIÁO DỤC VÀ ĐÀO TẠO
# TRƯỜNG ĐẠI HỌC VĂN HIẾN - KHOA CÔNG NGHỆ THÔNG TIN

---

## CHUYÊN ĐỀ 1: KHAI THÁC HỆ CƠ SỞ DỮ LIỆU
**MÃ LỚP HỌC PHẦN:** INT51309 (6 TÍN CHỈ)  
**NĂM HỌC:** 2026 - 2027 | **HỌC KỲ:** HK01  
**ĐỀ TÀI:** THIẾT KẾ, TỐI ƯU VÀ KHAI THÁC CƠ SỞ DỮ LIỆU HỆ THỐNG QUẢN LÝ KHÁCH SẠN AN NHIÊN  
**GIẢNG VIÊN HƯỚNG DẪN:** ThS. LƯƠNG THÁI HIỀN (Email: hienlt@vhu.edu.vn)  
**SINH VIÊN THỰC HIỆN:**
1. **LÊ TRẦN TUẤN MINH** (Trưởng nhóm - MSSV: 221A010993)
2. **NGUYỄN VĂN NHÂN** (MSSV: ....................)
3. **HOÀNG THANH PHƯƠNG** (MSSV: ....................)
**LỚP:** 11A1021  
**TP. HỒ CHÍ MINH – NĂM 2026**

---

### MẪU 02: LỜI CẢM ƠN
Lời đầu tiên, nhóm sinh viên chúng em xin gửi lời cảm ơn chân thành và sâu sắc nhất đến Ban Giám hiệu cùng toàn thể quý Thầy Cô Khoa Công nghệ Thông tin – Trường Đại học Văn Hiến, những người đã truyền đạt cho chúng em những nền tảng tri thức vững chắc về khoa học máy tính và công nghệ cơ sở dữ liệu trong suốt quá trình theo học tại trường.

Đặc biệt, nhóm chúng em xin bày tỏ lòng biết ơn sâu sắc đến **Thầy ThS. Lương Thái Hiền** – Giảng viên trực tiếp hướng dẫn học phần Chuyên đề 1. Thầy đã dành nhiều thời gian quý báu để định hướng phương pháp tư duy, chỉ bảo tận tình từ khâu phân tích khảo sát nghiệp vụ, chuẩn hóa mô hình dữ liệu quan hệ, cho đến việc thiết kế các giao dịch ACID và tối ưu hóa câu truy vấn hiệu năng cao. Những lời khuyên của Thầy là kim chỉ nam giúp đề tài được hoàn thiện đúng tiến độ và đạt chuẩn mực khoa học.

Mặc dù nhóm đã nỗ lực hết mình để hoàn thành chuyên đề với tinh thần nghiêm túc và cầu thị, song do kiến thức và kinh nghiệm thực tiễn còn bước đầu trau dồi nên báo cáo khó tránh khỏi những thiếu sót nhất định. Nhóm chúng em rất mong nhận được những nhận xét, góp ý quý báu của quý Thầy Cô để công trình ngày càng hoàn thiện hơn.

*Tp. Hồ Chí Minh, ngày ... tháng ... năm 2026*  
**Sinh viên thực hiện:**  
Lê Trần Tuấn Minh - Nguyễn Văn Nhân - Hoàng Thanh Phương

---

### MẪU 03: LỜI CAM ĐOAN
> *"Tôi cam đoan đây là công trình nghiên cứu của riêng tôi, do tôi tự thực hiện, không sao chép, vay mượn từ các công trình nghiên cứu khoa học khác. Đảm bảo mọi tài liệu tham khảo đều được trích dẫn, ghi chú đầy đủ."*

Toàn bộ các mô hình thực thể quan hệ, từ điển dữ liệu, chứng minh chuẩn hóa 3NF/BCNF, mã lệnh lập trình Trigger, Stored Procedure, View và kết quả phân tích kế hoạch thực thi EXPLAIN ANALYZE được trình bày trong quyển báo cáo này hoàn toàn do nhóm tự nghiên cứu, thiết kế và kiểm thử thực nghiệm trên hệ quản trị cơ sở dữ liệu PostgreSQL 15+ (nền tảng Supabase Cloud).

Các số liệu và kết quả kiểm thử trong báo cáo là hoàn toàn trung thực. Nếu có bất kỳ sự gian lận hoặc sao chép trái phép nào, nhóm chúng em xin hoàn toàn chịu mọi hình thức kỷ luật theo quy định của Khoa Công nghệ Thông tin và Nhà trường.

*Tp. Hồ Chí Minh, ngày ... tháng ... năm 2026*  
**Sinh viên thực hiện:**  
*(Ký và ghi rõ họ tên)*  
**Lê Trần Tuấn Minh**

---

### MẪU 04: NHẬN XÉT CỦA GIẢNG VIÊN HƯỚNG DẪN
1. **Về tinh thần và thái độ làm việc của sinh viên trong quá trình thực hiện:**  
   ................................................................................................................................................................................  
2. **Về tính đúng đắn và hợp lý của thiết kế giải pháp kỹ thuật:**  
   ................................................................................................................................................................................  
3. **Về kết quả đạt được và khả năng ứng dụng thực tiễn của đề tài:**  
   ................................................................................................................................................................................  
4. **Điểm đánh giá và kết luận duyệt bảo vệ:**  
   - Điểm số: .........../10.0 (Bằng chữ: ........................................................................................................................)  
   - Đồng ý cho sinh viên nộp quyển và tham gia báo cáo trước Hội đồng chấm chuyên đề.

*Tp. Hồ Chí Minh, ngày ... tháng ... năm 2026*  
**Giảng viên hướng dẫn**  
*(Ký và ghi rõ họ tên)*  
**ThS. LƯƠNG THÁI HIỀN**

---

### BẢNG PHÂN CÔNG NHIỆM VỤ VÀ TỶ LỆ ĐÓNG GÓP (100%)
| STT | Họ và Tên | Vai trò | Trách nhiệm chuyên môn phụ trách | Tỷ lệ đóng góp | Đánh giá |
| :---: | :--- | :---: | :--- | :---: | :---: |
| 1 | **Lê Trần Tuấn Minh** | Trưởng nhóm | • Thiết kế Schema 10 bảng CSDL, quan hệ PK/FK<br>• Viết Hàm tìm phòng trống & tính chi phí<br>• Viết Thủ tục Check-in & Check-out giao dịch ACID<br>• Soạn: Mở đầu, Chương 1, Chương 3 (3.1-3.5), Mục 4.3<br>• Quản trị Git repo, tổng hợp Master file Word | **100%** | Xuất sắc |
| 2 | **Nguyễn Văn Nhân** | Thành viên | • Thiết kế bảng nhật ký Audit Log `NhatKyHeThong`<br>• Lập trình 4 Triggers toàn vẹn & khóa dòng Voucher<br>• Phân quyền RBAC (Role Quản trị vs Lễ tân)<br>• Soạn: Chương 2, Mục 4.1, 4.2 & Mục 4.6 | **100%** | Xuất sắc |
| 3 | **Hoàng Thanh Phương** | Thành viên | • Xây dựng 5 Analytic Views khai thác báo cáo đa chiều<br>• Đánh Composite Indexes & đo lường EXPLAIN ANALYZE<br>• Soạn: Mục 4.4, 4.5, Kết luận và Tài liệu tham khảo | **100%** | Xuất sắc |

---

### MẪU 05: MỤC LỤC
* **Phần I: MỞ ĐẦU** ............................................................................................................................ Trang 1
* **Chương 1. GIỚI THIỆU CHUNG VỀ ĐỀ TÀI** ............................................................................ Trang 3
  - 1.1. Bối cảnh ra đời và nhu cầu thực tiễn ............................................................................. Trang 3
  - 1.2. Khảo sát hiện trạng và quy trình nghiệp vụ khách sạn An Nhiên ............................... Trang 4
  - 1.3. Mục tiêu và phạm vi nghiên cứu của đề tài ................................................................ Trang 6
* **Chương 2. TỔNG HỢP KIẾN THỨC LIÊN QUAN** ................................................................. Trang 7
  - 2.1. Tổng quan hệ quản trị cơ sở dữ liệu PostgreSQL và Supabase Cloud ..................... Trang 7
  - 2.2. Kỹ thuật lập trình thủ tục nâng cao trong PL/pgSQL ................................................... Trang 8
  - 2.3. Cơ chế giao dịch ACID và kiểm soát đồng thời (Concurrency Control) ...................... Trang 10
  - 2.4. Lý thuyết chuẩn hóa cơ sở dữ liệu quan hệ (1NF, 2NF, 3NF, BCNF) ............................ Trang 12
  - 2.5. Tối ưu hóa truy vấn với B-Tree Index và EXPLAIN ANALYZE ................................... Trang 14
  - 2.6. Mô hình bảo mật phân quyền dựa trên vai trò (RBAC) ............................................. Trang 16
* **Chương 3. PHÂN TÍCH NHIỆM VỤ VÀ LỰA CHỌN GIẢI PHÁP** ......................................... Trang 17
  - 3.1. Phân tích các yêu cầu chức năng và phi chức năng của hệ CSDL .............................. Trang 17
  - 3.2. So sánh và lựa chọn giải pháp hệ quản trị cơ sở dữ liệu ............................................ Trang 18
  - 3.3. Thiết kế mô hình quan hệ thực thể (Sơ đồ ERD) .......................................................... Trang 20
  - 3.4. Từ điển dữ liệu chi tiết của 10 bảng thực thể cốt lõi ................................................... Trang 22
  - 3.5. Chứng minh chuẩn hóa dữ liệu (1NF - 2NF - 3NF - BCNF) ........................................ Trang 28
* **Chương 4. THIẾT KẾ, HIỆN THỰC VÀ ĐÁNH GIÁ KẾT QUẢ THỰC NGHIỆM** .............. Trang 32
  - 4.1. Hiện thực cấu trúc bảng và nhật ký kiểm toán (NhatKyHeThong) ............................ Trang 32
  - 4.2. Hiện thực tự động hóa và toàn vẹn dữ liệu với Triggers PL/pgSQL .......................... Trang 35
  - 4.3. Hiện thực thủ tục và hàm nghiệp vụ giao dịch an toàn (ACID) .................................. Trang 42
  - 4.4. Hiện thực khai thác dữ liệu đa chiều (Analytic Views) ................................................. Trang 48
  - 4.5. Hiện thực tối ưu hóa hiệu năng câu truy vấn với Composite Indexes ....................... Trang 53
  - 4.6. Hiện thực an toàn và bảo mật phân quyền RBAC ........................................................ Trang 56
  - 4.7. Báo cáo kết quả thực nghiệm và đánh giá chất lượng sản phẩm ............................. Trang 58
* **Phần III: KẾT LUẬN VÀ ĐỀ NGHỊ** ............................................................................................ Trang 61
* **DANH MỤC TÀI LIỆU THAM KHẢO** ....................................................................................... Trang 63
* **PHẦN PHỤ LỤC: KỊCH BẢN CÂU LỆNH SQL VÀ KIỂM THỬ DEMO** ................................ Trang 65

---

### MẪU 06: DANH MỤC CÁC BẢNG BIỂU, LƯU ĐỒ, HÌNH
* Bảng 3.1: Từ điển dữ liệu bảng LoaiPhong ............................................................................ Trang 22
* Bảng 3.2: Từ điển dữ liệu bảng Phong .................................................................................... Trang 23
* Bảng 3.3: Từ điển dữ liệu bảng KhachHang ............................................................................ Trang 24
* Bảng 3.4: Từ điển dữ liệu bảng DatPhong ............................................................................. Trang 25
* Bảng 3.5: Từ điển dữ liệu bảng HoaDon ................................................................................ Trang 26
* Bảng 3.6: Từ điển dữ liệu bảng ChiTietHoaDon .................................................................... Trang 27
* Bảng 3.7: Từ điển dữ liệu bảng DichVu .................................................................................. Trang 27
* Bảng 3.8: Từ điển dữ liệu bảng Voucher ................................................................................. Trang 28
* Bảng 4.1: Ma trận kiểm thử Stored Procedures và Functions của Tuấn Minh ................... Trang 47
* Bảng 4.2: So sánh thời gian thực thi câu truy vấn trước và sau khi đánh Index .............. Trang 55
* Hình 3.1: Sơ đồ thực thể - mối quan hệ (ERD) 10 bảng hệ thống khách sạn An Nhiên ..... Trang 21
* Hình 4.1: Kế hoạch thực thi tuần tự (Sequential Scan) khi chưa có chỉ mục ..................... Trang 54
* Hình 4.2: Kế hoạch thực thi Bitmap Index Scan sau khi tối ưu hóa chỉ mục ...................... Trang 55
* Lưu đồ 4.1: Lưu đồ giải thuật thủ tục Check-in nhận phòng (sp_ThucHienCheckIn) ........ Trang 43
* Lưu đồ 4.2: Lưu đồ giải thuật thủ tục Check-out quyết toán (sp_ThucHienCheckOut) ...... Trang 45

---

### MẪU 07: DANH MỤC CÁC TỪ VIẾT TẮT – THUẬT NGỮ ANH – VIỆT
| Từ viết tắt | Thuật ngữ tiếng Anh đầy đủ | Ý nghĩa và giải thích tiếng Việt |
| :--- | :--- | :--- |
| **ACID** | Atomicity, Consistency, Isolation, Durability | Bốn thuộc tính bảo đảm toàn vẹn giao dịch (Nguyên tử, Nhất quán, Cô lập, Bền vững) |
| **BCNF** | Boyce-Codd Normal Form | Dạng chuẩn Boyce-Codd trong chuẩn hóa CSDL quan hệ |
| **BI** | Business Intelligence | Kinh doanh thông minh, phân tích dữ liệu phục vụ ra quyết định |
| **CCCD** | Căn cước công dân | Giấy tờ tùy thân định danh pháp lý của khách lưu trú |
| **CSDL** | Cơ sở dữ liệu | Hệ thống dữ liệu được tổ chức có cấu trúc trên máy tính |
| **ERD** | Entity Relationship Diagram | Sơ đồ biểu diễn thực thể và mối quan hệ giữa các bảng |
| **FK** | Foreign Key | Khóa ngoại, thiết lập toàn vẹn tham chiếu |
| **NF** | Normal Form | Dạng chuẩn trong lý thuyết chuẩn hóa cơ sở dữ liệu |
| **PK** | Primary Key | Khóa chính, giá trị duy nhất định danh cho một dòng dữ liệu |
| **PL/pgSQL** | Procedural Language/PostgreSQL | Ngôn ngữ lập trình thủ tục nâng cao trong PostgreSQL |
| **RBAC** | Role-Based Access Control | Mô hình kiểm soát truy cập và phân quyền dựa trên vai trò |
| **RFM** | Recency, Frequency, Monetary | Mô hình phân khúc khách hàng theo thời gian, tần suất và doanh thu |
| **SQL** | Structured Query Language | Ngôn ngữ truy vấn dữ liệu có cấu trúc tiêu chuẩn |
| **UK** | Unique Key | Khóa duy nhất, ràng buộc không trùng lặp dữ liệu trên cột |

---

# PHẦN I: MỞ ĐẦU (Đánh số Ả Rập từ trang 1)

### 1. Lý do chọn đề tài (Tính cấp thiết của đề tài)
Ngành kinh doanh dịch vụ khách sạn hiện đại đòi hỏi tốc độ xử lý giao dịch tức thời và độ chính xác dữ liệu tuyệt đối. Mọi thao tác thường nhật của bộ phận lễ tân từ việc tra cứu buồng phòng khả dụng, tiếp nhận tiền cọc, làm thủ tục nhận phòng (Check-in), tính toán chi phí các dịch vụ phụ trợ phát sinh (minibar, giặt ủi, điểm tâm), khấu trừ mã giảm giá (voucher) cho đến thủ tục trả phòng quyết toán (Check-out) đều tác động trực tiếp đến dòng tiền doanh thu và mức độ hài lòng của khách hàng.

Tuy nhiên, trên thực tế nhiều cơ sở lưu trú vừa và nhỏ vẫn quản lý buồng phòng và giao dịch dựa trên sổ sách ghi chép hoặc các bảng tính Excel rời rạc. Cách làm thủ công này bộc lộ những rủi ro đặc biệt nghiêm trọng: xung đột lịch buồng phòng (Double-booking) khi hai nhân viên cùng phân phối một phòng trống cho hai khách khác nhau trong cùng một khoảng ngày; tranh chấp số lượng mã voucher ưu đãi khi nhiều khách hàng cùng áp dụng một mã duy nhất vào cùng một thời điểm; hoặc nhân viên quên cập nhật trạng thái phòng khiến phòng đã khách trả nhưng hệ thống vẫn báo bận, làm sụt giảm công suất khai thác kinh doanh.

Để giải quyết triệt để các rủi ro trên, việc thiết kế một cơ sở dữ liệu quan hệ đạt chuẩn hóa cao (tối thiểu 3NF/BCNF), đồng thời khai thác sâu các tính năng nâng cao của hệ quản trị như Stored Procedures, Functions, Triggers toàn vẹn dữ liệu, kiểm soát giao dịch theo chuẩn ACID và tối ưu hóa câu truy vấn bằng chỉ mục đa cột là giải pháp cốt lõi mang tính cấp thiết hàng đầu.

### 2. Mục đích nghiên cứu
- Thiết kế và cài đặt hoàn chỉnh cơ sở dữ liệu quan hệ cho Hệ thống Quản lý Khách sạn An Nhiên đạt chuẩn hóa 3NF/BCNF, loại trừ triệt để các hiện tượng dị thường khi thêm, sửa và xóa dữ liệu.
- Tự động hóa các nghiệp vụ lễ tân và lưu trú bằng các Stored Procedures và Functions có kiểm soát giao dịch ACID, loại bỏ hoàn toàn các sai sót do thao tác thủ công.
- Cài đặt hệ thống Triggers PL/pgSQL bảo đảm tính toàn vẹn dữ liệu: Chống xung đột trùng lịch phòng, tự động đồng bộ buồng phòng và khóa dòng voucher (Pessimistic Locking) chống tranh chấp.
- Khai thác báo cáo quản trị kinh doanh đa chiều qua các Analytic Views và tối ưu hóa hiệu năng truy vấn bằng Composite Indexes, minh chứng bằng kế hoạch thực thi EXPLAIN ANALYZE.

### 3. Đối tượng nghiên cứu
- Dữ liệu quản lý khách sạn: Thông tin khách hàng, sơ đồ buồng phòng theo tầng và loại phòng, hồ sơ đặt phòng, phiếu thu đặt cọc, bảng kê chi tiết dịch vụ, mã giảm giá và hóa đơn thanh toán.
- Hệ quản trị cơ sở dữ liệu quan hệ PostgreSQL phiên bản 15+ triển khai trên nền tảng điện toán đám mây Supabase Cloud.

### 4. Nhiệm vụ nghiên cứu
- Khảo sát toàn diện quy trình vận hành và nghiệp vụ thực tế tại Khách sạn An Nhiên.
- Xây dựng sơ đồ thực thể quan hệ (ERD) gồm 10 bảng thực thể cốt lõi và lập bảng từ điển dữ liệu chi tiết cho từng thuộc tính.
- Chứng minh toán học tính chuẩn hóa của lược đồ cơ sở dữ liệu đạt các dạng chuẩn 1NF, 2NF, 3NF và BCNF.
- Lập trình hệ thống 4 Triggers toàn vẹn dữ liệu, 2 Hàm tìm phòng/tính cọc và 2 Thủ tục giao dịch Check-in/Check-out an toàn.
- Xây dựng 5 Analytic Views báo cáo doanh thu, công suất phòng, top dịch vụ và phân khúc khách hàng VIP theo mô hình RFM.
- Thiết lập chỉ mục Composite Index, đo lường và đánh giá hiệu năng truy vấn trước và sau khi tối ưu hóa.

### 5. Phương pháp nghiên cứu
- Phương pháp nghiên cứu lý thuyết: Nghiên cứu lý thuyết cơ sở dữ liệu quan hệ, lý thuyết phụ thuộc hàm của Codd, các dạng chuẩn hóa dữ liệu, kiến trúc giao dịch ACID và giải thuật đánh chỉ mục B-Tree.
- Phương pháp nghiên cứu thực nghiệm: Cài đặt và thực thi toàn bộ kịch bản SQL trực tiếp trên hệ thống PostgreSQL 15+ thông qua Supabase SQL Editor, tiến hành kiểm thử các trường hợp dữ liệu biên, mô phỏng tranh chấp giao dịch và phân tích chi phí thực thi câu lệnh.

### 6. Các kết quả đạt được của đề tài
- Xây dựng thành công cơ sở dữ liệu hoàn chỉnh gồm 10 bảng thực thể có ràng buộc toàn vẹn chặt chẽ, đáp ứng đầy đủ yêu cầu quản lý khách sạn hiện đại.
- Giải quyết triệt để bài toán Double-booking bằng Trigger kiểm tra giao thoa khoảng thời gian và bài toán thất thoát Voucher bằng kỹ thuật khóa bi quan (FOR UPDATE).
- Tối ưu hóa thời gian phản hồi câu truy vấn tìm phòng từ ~18.4ms xuống còn ~0.12ms nhờ áp dụng Composite Index.
- Đóng gói toàn bộ mã nguồn chuyên đề và quản lý phiên bản chuyên nghiệp trên GitHub: https://github.com/TuanMinh685/ChuyenDe1.git.

### 7. Kết cấu của báo cáo Chuyên đề 1
Báo cáo được bố cục thành 4 chương nội dung chính:
- **Chương 1:** Giới thiệu chung về đề tài.
- **Chương 2:** Tổng hợp kiến thức liên quan.
- **Chương 3:** Phân tích nhiệm vụ và lựa chọn giải pháp.
- **Chương 4:** Thiết kế, hiện thực và đánh giá kết quả thực nghiệm.
Cuối báo cáo là Phần III: Kết luận và đề nghị, Danh mục tài liệu tham khảo và Phần Phụ lục.

---

# MẪU 08: DANH MỤC TÀI LIỆU THAM KHẢO

### Tiếng Việt:
[1] Nguyễn Tuệ (2018), *Giáo trình Hệ cơ sở dữ liệu*, Nhà xuất bản Giáo dục Việt Nam, Hà Nội.  
[2] Trần Nguyên Phong (2020), *Tối ưu hóa câu truy vấn trong các hệ quản trị cơ sở dữ liệu quan hệ*, Nhà xuất bản Đại học Quốc gia Tp. Hồ Chí Minh.  
[3] Khoa Công nghệ Thông tin – Trường Đại học Văn Hiến (2026), *Tài liệu hướng dẫn thực hiện Chuyên đề 1 và Chuyên đề 2*, Tp. Hồ Chí Minh.  

### Tiếng Anh:
[4] Abraham Silberschatz, Henry F. Korth, S. Sudarshan (2020), *Database System Concepts*, 7th Edition, McGraw-Hill Education, New York.  
[5] Regina O. Obe, Leo S. Hsu (2021), *PostgreSQL: Up and Running: A Practical Guide to the Advanced Open Source Database*, 3rd Edition, O'Reilly Media.  
[6] C.J. Date (2019), *Database Design and Relational Theory: Normal Forms and All That Jazz*, 2nd Edition, Apress.  

### Danh mục các Website tham khảo:
[7] PostgreSQL Global Development Group (2026), *PostgreSQL 15 Documentation*, truy cập tại: https://www.postgresql.org/docs/15/index.html (truy cập ngày 15/10/2026).  
[8] Supabase Inc. (2026), *Supabase Database & Architecture Documentation*, truy cập tại: https://supabase.com/docs (truy cập ngày 20/10/2026).  
[9] Use The Index, Luke (2026), *A Guide to Database Performance for Developers*, truy cập tại: https://use-the-index-luke.com (truy cập ngày 25/10/2026).  
