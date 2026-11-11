# KẾ HOẠCH PHÂN CHIA CÔNG VIỆC CHUYÊN ĐỀ 1 (3 THÀNH VIÊN)
**HỌC PHẦN:** CHUYÊN ĐỀ 1 - KHAI THÁC HỆ CƠ SỞ DỮ LIỆU (INT51309)  
**TRƯỜNG:** ĐẠI HỌC VĂN HIẾN - KHOA CÔNG NGHỆ THÔNG TIN  
**GIẢNG VIÊN HƯỚNG DẪN:** THẦY LƯƠNG THÁI HIỀN  
**ĐỀ TÀI:** THIẾT KẾ, TỐI ƯU VÀ KHAI THÁC CƠ SỞ DỮ LIỆU HỆ THỐNG QUẢN LÝ KHÁCH SẠN AN NHIÊN  
**DANH SÁCH THÀNH VIÊN:**  
1. **Tuấn Minh** (Trưởng nhóm - Thành viên 1)
2. **Nhân** (Thành viên 2)
3. **Thanh Phương** (Thành viên 3)

---

## I. NGUYÊN TẮC PHÂN CHIA
1. **Công bằng & Cân đối khối lượng (Workload Balance):** Mỗi thành viên đều đảm nhiệm đồng thời phần lập trình CSDL chuyên sâu (SQL) và phần viết báo cáo lý thuyết / thực nghiệm tương ứng trên Word.
2. **Làm chủ độc lập khi bảo vệ (Viva/Demo):** Giảng viên vấn đáp cá nhân từng người, do đó mỗi thành viên nắm sâu mảng mình phụ trách (từ giải thuật, trigger, procedure đến view phân tích và tối ưu hóa).
3. **Trách nhiệm rõ ràng (RACI):** Trưởng nhóm điều phối, rà soát tính nhất quán và định dạng tổng thể của file Word trước khi in nộp.

---

## II. BẢNG PHÂN CHIA CHI TIẾT THEO TỪNG THÀNH VIÊN

### 👤 1. THÀNH VIÊN 1: TUẤN MINH (Trưởng nhóm / Database Architect & Transactions)
* **Vai trò:** Phụ trách kiến trúc CSDL, mô hình dữ liệu, chuẩn hóa và các giao dịch xử lý nghiệp vụ nhận/trả phòng (ACID Transactions).
* **Phần Kỹ thuật SQL phụ trách:**
  - Thiết kế lược đồ 10 bảng thực thể cốt lõi (`supabase_schema_and_data.sql`).
  - Thiết lập mối quan hệ Khóa chính (PK), Khóa ngoại (FK), Ràng buộc Unique, Check, Default.
  - Viết 02 Hàm (Functions):
    - `fn_TimPhongTrong(p_NgayNhan, p_NgayTra, p_SoNguoi, p_MaLoai)`: Tìm phòng trống thông minh.
    - `fn_TinhToanChiPhiDatPhong(...)`: Tính toán tổng tiền phòng theo số đêm thực tế.
  - Viết 02 Thủ tục (Stored Procedures) giao dịch an toàn:
    - `sp_ThucHienCheckIn(...)`: Thủ tục Check-in nhận phòng, đổi trạng thái và ghi log.
    - `sp_ThucHienCheckOut(...)`: Thủ tục Check-out, tính chi phí phòng + dịch vụ, trừ cọc, trừ voucher và xuất hóa đơn.
* **Phần Báo cáo Word phụ trách viết:**
  - **Trang bìa, Lời cảm ơn, Mục lục tự động, Danh mục bảng biểu/hình ảnh**.
  - **CHƯƠNG 1: TỔNG QUAN ĐỀ TÀI & PHẠM VI HỆ THỐNG**
    - Lý do chọn đề tài, khảo sát nghiệp vụ khách sạn An Nhiên.
    - Giới thiệu phạm vi tính năng và công nghệ (PostgreSQL 15+, Supabase).
  - **CHƯƠNG 2: THIẾT KẾ CƠ SỞ DỮ LIỆU & CHUẨN HÓA DỮ LIỆU**
    - Sơ đồ thực thể quan hệ (ERD - Mermaid/Draw.io).
    - Từ điển dữ liệu chi tiết (Bảng `Phong`, `LoaiPhong`, `KhachHang`, `DatPhong`, `HoaDon`,...).
    - Chứng minh chuẩn hóa dữ liệu 1NF, 2NF, 3NF và BCNF.
  - **Mục 3.2 (Trong Chương 3): THỦ TỤC & HÀM NGHIỆP VỤ (STORED PROCEDURES & FUNCTIONS)**
    - Phân tích lưu đồ thuật toán Check-in, Check-out.
    - Trích dẫn mã nguồn PL/pgSQL và giải thích cơ chế bảo đảm ACID.
    - Hình ảnh test case chạy thử nghiệm trên Supabase SQL Editor.
  - **Tổng hợp & Hiệu chỉnh file Word cuối cùng (Format Master)**.

