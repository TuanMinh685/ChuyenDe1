-- ============================================================================
-- TRƯỜNG ĐẠI HỌC VĂN HIẾN - KHOA CÔNG NGHỆ THÔNG TIN
-- HỌC PHẦN: CHUYÊN ĐỀ 1: KHAI THÁC HỆ CƠ SỞ DỮ LIỆU (MÃ HP: INT51309 - 6 TÍN CHỈ)
-- GIẢNG VIÊN HƯỚNG DẪN: THẦY LƯƠNG THÁI HIỀN
-- ĐỀ TÀI: KHAI THÁC & QUẢN TRỊ CSDL HỆ THỐNG QUẢN LÝ KHÁCH SẠN AN NHIÊN
-- HỆ QUẢN TRỊ CSDL: POSTGRESQL 15+ / SUPABASE
-- ============================================================================

-- ============================================================================
-- PHẦN 1: BỔ SUNG CẤU TRÚC PHỤ TRỢ (LOG & TIỆN NGHI NÂNG CAO)
-- ============================================================================

-- 1.1 Bảng lưu vết lịch sử biến động phòng và trạng thái đặt phòng
CREATE TABLE IF NOT EXISTS NhatKyHeThong (
    MaNhatKy        SERIAL PRIMARY KEY,
    LoaiHanhDong    VARCHAR(50)   NOT NULL, -- 'CHECK_IN', 'CHECK_OUT', 'DAT_PHONG', 'HUY_PHONG', 'AP_VOUCHER'
    BangTacDong     VARCHAR(50)   NOT NULL,
    KhoaChinh       VARCHAR(50)   NOT NULL,
    GiaTriCu        TEXT          NULL,
    GiaTriMoi       TEXT          NULL,
    NguoiThucHien   VARCHAR(100)  DEFAULT CURRENT_USER,
    ThoiGian        TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    MoTaChiTiet     TEXT          NULL
);

-- 1.2 Bổ sung cột GioTraThucTe / GioNhanThucTe nếu bảng cũ chưa có
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'datphong' AND column_name = 'gionhanthucte') THEN
        ALTER TABLE DatPhong ADD COLUMN GioNhanThucTe TIMESTAMP NULL;
    END IF;
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'datphong' AND column_name = 'giotrathucte') THEN
        ALTER TABLE DatPhong ADD COLUMN GioTraThucTe TIMESTAMP NULL;
    END IF;
END $$;

-- ============================================================================
-- PHẦN 2: LẬP TRÌNH TRIGGER TỰ ĐỘNG HÓA & TOÀN VẸN DỮ LIỆU (TRIGGERS)
-- ============================================================================

