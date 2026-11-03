# CHUYÊN ĐỀ 1: KHAI THÁC HỆ CƠ SỞ DỮ LIỆU
**MÃ HỌC PHẦN:** INT51309 (6 TÍN CHỈ)  
**TRƯỜNG ĐẠI HỌC VĂN HIẾN - KHOA CÔNG NGHỆ THÔNG TIN**  
**GIẢNG VIÊN HƯỚNG DẪN:** THẦY LƯƠNG THÁI HIỀN  
**NHÓM THỰC HIỆN:** TUẤN MINH, NHÂN & THANH PHƯƠNG  
**ĐỀ TÀI:** THIẾT KẾ, TỐI ƯU VÀ KHAI THÁC CƠ SỞ DỮ LIỆU HỆ THỐNG QUẢN LÝ KHÁCH SẠN AN NHIÊN  

---

## 📁 CẤU TRÚC KHO LƯU TRỮ

1. **`chuyen_de_1_khai_thac_csdl.sql`**:
   - File script SQL nâng cao cốt lõi phục vụ bảo vệ đồ án:
     - **4 Triggers** PL/pgSQL toàn vẹn dữ liệu (Đồng bộ buồng phòng, Trừ voucher với pessimistic lock, Tự tính tiền dịch vụ, Chặn double-booking).
     - **2 Functions** tìm phòng trống và tính chi phí lưu trú.
     - **2 Stored Procedures** Check-in và Check-out giao dịch an toàn (Transaction ACID).
     - **5 Analytic Views** khai thác dữ liệu doanh thu, công suất phòng, top dịch vụ, phân hạng khách VIP.
     - **6 Composite Indexes** tối ưu hóa truy vấn hiệu năng cao (`EXPLAIN ANALYZE`).
     - **Role-Based Access Control (RBAC)** phân quyền Admin vs Lễ tân.

2. **`CHUYEN_DE_1_BAO_CAO_CSDL.md`**:
   - Thuyết minh báo cáo hoàn chỉnh phục vụ in ấn nộp bài: Sơ đồ ERD (Mermaid), Từ điển dữ liệu (Data Dictionary), Chứng minh chuẩn hóa 3NF/BCNF, Giải thích chi tiết thuật toán của từng Trigger, Stored Procedure và View.

3. **`supabase_schema_and_data.sql`**:
   - Script tạo 10 bảng thực thể ban đầu và dữ liệu mẫu (phòng, loại phòng, nhân viên, dịch vụ, voucher, tài khoản).

4. **`QLKS.sql`**:
   - Script SQL Server dự phòng tham khảo.

---

## 🚀 HƯỚNG DẪN CHẠY TRÊN SUPABASE / POSTGRESQL

1. Đăng nhập vào **Supabase** ➔ Mở **SQL Editor**.
2. Chạy file `supabase_schema_and_data.sql` để tạo bảng và nạp dữ liệu mẫu ban đầu.
3. Chạy file `chuyen_de_1_khai_thac_csdl.sql` để thiết lập toàn bộ Trigger, Procedure, View, Index và Phân quyền.
4. Truy vấn thử các View phân tích:
   ```sql
   SELECT * FROM vw_KhaiThacDoanhThuTheoThang;
   SELECT * FROM vw_KhaiThacCongSuatLoaiPhong;
   SELECT * FROM vw_KhaiThacTopDichVu;
   SELECT * FROM vw_KhaiThacKhachHangVIP;
   SELECT * FROM vw_KhaiThacDashboardTongHop;
   ```