---

### 👤 2. THÀNH VIÊN 2: NHÂN (Database Automation & Integrity Engineer)
* **Vai trò:** Phụ trách cơ chế bảo toàn toàn vẹn dữ liệu, tự động hóa xử lý bằng Trigger PL/pgSQL, chống race-condition và phân quyền bảo mật.
* **Phần Kỹ thuật SQL phụ trách:**
  - Thiết kế bảng lưu vết `NhatKyHeThong` để kiểm toán dữ liệu (Audit log).
  - Lập trình **04 Triggers nâng cao**:
    1. `trg_DongBoTrangThaiPhong`: Tự động đồng bộ trạng thái phòng khi nhận/trả/hủy phòng.
    2. `trg_XuLyVoucherHoaDon`: Tự động khóa dòng Voucher (`FOR UPDATE` - Pessimistic Locking), trừ số lượng và chuyển trạng thái khi hết lượt.
    3. `trg_CapNhatTienDichVuHoaDon`: Tự động tính thành tiền dịch vụ và cộng dồn vào hóa đơn.
    4. `trg_KiemTraTrungLichDatPhong`: Ngăn chặn tình trạng trùng phòng (Anti Double-Booking).
  - Lập trình **Bảo mật & Phân quyền (RBAC)**:
    - Tạo Role `role_quan_tri_ks` (Full quyền quản trị).
    - Tạo Role `role_le_tan_ks` (Cấp quyền vừa đủ trên giao dịch, ẩn bảng tài khoản nhạy cảm, chỉ cấp quyền gọi thủ tục cần thiết).
* **Phần Báo cáo Word phụ trách viết:**
  - **Mục 3.1 (Trong Chương 3): TỰ ĐỘNG HÓA VÀ TOÀN VẸN DỮ LIỆU VỚI TRIGGERS**
    - Phân tích chi tiết nghiệp vụ của 4 Trigger.
    - Giải thích thuật toán khoá dòng (Pessimistic Locking) chống Race-condition khi nhiều khách cùng săn 1 Voucher.
    - Giải thích thuật toán kiểm tra giao thoa khoảng thời gian (Interval Overlap) chặn Double-booking.
    - Chụp hình ảnh kiểm thử: Cố tình đặt trùng ngày để chụp thông báo lỗi `RAISE EXCEPTION` đỏ từ hệ thống; Chụp hình bảng log `NhatKyHeThong` ghi nhận tự động sau mỗi lần Check-in/Check-out.
  - **Mục 5.2 (Trong Chương 5): AN TOÀN & BẢO MẬT HỆ CSDL (RBAC)**
    - Ma trận phân quyền giữa Admin và Nhân viên lễ tân.
    - Trích dẫn mã lệnh SQL `GRANT`, `REVOKE`, bảo mật thông tin mật khẩu tài khoản.
    - Chụp hình thử nghiệm khi dùng tài khoản Lễ tân truy cập bảng bị cấm (nhận thông báo `Permission Denied`).

---