-- ----------------------------------------------------------------------------
-- TRIGGER 1: Tự động đồng bộ trạng thái phòng khi nhận phòng / trả phòng / hủy
-- Nghiệp vụ: 
--  - Khi đơn chuyển sang 'Đang ở' -> Phòng đổi thành 'Đang sử dụng'
--  - Khi đơn chuyển sang 'Đã trả' -> Phòng đổi thành 'Chờ dọn dẹp'
--  - Khi đơn chuyển sang 'Đã hủy' -> Nếu phòng chưa có ai ở thì trả về 'Hoạt động'
-- ----------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION fn_trg_DongBoTrangThaiPhong()
RETURNS TRIGGER AS $$
BEGIN
    -- 1. Khách nhận phòng (Check-in)
    IF (NEW.TrangThai = 'Đang ở' AND (OLD.TrangThai IS NULL OR OLD.TrangThai <> 'Đang ở')) THEN
        UPDATE Phong 
        SET TinhTrang = 'Đang sử dụng'
        WHERE MaPhong = NEW.MaPhong;

        NEW.GioNhanThucTe := COALESCE(NEW.GioNhanThucTe, CURRENT_TIMESTAMP);

        -- Ghi nhật ký
        INSERT INTO NhatKyHeThong (LoaiHanhDong, BangTacDong, KhoaChinh, GiaTriCu, GiaTriMoi, MoTaChiTiet)
        VALUES ('CHECK_IN', 'DatPhong', NEW.MaDatPhong::TEXT, OLD.TrangThai, NEW.TrangThai, 
                'Khách đã nhận phòng thành công tại phòng mã ' || NEW.MaPhong);
    END IF;

    -- 2. Khách trả phòng (Check-out)
    IF (NEW.TrangThai = 'Đã trả' AND (OLD.TrangThai IS NULL OR OLD.TrangThai <> 'Đã trả')) THEN
        UPDATE Phong 
        SET TinhTrang = 'Chờ dọn dẹp'
        WHERE MaPhong = NEW.MaPhong;

        NEW.GioTraThucTe := COALESCE(NEW.GioTraThucTe, CURRENT_TIMESTAMP);

        -- Ghi nhật ký
        INSERT INTO NhatKyHeThong (LoaiHanhDong, BangTacDong, KhoaChinh, GiaTriCu, GiaTriMoi, MoTaChiTiet)
        VALUES ('CHECK_OUT', 'DatPhong', NEW.MaDatPhong::TEXT, OLD.TrangThai, NEW.TrangThai, 
                'Khách đã hoàn tất trả phòng, phòng chuyển trạng thái chờ dọn dẹp.');
    END IF;

    -- 3. Hủy đơn đặt phòng
    IF (NEW.TrangThai = 'Đã hủy' AND (OLD.TrangThai IS NULL OR OLD.TrangThai <> 'Đã hủy')) THEN
        -- Chỉ trả về 'Hoạt động' nếu không có khách khác đang ở phòng này
        IF NOT EXISTS (SELECT 1 FROM DatPhong WHERE MaPhong = NEW.MaPhong AND TrangThai = 'Đang ở' AND MaDatPhong <> NEW.MaDatPhong) THEN
            UPDATE Phong 
            SET TinhTrang = 'Hoạt động'
            WHERE MaPhong = NEW.MaPhong;
        END IF;

        NEW.NgayHuy := COALESCE(NEW.NgayHuy, CURRENT_TIMESTAMP);

        INSERT INTO NhatKyHeThong (LoaiHanhDong, BangTacDong, KhoaChinh, GiaTriCu, GiaTriMoi, MoTaChiTiet)
        VALUES ('HUY_PHONG', 'DatPhong', NEW.MaDatPhong::TEXT, OLD.TrangThai, NEW.TrangThai, 
                'Hủy đơn đặt phòng. Lý do: ' || COALESCE(NEW.LyDoHuy, 'Không nêu'));
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_DongBoTrangThaiPhong ON DatPhong;
CREATE TRIGGER trg_DongBoTrangThaiPhong
BEFORE UPDATE OF TrangThai ON DatPhong
FOR EACH ROW
EXECUTE FUNCTION fn_trg_DongBoTrangThaiPhong();


-- ----------------------------------------------------------------------------
-- TRIGGER 2: Tự động trừ số lượng Voucher và khóa khi hết lượt
-- Nghiệp vụ: Đảm bảo kiểm tra hạn dùng, số lượng khả dụng và tự trừ trong CSDL
-- ----------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION fn_trg_XuLyVoucherHoaDon()
RETURNS TRIGGER AS $$
DECLARE
    v_SoLuong INT;
    v_HetHan DATE;
    v_TrangThai BOOLEAN;
BEGIN
    IF NEW.MaVoucher IS NOT NULL THEN
        SELECT SoLuong, NgayHetHan, TrangThai 
        INTO v_SoLuong, v_HetHan, v_TrangThai
        FROM Voucher 
        WHERE MaVoucher = NEW.MaVoucher
        FOR UPDATE; -- Khóa bi quan (pessimistic lock) chống race condition

        -- Kiểm tra hợp lệ
        IF NOT FOUND THEN
            RAISE EXCEPTION 'Mã voucher không tồn tại trong hệ thống!';
        END IF;

        IF v_TrangThai = FALSE THEN
            RAISE EXCEPTION 'Mã voucher này hiện đang bị tạm khóa hoặc đã hết hiệu lực!';
        END IF;

        IF v_HetHan < CURRENT_DATE THEN
            RAISE EXCEPTION 'Mã voucher đã hết hạn sử dụng vào ngày %!', v_HetHan;
        END IF;

        IF v_SoLuong IS NOT NULL AND v_SoLuong <= 0 THEN
            RAISE EXCEPTION 'Mã voucher này đã hết lượt sử dụng!';
        END IF;

        -- Trừ số lượng
        IF v_SoLuong IS NOT NULL THEN
            UPDATE Voucher
            SET SoLuong = SoLuong - 1,
                TrangThai = CASE WHEN (SoLuong - 1) <= 0 THEN FALSE ELSE TRUE END
            WHERE MaVoucher = NEW.MaVoucher;
        END IF;

        INSERT INTO NhatKyHeThong (LoaiHanhDong, BangTacDong, KhoaChinh, GiaTriCu, GiaTriMoi, MoTaChiTiet)
        VALUES ('AP_VOUCHER', 'HoaDon', NEW.MaHoaDon, NULL, NEW.MaVoucher::TEXT, 
                'Đã áp dụng voucher cho hóa đơn ' || NEW.MaHoaDon || '. Số lượng còn lại: ' || COALESCE((v_SoLuong - 1)::TEXT, 'Vô hạn'));
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_XuLyVoucherHoaDon ON HoaDon;
CREATE TRIGGER trg_XuLyVoucherHoaDon
AFTER INSERT ON HoaDon
FOR EACH ROW
EXECUTE FUNCTION fn_trg_XuLyVoucherHoaDon();


-- ----------------------------------------------------------------------------
-- TRIGGER 3: Tự động tính Thành tiền chi tiết hóa đơn & cập nhật tổng tiền
-- Nghiệp vụ: Đảm bảo tính nhất quán (Consistency), không bị sai lệch số liệu
-- ----------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION fn_trg_CapNhatTienDichVuHoaDon()
RETURNS TRIGGER AS $$
DECLARE
    v_MaHD VARCHAR(20);
    v_TongTienDV NUMERIC(18,2);
BEGIN
    v_MaHD := COALESCE(NEW.MaHoaDon, OLD.MaHoaDon);

    -- Tự động điền đơn giá và thành tiền nếu INSERT chưa có
    IF (TG_OP = 'INSERT' OR TG_OP = 'UPDATE') THEN
        IF NEW.DonGia IS NULL OR NEW.DonGia <= 0 THEN
            SELECT DonGia INTO NEW.DonGia FROM DichVu WHERE MaDichVu = NEW.MaDichVu;
        END IF;
        NEW.ThanhTien := COALESCE(NEW.SoLuong, 1) * COALESCE(NEW.DonGia, 0);
    END IF;

    -- Tính lại tổng tiền dịch vụ của hóa đơn
    SELECT COALESCE(SUM(ThanhTien), 0) INTO v_TongTienDV
    FROM ChiTietHoaDon
    WHERE MaHoaDon = v_MaHD;

    -- Cập nhật ngược lại bảng HoaDon
    UPDATE HoaDon
    SET TienDichVu = v_TongTienDV,
        TongTien = GREATEST(0, (TienPhong + v_TongTienDV - TienGiamGia - TienDatCoc))
    WHERE MaHoaDon = v_MaHD;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_CapNhatTienDichVuHoaDon ON ChiTietHoaDon;
CREATE TRIGGER trg_CapNhatTienDichVuHoaDon
AFTER INSERT OR UPDATE OR DELETE ON ChiTietHoaDon
FOR EACH ROW
EXECUTE FUNCTION fn_trg_CapNhatTienDichVuHoaDon();