### 👤 3. THÀNH VIÊN 3: THANH PHƯƠNG (Data Analytics & Performance Tuning Specialist)
* **Vai trò:** Phụ trách khai thác dữ liệu báo cáo kinh doanh đa chiều (Analytic Views/OLAP), tối ưu hóa hiệu năng câu truy vấn (Indexing) và phân tích kế hoạch thực thi `EXPLAIN ANALYZE`.
* **Phần Kỹ thuật SQL phụ trách:**
  - Xây dựng **05 Views phân tích dữ liệu đa chiều**:
    1. `vw_KhaiThacDoanhThuTheoThang`: Thống kê tiền phòng, dịch vụ, voucher, tỷ lệ thanh toán số qua VNPay/MoMo/Apple Pay.
    2. `vw_KhaiThacCongSuatLoaiPhong`: Tính tỷ lệ lấp đầy phòng (%) hỗ trợ chiến lược kinh doanh.
    3. `vw_KhaiThacTopDichVu`: Hàm cửa sổ xếp hạng `DENSE_RANK() OVER (ORDER BY TongDoanhThu DESC)`.
    4. `vw_KhaiThacKhachHangVIP`: Phân khúc khách hàng RFM (Kim Cương, Vàng, Thân thiết).
    5. `vw_KhaiThacDashboardTongHop`: Tổng hợp số liệu tức thời phục vụ ca trực lễ tân và ban giám đốc.
  - Thiết kế **Hệ thống chỉ mục (Composite Indexes)** trên các bảng có tần suất truy vấn cao (`DatPhong`, `KhachHang`, `HoaDon`).
  - Đo lường và so sánh hiệu năng bằng `EXPLAIN ANALYZE` (so sánh trước và sau khi đánh index).
* **Phần Báo cáo Word phụ trách viết:**
  - **CHƯƠNG 4: KHAI THÁC DỮ LIỆU ĐA CHIỀU (ANALYTIC VIEWS & BUSINESS INTELLIGENCE)**
    - Ý nghĩa quản trị và cấu trúc SQL của từng View trong 5 Views.
    - Chụp ảnh kết quả dữ liệu trả về của từng View kèm giải thích các chỉ số kinh doanh thực tế.
    - Phân tích ứng dụng hàm cửa sổ phân tích (`DENSE_RANK`, `CASE WHEN`, `GROUP BY ROLLUP`).
  - **Mục 5.1 (Trong Chương 5): TỐI ƯU HÓA TRUY VẤN VỚI CHỈ MỤC & ĐO LƯỜNG HIỆU NĂNG**
    - Nguyên lý hoạt động của B-Tree Index và Composite Index.
    - Trích dẫn câu lệnh `EXPLAIN ANALYZE` trước và sau khi tạo Index.
    - Chụp ảnh Execution Plan minh chứng thời gian giảm từ quét tuần tự (Sequential Scan ~18ms) sang Bitmap Index Scan (~0.12ms).
  - **CHƯƠNG KẾT LUẬN & HƯỚNG PHÁT TRIỂN ĐỀ TÀI**
    - Đánh giá kết quả đạt được, hạn chế còn tồn đọng.
    - Định hướng tích hợp AI gợi ý phòng, mở rộng CSDL phân tán.
  - **Tài liệu tham khảo & Danh mục thuật ngữ viết tắt**.

---

## III. MA TRẬN PHÂN CHIA BÁO CÁO WORD THEO CẤU TRÚC CHƯƠNG MỤC

| Chương / Mục | Nội dung chi tiết | Người phụ trách | Số trang dự kiến |
| :--- | :--- | :---: | :---: |
| **Phần đầu** | Bìa chính, Bìa phụ, Lời cảm ơn, Lời cam đoan, Mục lục, Danh mục hình/bảng | **Tuấn Minh** | 4 - 5 trang |
| **Bảng phân công** | Bảng phân công nhiệm vụ thành viên & Tỷ lệ đóng góp (%) | **Tuấn Minh** | 1 trang |
| **Chương 1** | Tổng quan bài toán, mục tiêu, đối tượng người dùng, khảo sát nghiệp vụ | **Tuấn Minh** | 4 - 6 trang |
| **Chương 2** | Thiết kế CSDL, ERD, Từ điển dữ liệu (10 bảng), Chứng minh 1NF, 2NF, 3NF | **Tuấn Minh** | 8 - 10 trang |
| **Mục 3.1** | Tự động hóa với Triggers PL/pgSQL (4 triggers, logic, code, ảnh test) | **Nhân** | 7 - 9 trang |
| **Mục 3.2** | Thủ tục & Hàm nghiệp vụ (2 functions, 2 procedures, ACID, ảnh test) | **Tuấn Minh** | 6 - 8 trang |
| **Chương 4** | Khai thác dữ liệu đa chiều (5 Analytic Views, ý nghĩa thống kê, ảnh kết quả) | **Thanh Phương** | 8 - 10 trang |
| **Mục 5.1** | Tối ưu hóa chỉ mục (Composite Index, phân tích `EXPLAIN ANALYZE`) | **Thanh Phương** | 4 - 5 trang |
| **Mục 5.2** | Bảo mật & Phân quyền RBAC (Role Admin vs Lễ tân, quyền truy cập, ảnh test) | **Nhân** | 4 - 5 trang |
| **Kết luận & Phụ lục**| Kết luận, hướng phát triển, tài liệu tham khảo, kịch bản demo bảo vệ | **Thanh Phương** + Cả nhóm | 3 - 4 trang |
| **TỔNG CỘNG** | **Quyển Báo Cáo Hoàn Chỉnh** | **Cả 3 thành viên** | **~50 - 60 trang** |

---

## IV. BẢNG TỶ LỆ ĐÓNG GÓP VÀ ĐÁNH GIÁ (NỘP CHO GIẢNG VIÊN)

| STT | Họ và Tên | Vai trò | Nhiệm vụ chính phụ trách | Đánh giá hoàn thành | Tỷ lệ đóng góp |
| :---: | :--- | :---: | :--- | :---: | :---: |
| 1 | **Tuấn Minh** | Trưởng nhóm | Thiết kế Schema, ERD, Chuẩn hóa 3NF, Stored Procedures & Functions, Tổng hợp báo cáo | Hoàn thành xuất sắc | **100%** |
| 2 | **Nhân** | Thành viên | 4 Triggers PL/pgSQL, Kiểm soát giao dịch concurrency, Phân quyền RBAC, Bảng Audit Log | Hoàn thành xuất sắc | **100%** |
| 3 | **Thanh Phương** | Thành viên | 5 Analytic Views, Hệ thống Composite Indexes, Đo lường hiệu năng `EXPLAIN ANALYZE`, Kết luận | Hoàn thành xuất sắc | **100%** |

---

## V. KỊCH BẢN PHÂN CHIA THUYẾT TRÌNH & DEMO TRƯỚC GIẢNG VIÊN (15 - 20 PHÚT)

Khi lên bàn bảo vệ đồ án trước **Thầy Lương Thái Hiền**, nhóm nên chia lượt báo cáo như sau:

1. **Tuấn Minh (Phút 0 - 5):**
   - Giới thiệu nhóm, đề tài khách sạn An Nhiên và cấu trúc CSDL 10 bảng.
   - Trình chiếu sơ đồ ERD và chứng minh tính chuẩn hóa 3NF.
   - Demo trực tiếp lệnh gọi:
     - `SELECT * FROM fn_TimPhongTrong(...)`: Tìm phòng theo ngày và loại phòng.
     - `CALL sp_ThucHienCheckIn(...)` và `CALL sp_ThucHienCheckOut(...)`: Chứng minh giao dịch thanh toán hoàn tất trơn tru.

2. **Nhân (Phút 5 - 10):**
   - Thuyết trình cơ chế bảo toàn toàn vẹn dữ liệu.
   - Demo Trigger chống Double-Booking: Cố tình nhập trùng lịch phòng để hiện thông báo lỗi hệ thống bắt giữ.
   - Demo Trigger Voucher: Cho xem số lượng voucher tự động giảm trừ và khóa lại khi về 0.
   - Demo phân quyền RBAC: Đăng nhập bằng role Lễ tân và query thử bảng `TaiKhoan` để thấy PostgreSQL chặn truy cập bảo mật.

3. **Thanh Phương (Phút 10 - 15):**
   - Thuyết trình phần khai thác dữ liệu quản trị: Trình chiếu kết quả 5 Analytic Views (Doanh thu tháng, Công suất lấp đầy phòng, Top dịch vụ sinh lời, Phân hạng khách hàng RFM).
   - Demo kiểm thử hiệu năng với `EXPLAIN ANALYZE`: Chạy câu truy vấn khi chưa có Index và khi đã có Index để thầy thấy rõ thời gian thực thi giảm từ ~18ms xuống ~0.12ms.
   - Tóm tắt kết luận và mời Giảng viên đặt câu hỏi vấn đáp.

## VI. KẾ HOẠCH PHÂN CHIA VÀ QUẢN TRỊ TRÊN GITHUB (GIT WORKFLOW)