-- ----------------------------------------------------------------------------
-- TRIGGER 4: Ngăn chặn đặt phòng trùng lịch (Anti Double-Booking Trigger)
-- ----------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION fn_trg_KiemTraTrungLichDatPhong()
RETURNS TRIGGER AS $$
BEGIN
    -- Kiểm tra xem có phòng nào trùng khoảng thời gian (Overlap) ở trạng thái 'Đã đặt' hoặc 'Đang ở'
    IF EXISTS (
        SELECT 1 FROM DatPhong
        WHERE MaPhong = NEW.MaPhong
          AND TrangThai IN ('Đã đặt', 'Đang ở')
          AND MaDatPhong <> COALESCE(NEW.MaDatPhong, 0)
          AND (NEW.NgayNhan < NgayTra AND NEW.NgayTra > NgayNhan)
    ) THEN
        RAISE EXCEPTION 'Xung đột lịch: Phòng % đã có đơn đặt trong khoảng từ % đến %!', 
            NEW.MaPhong, NEW.NgayNhan, NEW.NgayTra;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_KiemTraTrungLichDatPhong ON DatPhong;
CREATE TRIGGER trg_KiemTraTrungLichDatPhong
BEFORE INSERT OR UPDATE OF MaPhong, NgayNhan, NgayTra, TrangThai ON DatPhong
FOR EACH ROW
EXECUTE FUNCTION fn_trg_KiemTraTrungLichDatPhong();


-- ============================================================================
-- PHẦN 3: HÀM & THỦ TỤC NGHIỆP VỤ NÂNG CAO (STORED PROCEDURES & FUNCTIONS)
-- ============================================================================

-- ----------------------------------------------------------------------------
-- FUNCTION 1: Tìm kiếm phòng khả dụng theo khoảng ngày & tiêu chí lọc
-- Trả về Table chứa danh sách phòng trống kèm giá và tiện nghi
-- ----------------------------------------------------------------------------
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
    -- Kiểm tra logic ngày hợp lệ
    IF p_NgayNhan >= p_NgayTra THEN
        RAISE EXCEPTION 'Ngày nhận phòng (%) phải trước ngày trả phòng (%)!', p_NgayNhan, p_NgayTra;
    END IF;

    RETURN QUERY
    SELECT 
        p.MaPhong,
        p.SoPhong,
        p.Tang,
        p.MaLoai,
        lp.TenLoai,
        lp.GiaMotDem,
        lp.SoNguoiToiDa,
        p.MoTaGiuong,
        p.DienTich,
        p.TinhTrang
    FROM Phong p
    JOIN LoaiPhong lp ON p.MaLoai = lp.MaLoai
    WHERE p.TinhTrang IN ('Hoạt động', 'Trống', 'Đã dọn dẹp')
      AND (p_MaLoai IS NULL OR p.MaLoai = p_MaLoai)
      AND (lp.SoNguoiToiDa >= p_SoNguoi)
      AND NOT EXISTS (
          SELECT 1 
          FROM DatPhong dp
          WHERE dp.MaPhong = p.MaPhong
            AND dp.TrangThai IN ('Đã đặt', 'Đang ở')
            AND (p_NgayNhan < dp.NgayTra AND p_NgayTra > dp.NgayNhan)
      )
    ORDER BY p.Tang, p.SoPhong;
END;
$$ LANGUAGE plpgsql;


-- ----------------------------------------------------------------------------
-- FUNCTION 2: Tính toán chi tiết chi phí đặt phòng (Ước tính giá & Tiền cọc)
-- ----------------------------------------------------------------------------
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

    -- Phụ thu nếu trên 2 người lớn (150.000 đ/người/đêm)
    IF p_SoNguoiLon > 2 THEN
        v_PhuThu := v_PhuThu + ((p_SoNguoiLon - 2) * 150000 * v_SoDem);
    END IF;

    -- Phụ thu trẻ em (80.000 đ/bé/đêm)
    IF p_SoTreEm > 0 THEN
        v_PhuThu := v_PhuThu + (p_SoTreEm * 80000 * v_SoDem);
    END IF;

    -- Thuế và phí
    v_Thue := (v_TienGoc + v_PhuThu) * p_PhanTramVAT;
    v_Tong := v_TienGoc + v_PhuThu + v_Thue;

    RETURN QUERY
    SELECT 
        v_SoDem,
        v_TienGoc,
        v_PhuThu,
        v_Thue,
        v_Tong,
        ROUND(v_Tong * 0.30, -3); -- Tiền cọc 30% làm tròn nghìn
END;
$$ LANGUAGE plpgsql;


-- ----------------------------------------------------------------------------
-- PROCEDURE 1: Quy trình Check-in nhận phòng an toàn (Transaction ACID)
-- ----------------------------------------------------------------------------
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
    -- Kiểm tra sự tồn tại và khóa dòng dữ liệu
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
        RAISE EXCEPTION 'Chưa đến ngày nhận phòng (Ngày nhận: %). Chỉ nhận phòng từ ngày nhận trở đi!', v_NgayNhan;
    END IF;

    -- Kiểm tra phòng có đang bị khách khác ở không
    IF EXISTS (SELECT 1 FROM DatPhong WHERE MaPhong = v_MaPhong AND TrangThai = 'Đang ở' AND MaDatPhong <> p_MaDatPhong) THEN
        RAISE EXCEPTION 'Phòng % hiện đang có khách lưu trú chưa trả phòng!', v_SoPhong;
    END IF;

    -- Cập nhật trạng thái nhận phòng
    UPDATE DatPhong
    SET TrangThai = 'Đang ở',
        GioNhanThucTe = CURRENT_TIMESTAMP,
        MaNhanVien = COALESCE(p_MaNhanVien, MaNhanVien)
    WHERE MaDatPhong = p_MaDatPhong;

    -- Đồng bộ trạng thái buồng phòng
    UPDATE Phong
    SET TinhTrang = 'Đang sử dụng'
    WHERE MaPhong = v_MaPhong;

    RAISE NOTICE 'Đã thực hiện Check-in thành công cho đơn đặt phòng % (Phòng %)', p_MaDatPhong, v_SoPhong;
END;
$$;


-- ----------------------------------------------------------------------------
-- PROCEDURE 2: Quy trình Check-out, tính toán hóa đơn và đóng buồng phòng
-- ----------------------------------------------------------------------------
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
    -- 1. Lấy thông tin đơn đặt phòng
    SELECT dp.MaDat, dp.MaPhong, p.SoPhong, COALESCE(dp.TongTien, 0), COALESCE(dp.TienCoc, 0)
    INTO v_MaDat, v_MaPhong, v_SoPhong, v_TienPhong, v_TienCoc
    FROM DatPhong dp
    JOIN Phong p ON dp.MaPhong = p.MaPhong
    WHERE dp.MaDatPhong = p_MaDatPhong AND dp.TrangThai = 'Đang ở'
    FOR UPDATE;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Không tìm thấy đơn đặt phòng đang ở có mã: %!', p_MaDatPhong;
    END IF;

    -- 2. Sinh mã hóa đơn nếu chưa truyền vào (HD-YYYYMMDD-XXXX)
    IF p_MaHoaDon IS NULL OR p_MaHoaDon = '' THEN
        p_MaHoaDon := 'HD' || TO_CHAR(CURRENT_TIMESTAMP, 'YYYYMMDD') || LPAD(p_MaDatPhong::TEXT, 4, '0');
    END IF;

    -- 3. Tính tiền dịch vụ phát sinh (nếu có chi tiết tạm gán)
    SELECT COALESCE(SUM(ThanhTien), 0) INTO v_TienDV
    FROM ChiTietHoaDon
    WHERE MaHoaDon = p_MaHoaDon;

    -- 4. Tính giảm giá voucher (nếu có)
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

    -- 5. Tổng tiền thực tế cần thanh toán
    v_TongCanThu := GREATEST(0, (v_TienPhong + v_TienDV - v_TienCoc - v_TienGiam));

    -- 6. Ghi nhận hóa đơn thanh toán
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

    -- 7. Cập nhật đơn đặt phòng sang 'Đã trả'
    UPDATE DatPhong
    SET TrangThai = 'Đã trả',
        GioTraThucTe = CURRENT_TIMESTAMP
    WHERE MaDatPhong = p_MaDatPhong;

    -- 8. Cập nhật phòng sang 'Chờ dọn dẹp'
    UPDATE Phong
    SET TinhTrang = 'Chờ dọn dẹp'
    WHERE MaPhong = v_MaPhong;

    RAISE NOTICE 'Đã Check-out và xuất hóa đơn % thành công cho phòng %. Tổng thu: % VNĐ', 
        p_MaHoaDon, v_SoPhong, v_TongCanThu;