### 1. Thông tin Kho lưu trữ Git (Git Repository)
* **URL Repository:** `https://github.com/TuanMinh685/ChuyenDe1.git`
* **Mô hình phân nhánh (Git Branching Strategy):**
  - Nhánh `main`: Nhánh sản phẩm chính thức, ổn định, dùng để demo với Thầy và nộp Khoa. Chỉ merge code thông qua Pull Request sau khi đã kiểm thử.
  - Nhánh `tuanminh`: Nhánh làm việc của Tuấn Minh (Schema 10 bảng, Stored Procedures, Functions).
  - Nhánh `nhan`: Nhánh làm việc của Nhân (4 Triggers, bảng Audit Log `NhatKyHeThong`, Phân quyền RBAC).
  - Nhánh `thanhphuong`: Nhánh làm việc của Thanh Phương (5 Analytic Views, Composite Indexes, `EXPLAIN ANALYZE`).

### 2. Bảng phân công Commit & Quản lý File trên Git

| Thành viên | GitHub Account | Nhánh Git phụ trách | File & Thành phần trực tiếp commit | Quy ước Commit mẫu |
| :--- | :--- | :---: | :--- | :--- |
| **Tuấn Minh** | `@TuanMinh685` | `tuanminh` ➔ PR vào `main` | • `supabase_schema_and_data.sql`<br>• Khởi tạo DB, cấu trúc 10 bảng, PK/FK<br>• Hàm `fn_TimPhongTrong`, `fn_TinhToanChiPhiDatPhong`<br>• Thủ tục `sp_ThucHienCheckIn`, `sp_ThucHienCheckOut`<br>• Review & Merge các Pull Request vào `main` | `feat(db): create initial 10 tables and relations`<br>`feat(sp): implement sp_ThucHienCheckIn with ACID`<br>`docs(report): draft Chapter 1 and Chapter 3.2` |
| **Nhân** | `@nhan2546789` | `nhan` ➔ PR vào `main` | • Cấu trúc bảng `NhatKyHeThong`<br>• 4 Triggers: `trg_DongBoTrangThaiPhong`, `trg_XuLyVoucherHoaDon` (lock `FOR UPDATE`), `trg_CapNhatTienDichVuHoaDon`, `trg_KiemTraTrungLichDatPhong`<br>• Script phân quyền RBAC (`role_quan_tri_ks`, `role_le_tan_ks`) | `feat(triggers): add trg_KiemTraTrungLichDatPhong`<br>`feat(lock): apply pessimistic lock on voucher update`<br>`feat(rbac): create roles and grant permissions` |
| **Thanh Phương** | `@thanhphuong` / `@xuanhong2004` | `thanhphuong` ➔ PR vào `main` | • 5 Views khai thác: `vw_KhaiThacDoanhThuTheoThang`, `vw_KhaiThacCongSuatLoaiPhong`, `vw_KhaiThacTopDichVu`, `vw_KhaiThacKhachHangVIP`, `vw_KhaiThacDashboardTongHop`<br>• 6 Composite Indexes trên `DatPhong`, `KhachHang`, `HoaDon`<br>• Script đo lường `EXPLAIN ANALYZE` | `feat(views): add 5 analytic views for hotel reporting`<br>`perf(index): optimize queries with composite indexes`<br>`docs(report): complete Chapter 4 analytic findings` |

### 3. Quy trình phối hợp làm việc hàng ngày qua Git (Standard Workflow)
1. **Đồng bộ nhánh trước khi code:**
   ```bash
   git checkout <ten_nhanh_ca_nhan>
   git pull origin main
   ```
2. **Commit công việc theo chuẩn Conventional Commits:**
   ```bash
   git add <cac_file_chinh_sua>
   git commit -m "feat(phan_he): mo_ta_ngan_gon_cong_viec"
   git push origin <ten_nhanh_ca_nhan>
   ```
3. **Tạo Pull Request (PR) trên GitHub:**
   - Đặt tiêu đề rõ ràng: `[ChuyenDe1] Tên chức năng - Người thực hiện`.
   - Trưởng nhóm kiểm tra tính toàn vẹn (không gây lỗi cú pháp SQL), sau đó xác nhận `Merge Pull Request` vào nhánh `main`.
4. **Minh chứng Git đưa vào Báo cáo Word:**
   - Chụp ảnh biểu đồ đóng góp **GitHub Insights ➔ Contributors** (chứng minh cả 3 bạn đều có commit đều đặn).
   - Chụp ảnh danh sách các Pull Request đã được merge thành công đưa vào Phụ lục báo cáo.