END;
$$;


-- ============================================================================
-- PHẦN 4: KHAI THÁC & THỐNG KÊ DỮ LIỆU ĐA CHIỀU (ANALYTIC VIEWS)
-- ============================================================================

-- ----------------------------------------------------------------------------
-- VIEW 1: Doanh thu kinh doanh theo tháng & cơ cấu thu chi
-- ----------------------------------------------------------------------------
CREATE OR REPLACE VIEW vw_KhaiThacDoanhThuTheoThang AS
SELECT 
    TO_CHAR(COALESCE(hd.NgayThanhToan, hd.NgayLap), 'YYYY-MM') AS ThangNam,
    COUNT(hd.MaHoaDon)                                         AS TongSoHoaDon,
    SUM(hd.TienPhong)                                          AS DoanhThuTienPhong,
    SUM(hd.TienDichVu)                                         AS DoanhThuDichVu,
    SUM(hd.TienGiamGia)                                        AS TongTienUuDai,
    SUM(hd.TongTien)                                           AS DoanhThuThucThu,
    ROUND(AVG(hd.TongTien), 2)                                 AS GiaTriHoaDonTrungBinh,
    COUNT(CASE WHEN hd.MaPTTT IN ('VNPAY', 'MOMO', 'APPLEPAY', 'CK', 'POS') THEN 1 END) AS SoGiaoDichKhongTienMat
FROM HoaDon hd
WHERE hd.TrangThai = 'Đã thanh toán'
GROUP BY TO_CHAR(COALESCE(hd.NgayThanhToan, hd.NgayLap), 'YYYY-MM')
ORDER BY ThangNam DESC;


-- ----------------------------------------------------------------------------
-- VIEW 2: Tỷ lệ lấp đầy phòng (Occupancy Rate) theo từng Loại phòng
-- ----------------------------------------------------------------------------
CREATE OR REPLACE VIEW vw_KhaiThacCongSuatLoaiPhong AS
SELECT 
    lp.MaLoai,
    lp.TenLoai,
    lp.GiaMotDem,
    COUNT(DISTINCT p.MaPhong)                                AS TongSoPhong,
    COUNT(DISTINCT CASE WHEN p.TinhTrang = 'Đang sử dụng' THEN p.MaPhong END) AS SoPhongDangCoKhach,
    COUNT(DISTINCT CASE WHEN p.TinhTrang = 'Chờ dọn dẹp' THEN p.MaPhong END)  AS SoPhongChoDon,
    COUNT(DISTINCT CASE WHEN p.TinhTrang IN ('Hoạt động', 'Trống') THEN p.MaPhong END) AS SoPhongSanSangDonKhach,
    ROUND(
        COUNT(DISTINCT CASE WHEN p.TinhTrang = 'Đang sử dụng' THEN p.MaPhong END)::NUMERIC / 
        NULLIF(COUNT(DISTINCT p.MaPhong), 0) * 100, 
        2
    ) AS TyLeLapDayPhanTram
FROM LoaiPhong lp
LEFT JOIN Phong p ON lp.MaLoai = p.MaLoai
GROUP BY lp.MaLoai, lp.TenLoai, lp.GiaMotDem
ORDER BY lp.MaLoai;


-- ----------------------------------------------------------------------------
-- VIEW 3: Xếp hạng Dịch vụ phụ trợ được khách hàng ưa chuộng nhất
-- ----------------------------------------------------------------------------
CREATE OR REPLACE VIEW vw_KhaiThacTopDichVu AS
SELECT 
    dv.MaDichVu,
    dv.TenDichVu,
    dv.LoaiDichVu,
    dv.DonGia,
    COALESCE(SUM(ct.SoLuong), 0)                             AS TongSoLuongDaBan,
    COALESCE(SUM(ct.ThanhTien), 0)                           AS TongDoanhThuDichVu,
    DENSE_RANK() OVER (ORDER BY COALESCE(SUM(ct.ThanhTien), 0) DESC) AS XepHangDoanhThu
FROM DichVu dv
LEFT JOIN ChiTietHoaDon ct ON dv.MaDichVu = ct.MaDichVu
GROUP BY dv.MaDichVu, dv.TenDichVu, dv.LoaiDichVu, dv.DonGia
ORDER BY TongDoanhThuDichVu DESC;


-- ----------------------------------------------------------------------------
-- VIEW 4: Phân khúc khách hàng VIP & Thân thiết (RFM Analytics)
-- ----------------------------------------------------------------------------
CREATE OR REPLACE VIEW vw_KhaiThacKhachHangVIP AS
SELECT 
    kh.MaKH,
    kh.MaKHHienThi,
    kh.HoTen,
    kh.SoDienThoai,
    kh.QuocTich,
    COUNT(dp.MaDatPhong)                                     AS SoLanDatPhong,
    MAX(dp.NgayNhan)                                         AS LanDatPhongGanNhat,
    COALESCE(SUM(hd.TongTien), 0)                            AS TongChiTieu,
    CASE 
        WHEN COALESCE(SUM(hd.TongTien), 0) >= 15000000 THEN '💎 VIP Kim Cương'
        WHEN COALESCE(SUM(hd.TongTien), 0) >= 7000000  THEN '🥇 VIP Vàng'
        WHEN COUNT(dp.MaDatPhong) >= 3                 THEN '🥈 Thân thiết'
        ELSE 'Khách mới'
    END AS HangThanhVien
FROM KhachHang kh
LEFT JOIN DatPhong dp ON kh.MaKH = dp.MaKH
LEFT JOIN HoaDon hd ON (hd.MaDatPhong = dp.MaDat OR CAST(dp.MaDatPhong AS TEXT) = hd.MaDatPhong) AND hd.TrangThai = 'Đã thanh toán'
GROUP BY kh.MaKH, kh.MaKHHienThi, kh.HoTen, kh.SoDienThoai, kh.QuocTich
ORDER BY TongChiTieu DESC;


-- ----------------------------------------------------------------------------
-- VIEW 5: Bảng tổng quan Dashboard cho Giám đốc / Lễ tân ca trực
-- ----------------------------------------------------------------------------
CREATE OR REPLACE VIEW vw_KhaiThacDashboardTongHop AS
SELECT 
    (SELECT COUNT(*) FROM Phong)                                                AS TongSoPhong,
    (SELECT COUNT(*) FROM Phong WHERE TinhTrang = 'Đang sử dụng')               AS PhongDangO,
    (SELECT COUNT(*) FROM Phong WHERE TinhTrang = 'Chờ dọn dẹp')                AS PhongChoDon,
    (SELECT COUNT(*) FROM DatPhong WHERE TrangThai = 'Đã đặt' AND NgayNhan = CURRENT_DATE) AS CheckInHomNay,
    (SELECT COUNT(*) FROM DatPhong WHERE TrangThai = 'Đang ở' AND NgayTra = CURRENT_DATE)  AS CheckOutHomNay,
    (SELECT COALESCE(SUM(TongTien), 0) FROM HoaDon WHERE CAST(NgayThanhToan AS DATE) = CURRENT_DATE) AS DoanhThuHomNay,
    (SELECT COALESCE(SUM(TongTien), 0) FROM HoaDon WHERE DATE_TRUNC('month', NgayThanhToan) = DATE_TRUNC('month', CURRENT_DATE)) AS DoanhThuThangNay;


-- ============================================================================
-- PHẦN 5: TỐI ƯU HÓA TRUY VẤN VỚI CHỈ MỤC (INDEXING & PERFORMANCE TUNING)
-- ============================================================================

-- Đánh chỉ mục B-Tree trên các trường khóa ngoại, tìm kiếm và lọc thời gian
CREATE INDEX IF NOT EXISTS IX_DatPhong_NgayNhan_NgayTra 
    ON DatPhong (NgayNhan, NgayTra, TrangThai);

CREATE INDEX IF NOT EXISTS IX_DatPhong_Phong_TrangThai 
    ON DatPhong (MaPhong, TrangThai);

CREATE INDEX IF NOT EXISTS IX_KhachHang_SDT_HoTen 
    ON KhachHang (SoDienThoai, HoTen);

CREATE INDEX IF NOT EXISTS IX_HoaDon_NgayThanhToan_TrangThai 
    ON HoaDon (NgayThanhToan, TrangThai, TongTien);

CREATE INDEX IF NOT EXISTS IX_ChiTietHoaDon_MaHD 
    ON ChiTietHoaDon (MaHoaDon, MaDichVu);

CREATE INDEX IF NOT EXISTS IX_Voucher_Code_HieuLuc 
    ON Voucher (Code, TrangThai, NgayHetHan);


-- ============================================================================
-- PHẦN 6: BẢO MẬT PHÂN QUYỀN (ROLE-BASED ACCESS CONTROL - RBAC)
-- ============================================================================

DO $$
BEGIN
    -- Tạo Role Quản Trị Viên (Admin)
    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'role_quan_tri_ks') THEN
        CREATE ROLE role_quan_tri_ks WITH LOGIN PASSWORD 'Admin@Hotel2026';
    END IF;

    -- Tạo Role Nhân Viên Lễ Tân
    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'role_le_tan_ks') THEN
        CREATE ROLE role_le_tan_ks WITH LOGIN PASSWORD 'LeTan@Hotel2026';
    END IF;
END $$;

-- Phân quyền cho Quản Trị Viên: Toàn quyền trên Schema public
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO role_quan_tri_ks;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO role_quan_tri_ks;
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public TO role_quan_tri_ks;

-- Phân quyền cho Lễ Tân: Chỉ quyền nghiệp vụ, không quyền phá hủy cấu trúc
GRANT SELECT, INSERT, UPDATE ON DatPhong, KhachHang, HoaDon, ChiTietHoaDon, Phong, LichSuLuuTru TO role_le_tan_ks;
GRANT SELECT ON LoaiPhong, DichVu, Voucher, PhuongThucThanhToan, vw_KhaiThacDoanhThuTheoThang, vw_KhaiThacCongSuatLoaiPhong, vw_KhaiThacTopDichVu, vw_KhaiThacKhachHangVIP, vw_KhaiThacDashboardTongHop TO role_le_tan_ks;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO role_le_tan_ks;
GRANT EXECUTE ON FUNCTION fn_TimPhongTrong, fn_TinhToanChiPhiDatPhong TO role_le_tan_ks;
GRANT EXECUTE ON PROCEDURE sp_ThucHienCheckIn, sp_ThucHienCheckOut TO role_le_tan_ks;

-- Ngăn chặn Lễ tân xem cột mật khẩu trong bảng TaiKhoan
REVOKE ALL ON TaiKhoan FROM role_le_tan_ks;

-- ============================================================================
-- THÔNG BÁO HOÀN THÀNH KỊCH BẢN CHUYÊN ĐỀ 1
-- ============================================================================
DO $$
BEGIN
    RAISE NOTICE '=============================================================';
    RAISE NOTICE '🎉 KỊCH BẢN NÂNG CAO CHUYÊN ĐỀ 1: KHAI THÁC CSDL ĐÃ ĐƯỢC THIẾT LẬP THÀNH CÔNG!';
    RAISE NOTICE '• 4 Triggers toàn vẹn (Đồng bộ phòng, Trừ voucher, Tự tính tiền, Chống double booking)';
    RAISE NOTICE '• 2 Functions & 2 Stored Procedures nghiệp vụ (Tìm phòng, Tính giá, Check-in, Check-out)';
    RAISE NOTICE '• 5 Views phân tích khai thác số liệu (Doanh thu, Công suất, Top dịch vụ, Khách VIP, Dashboard)';
    RAISE NOTICE '• 6 Indexes tối ưu hóa truy vấn hiệu năng cao';
    RAISE NOTICE '• Phân quyền RBAC bảo mật hệ thống (Admin vs Lễ Tân)';
    RAISE NOTICE '=============================================================';
END $$;
