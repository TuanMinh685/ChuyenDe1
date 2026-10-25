-- ============================================================================
-- TR╞»ß╗£NG ─Éß║áI Hß╗îC V─éN HIß║╛N - KHOA C├öNG NGHß╗å TH├öNG TIN
-- Hß╗îC PHß║ªN: CHUY├èN ─Éß╗Ç 1: KHAI TH├üC Hß╗å C╞á Sß╗₧ Dß╗« LIß╗åU (M├â HP: INT51309 - 6 T├ìN CHß╗ê)
-- GIß║óNG VI├èN H╞»ß╗ÜNG Dß║¬N: THß║ªY L╞»╞áNG TH├üI HIß╗ÇN
-- ─Éß╗Ç T├ÇI: KHAI TH├üC & QUß║óN TRß╗è CSDL Hß╗å THß╗ÉNG QUß║óN L├¥ KH├üCH Sß║áN AN NHI├èN
-- Hß╗å QUß║óN TRß╗è CSDL: POSTGRESQL 15+ / SUPABASE
-- ============================================================================

-- ============================================================================
-- PHß║ªN 1: Bß╗ö SUNG Cß║ñU TR├ÜC PHß╗ñ TRß╗ó (LOG & TIß╗åN NGHI N├éNG CAO)
-- ============================================================================

-- 1.1 Bß║úng l╞░u vß║┐t lß╗ïch sß╗¡ biß║┐n ─æß╗Öng ph├▓ng v├á trß║íng th├íi ─æß║╖t ph├▓ng
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

-- 1.2 Bß╗ò sung cß╗Öt GioTraThucTe / GioNhanThucTe nß║┐u bß║úng c┼⌐ ch╞░a c├│
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
-- PHß║ªN 2: Lß║¼P TR├îNH TRIGGER Tß╗░ ─Éß╗ÿNG H├ôA & TO├ÇN Vß║╕N Dß╗« LIß╗åU (TRIGGERS)
-- ============================================================================

-- ----------------------------------------------------------------------------
-- TRIGGER 1: Tß╗▒ ─æß╗Öng ─æß╗ông bß╗Ö trß║íng th├íi ph├▓ng khi nhß║¡n ph├▓ng / trß║ú ph├▓ng / hß╗ºy
-- Nghiß╗çp vß╗Ñ: 
--  - Khi ─æ╞ín chuyß╗ân sang '─Éang ß╗ƒ' -> Ph├▓ng ─æß╗òi th├ánh '─Éang sß╗¡ dß╗Ñng'
--  - Khi ─æ╞ín chuyß╗ân sang '─É├ú trß║ú' -> Ph├▓ng ─æß╗òi th├ánh 'Chß╗¥ dß╗ìn dß║╣p'
--  - Khi ─æ╞ín chuyß╗ân sang '─É├ú hß╗ºy' -> Nß║┐u ph├▓ng ch╞░a c├│ ai ß╗ƒ th├¼ trß║ú vß╗ü 'Hoß║ít ─æß╗Öng'
-- ----------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION fn_trg_DongBoTrangThaiPhong()
RETURNS TRIGGER AS $$
BEGIN
    -- 1. Kh├ích nhß║¡n ph├▓ng (Check-in)
    IF (NEW.TrangThai = '─Éang ß╗ƒ' AND (OLD.TrangThai IS NULL OR OLD.TrangThai <> '─Éang ß╗ƒ')) THEN
        UPDATE Phong 
        SET TinhTrang = '─Éang sß╗¡ dß╗Ñng'
        WHERE MaPhong = NEW.MaPhong;

        NEW.GioNhanThucTe := COALESCE(NEW.GioNhanThucTe, CURRENT_TIMESTAMP);

        -- Ghi nhß║¡t k├╜
        INSERT INTO NhatKyHeThong (LoaiHanhDong, BangTacDong, KhoaChinh, GiaTriCu, GiaTriMoi, MoTaChiTiet)
        VALUES ('CHECK_IN', 'DatPhong', NEW.MaDatPhong::TEXT, OLD.TrangThai, NEW.TrangThai, 
                'Kh├ích ─æ├ú nhß║¡n ph├▓ng th├ánh c├┤ng tß║íi ph├▓ng m├ú ' || NEW.MaPhong);
    END IF;

    -- 2. Kh├ích trß║ú ph├▓ng (Check-out)
    IF (NEW.TrangThai = '─É├ú trß║ú' AND (OLD.TrangThai IS NULL OR OLD.TrangThai <> '─É├ú trß║ú')) THEN
        UPDATE Phong 
        SET TinhTrang = 'Chß╗¥ dß╗ìn dß║╣p'
        WHERE MaPhong = NEW.MaPhong;

        NEW.GioTraThucTe := COALESCE(NEW.GioTraThucTe, CURRENT_TIMESTAMP);

        -- Ghi nhß║¡t k├╜
        INSERT INTO NhatKyHeThong (LoaiHanhDong, BangTacDong, KhoaChinh, GiaTriCu, GiaTriMoi, MoTaChiTiet)
        VALUES ('CHECK_OUT', 'DatPhong', NEW.MaDatPhong::TEXT, OLD.TrangThai, NEW.TrangThai, 
                'Kh├ích ─æ├ú ho├án tß║Ñt trß║ú ph├▓ng, ph├▓ng chuyß╗ân trß║íng th├íi chß╗¥ dß╗ìn dß║╣p.');
    END IF;

    -- 3. Hß╗ºy ─æ╞ín ─æß║╖t ph├▓ng
    IF (NEW.TrangThai = '─É├ú hß╗ºy' AND (OLD.TrangThai IS NULL OR OLD.TrangThai <> '─É├ú hß╗ºy')) THEN
        -- Chß╗ë trß║ú vß╗ü 'Hoß║ít ─æß╗Öng' nß║┐u kh├┤ng c├│ kh├ích kh├íc ─æang ß╗ƒ ph├▓ng n├áy
        IF NOT EXISTS (SELECT 1 FROM DatPhong WHERE MaPhong = NEW.MaPhong AND TrangThai = '─Éang ß╗ƒ' AND MaDatPhong <> NEW.MaDatPhong) THEN
            UPDATE Phong 
            SET TinhTrang = 'Hoß║ít ─æß╗Öng'
            WHERE MaPhong = NEW.MaPhong;
        END IF;

        NEW.NgayHuy := COALESCE(NEW.NgayHuy, CURRENT_TIMESTAMP);

        INSERT INTO NhatKyHeThong (LoaiHanhDong, BangTacDong, KhoaChinh, GiaTriCu, GiaTriMoi, MoTaChiTiet)
        VALUES ('HUY_PHONG', 'DatPhong', NEW.MaDatPhong::TEXT, OLD.TrangThai, NEW.TrangThai, 
                'Hß╗ºy ─æ╞ín ─æß║╖t ph├▓ng. L├╜ do: ' || COALESCE(NEW.LyDoHuy, 'Kh├┤ng n├¬u'));
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
-- TRIGGER 2: Tß╗▒ ─æß╗Öng trß╗½ sß╗æ l╞░ß╗úng Voucher v├á kh├│a khi hß║┐t l╞░ß╗út
-- Nghiß╗çp vß╗Ñ: ─Éß║úm bß║úo kiß╗âm tra hß║ín d├╣ng, sß╗æ l╞░ß╗úng khß║ú dß╗Ñng v├á tß╗▒ trß╗½ trong CSDL
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
        FOR UPDATE; -- Kh├│a bi quan (pessimistic lock) chß╗æng race condition

        -- Kiß╗âm tra hß╗úp lß╗ç
        IF NOT FOUND THEN
            RAISE EXCEPTION 'M├ú voucher kh├┤ng tß╗ôn tß║íi trong hß╗ç thß╗æng!';
        END IF;

        IF v_TrangThai = FALSE THEN
            RAISE EXCEPTION 'M├ú voucher n├áy hiß╗çn ─æang bß╗ï tß║ím kh├│a hoß║╖c ─æ├ú hß║┐t hiß╗çu lß╗▒c!';
        END IF;

        IF v_HetHan < CURRENT_DATE THEN
            RAISE EXCEPTION 'M├ú voucher ─æ├ú hß║┐t hß║ín sß╗¡ dß╗Ñng v├áo ng├áy %!', v_HetHan;
        END IF;

        IF v_SoLuong IS NOT NULL AND v_SoLuong <= 0 THEN
            RAISE EXCEPTION 'M├ú voucher n├áy ─æ├ú hß║┐t l╞░ß╗út sß╗¡ dß╗Ñng!';
        END IF;

        -- Trß╗½ sß╗æ l╞░ß╗úng
        IF v_SoLuong IS NOT NULL THEN
            UPDATE Voucher
            SET SoLuong = SoLuong - 1,
                TrangThai = CASE WHEN (SoLuong - 1) <= 0 THEN FALSE ELSE TRUE END
            WHERE MaVoucher = NEW.MaVoucher;
        END IF;

        INSERT INTO NhatKyHeThong (LoaiHanhDong, BangTacDong, KhoaChinh, GiaTriCu, GiaTriMoi, MoTaChiTiet)
        VALUES ('AP_VOUCHER', 'HoaDon', NEW.MaHoaDon, NULL, NEW.MaVoucher::TEXT, 
                '─É├ú ├íp dß╗Ñng voucher cho h├│a ─æ╞ín ' || NEW.MaHoaDon || '. Sß╗æ l╞░ß╗úng c├▓n lß║íi: ' || COALESCE((v_SoLuong - 1)::TEXT, 'V├┤ hß║ín'));
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
-- TRIGGER 3: Tß╗▒ ─æß╗Öng t├¡nh Th├ánh tiß╗ün chi tiß║┐t h├│a ─æ╞ín & cß║¡p nhß║¡t tß╗òng tiß╗ün
-- Nghiß╗çp vß╗Ñ: ─Éß║úm bß║úo t├¡nh nhß║Ñt qu├ín (Consistency), kh├┤ng bß╗ï sai lß╗çch sß╗æ liß╗çu
-- ----------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION fn_trg_CapNhatTienDichVuHoaDon()
RETURNS TRIGGER AS $$
DECLARE
    v_MaHD VARCHAR(20);
    v_TongTienDV NUMERIC(18,2);
BEGIN
    v_MaHD := COALESCE(NEW.MaHoaDon, OLD.MaHoaDon);

    -- Tß╗▒ ─æß╗Öng ─æiß╗ün ─æ╞ín gi├í v├á th├ánh tiß╗ün nß║┐u INSERT ch╞░a c├│
    IF (TG_OP = 'INSERT' OR TG_OP = 'UPDATE') THEN
        IF NEW.DonGia IS NULL OR NEW.DonGia <= 0 THEN
            SELECT DonGia INTO NEW.DonGia FROM DichVu WHERE MaDichVu = NEW.MaDichVu;
        END IF;
        NEW.ThanhTien := COALESCE(NEW.SoLuong, 1) * COALESCE(NEW.DonGia, 0);
    END IF;

    -- T├¡nh lß║íi tß╗òng tiß╗ün dß╗ïch vß╗Ñ cß╗ºa h├│a ─æ╞ín
    SELECT COALESCE(SUM(ThanhTien), 0) INTO v_TongTienDV
    FROM ChiTietHoaDon
    WHERE MaHoaDon = v_MaHD;

    -- Cß║¡p nhß║¡t ng╞░ß╗úc lß║íi bß║úng HoaDon
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
-- TRIGGER 4: Ng─ân chß║╖n ─æß║╖t ph├▓ng tr├╣ng lß╗ïch (Anti Double-Booking Trigger)
-- ----------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION fn_trg_KiemTraTrungLichDatPhong()
RETURNS TRIGGER AS $$
BEGIN
    -- Kiß╗âm tra xem c├│ ph├▓ng n├áo tr├╣ng khoß║úng thß╗¥i gian (Overlap) ß╗ƒ trß║íng th├íi '─É├ú ─æß║╖t' hoß║╖c '─Éang ß╗ƒ'
    IF EXISTS (
        SELECT 1 FROM DatPhong
        WHERE MaPhong = NEW.MaPhong
          AND TrangThai IN ('─É├ú ─æß║╖t', '─Éang ß╗ƒ')
          AND MaDatPhong <> COALESCE(NEW.MaDatPhong, 0)
          AND (NEW.NgayNhan < NgayTra AND NEW.NgayTra > NgayNhan)
    ) THEN
        RAISE EXCEPTION 'Xung ─æß╗Öt lß╗ïch: Ph├▓ng % ─æ├ú c├│ ─æ╞ín ─æß║╖t trong khoß║úng tß╗½ % ─æß║┐n %!', 
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
-- PHß║ªN 3: H├ÇM & THß╗ª Tß╗ñC NGHIß╗åP Vß╗ñ N├éNG CAO (STORED PROCEDURES & FUNCTIONS)
-- ============================================================================

-- ----------------------------------------------------------------------------
-- FUNCTION 1: T├¼m kiß║┐m ph├▓ng khß║ú dß╗Ñng theo khoß║úng ng├áy & ti├¬u ch├¡ lß╗ìc
-- Trß║ú vß╗ü Table chß╗⌐a danh s├ích ph├▓ng trß╗æng k├¿m gi├í v├á tiß╗çn nghi
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
    -- Kiß╗âm tra logic ng├áy hß╗úp lß╗ç
    IF p_NgayNhan >= p_NgayTra THEN
        RAISE EXCEPTION 'Ng├áy nhß║¡n ph├▓ng (%) phß║úi tr╞░ß╗¢c ng├áy trß║ú ph├▓ng (%)!', p_NgayNhan, p_NgayTra;
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
    WHERE p.TinhTrang IN ('Hoß║ít ─æß╗Öng', 'Trß╗æng', '─É├ú dß╗ìn dß║╣p')
      AND (p_MaLoai IS NULL OR p.MaLoai = p_MaLoai)
      AND (lp.SoNguoiToiDa >= p_SoNguoi)
      AND NOT EXISTS (
          SELECT 1 
          FROM DatPhong dp
          WHERE dp.MaPhong = p.MaPhong
            AND dp.TrangThai IN ('─É├ú ─æß║╖t', '─Éang ß╗ƒ')
            AND (p_NgayNhan < dp.NgayTra AND p_NgayTra > dp.NgayNhan)
      )
    ORDER BY p.Tang, p.SoPhong;
END;
$$ LANGUAGE plpgsql;


-- ----------------------------------------------------------------------------
-- FUNCTION 2: T├¡nh to├ín chi tiß║┐t chi ph├¡ ─æß║╖t ph├▓ng (╞»ß╗¢c t├¡nh gi├í & Tiß╗ün cß╗ìc)
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

    -- Phß╗Ñ thu nß║┐u tr├¬n 2 ng╞░ß╗¥i lß╗¢n (150.000 ─æ/ng╞░ß╗¥i/─æ├¬m)
    IF p_SoNguoiLon > 2 THEN
        v_PhuThu := v_PhuThu + ((p_SoNguoiLon - 2) * 150000 * v_SoDem);
    END IF;

    -- Phß╗Ñ thu trß║╗ em (80.000 ─æ/b├⌐/─æ├¬m)
    IF p_SoTreEm > 0 THEN
        v_PhuThu := v_PhuThu + (p_SoTreEm * 80000 * v_SoDem);
    END IF;

    -- Thuß║┐ v├á ph├¡
    v_Thue := (v_TienGoc + v_PhuThu) * p_PhanTramVAT;
    v_Tong := v_TienGoc + v_PhuThu + v_Thue;

    RETURN QUERY
    SELECT 
        v_SoDem,
        v_TienGoc,
        v_PhuThu,
        v_Thue,
        v_Tong,
        ROUND(v_Tong * 0.30, -3); -- Tiß╗ün cß╗ìc 30% l├ám tr├▓n ngh├¼n
END;
$$ LANGUAGE plpgsql;


-- ----------------------------------------------------------------------------
-- PROCEDURE 1: Quy tr├¼nh Check-in nhß║¡n ph├▓ng an to├án (Transaction ACID)
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
    -- Kiß╗âm tra sß╗▒ tß╗ôn tß║íi v├á kh├│a d├▓ng dß╗» liß╗çu
    SELECT dp.TrangThai, dp.NgayNhan, dp.MaPhong, p.SoPhong
    INTO v_TrangThai, v_NgayNhan, v_MaPhong, v_SoPhong
    FROM DatPhong dp
    JOIN Phong p ON dp.MaPhong = p.MaPhong
    WHERE dp.MaDatPhong = p_MaDatPhong
    FOR UPDATE;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Kh├┤ng t├¼m thß║Ñy ─æ╞ín ─æß║╖t ph├▓ng c├│ m├ú: %', p_MaDatPhong;
    END IF;

    IF v_TrangThai <> '─É├ú ─æß║╖t' THEN
        RAISE EXCEPTION '─É╞ín ph├▓ng ─æang ß╗ƒ trß║íng th├íi "%", kh├┤ng thß╗â thß╗▒c hiß╗çn nhß║¡n ph├▓ng!', v_TrangThai;
    END IF;

    IF v_NgayNhan > CURRENT_DATE THEN
        RAISE EXCEPTION 'Ch╞░a ─æß║┐n ng├áy nhß║¡n ph├▓ng (Ng├áy nhß║¡n: %). Chß╗ë nhß║¡n ph├▓ng tß╗½ ng├áy nhß║¡n trß╗ƒ ─æi!', v_NgayNhan;
    END IF;

    -- Kiß╗âm tra ph├▓ng c├│ ─æang bß╗ï kh├ích kh├íc ß╗ƒ kh├┤ng
    IF EXISTS (SELECT 1 FROM DatPhong WHERE MaPhong = v_MaPhong AND TrangThai = '─Éang ß╗ƒ' AND MaDatPhong <> p_MaDatPhong) THEN
        RAISE EXCEPTION 'Ph├▓ng % hiß╗çn ─æang c├│ kh├ích l╞░u tr├║ ch╞░a trß║ú ph├▓ng!', v_SoPhong;
    END IF;

    -- Cß║¡p nhß║¡t trß║íng th├íi nhß║¡n ph├▓ng
    UPDATE DatPhong
    SET TrangThai = '─Éang ß╗ƒ',
        GioNhanThucTe = CURRENT_TIMESTAMP,
        MaNhanVien = COALESCE(p_MaNhanVien, MaNhanVien)
    WHERE MaDatPhong = p_MaDatPhong;

    -- ─Éß╗ông bß╗Ö trß║íng th├íi buß╗ông ph├▓ng
    UPDATE Phong
    SET TinhTrang = '─Éang sß╗¡ dß╗Ñng'
    WHERE MaPhong = v_MaPhong;

    RAISE NOTICE '─É├ú thß╗▒c hiß╗çn Check-in th├ánh c├┤ng cho ─æ╞ín ─æß║╖t ph├▓ng % (Ph├▓ng %)', p_MaDatPhong, v_SoPhong;
END;
$$;


-- ----------------------------------------------------------------------------
-- PROCEDURE 2: Quy tr├¼nh Check-out, t├¡nh to├ín h├│a ─æ╞ín v├á ─æ├│ng buß╗ông ph├▓ng
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
    -- 1. Lß║Ñy th├┤ng tin ─æ╞ín ─æß║╖t ph├▓ng
    SELECT dp.MaDat, dp.MaPhong, p.SoPhong, COALESCE(dp.TongTien, 0), COALESCE(dp.TienCoc, 0)
    INTO v_MaDat, v_MaPhong, v_SoPhong, v_TienPhong, v_TienCoc
    FROM DatPhong dp
    JOIN Phong p ON dp.MaPhong = p.MaPhong
    WHERE dp.MaDatPhong = p_MaDatPhong AND dp.TrangThai = '─Éang ß╗ƒ'
    FOR UPDATE;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Kh├┤ng t├¼m thß║Ñy ─æ╞ín ─æß║╖t ph├▓ng ─æang ß╗ƒ c├│ m├ú: %!', p_MaDatPhong;
    END IF;

    -- 2. Sinh m├ú h├│a ─æ╞ín nß║┐u ch╞░a truyß╗ün v├áo (HD-YYYYMMDD-XXXX)
    IF p_MaHoaDon IS NULL OR p_MaHoaDon = '' THEN
        p_MaHoaDon := 'HD' || TO_CHAR(CURRENT_TIMESTAMP, 'YYYYMMDD') || LPAD(p_MaDatPhong::TEXT, 4, '0');
    END IF;

    -- 3. T├¡nh tiß╗ün dß╗ïch vß╗Ñ ph├ít sinh (nß║┐u c├│ chi tiß║┐t tß║ím g├ín)
    SELECT COALESCE(SUM(ThanhTien), 0) INTO v_TienDV
    FROM ChiTietHoaDon
    WHERE MaHoaDon = p_MaHoaDon;

    -- 4. T├¡nh giß║úm gi├í voucher (nß║┐u c├│)
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

    -- 5. Tß╗òng tiß╗ün thß╗▒c tß║┐ cß║ºn thanh to├ín
    v_TongCanThu := GREATEST(0, (v_TienPhong + v_TienDV - v_TienCoc - v_TienGiam));

    -- 6. Ghi nhß║¡n h├│a ─æ╞ín thanh to├ín
    INSERT INTO HoaDon (
        MaHoaDon, MaDatPhong, NgayLap, NgayThanhToan,
        TienPhong, TienDichVu, TienGiamGia, TienDatCoc, TongTien,
        MaPTTT, MaVoucher, TrangThai
    )
    VALUES (
        p_MaHoaDon, v_MaDat, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP,
        v_TienPhong, v_TienDV, v_TienGiam, v_TienCoc, v_TongCanThu,
        COALESCE(p_MaPTTT, 'TM'), p_MaVoucher, '─É├ú thanh to├ín'
    )
    ON CONFLICT (MaHoaDon) DO UPDATE 
    SET NgayThanhToan = CURRENT_TIMESTAMP,
        TongTien = EXCLUDED.TongTien,
        TrangThai = '─É├ú thanh to├ín';

    -- 7. Cß║¡p nhß║¡t ─æ╞ín ─æß║╖t ph├▓ng sang '─É├ú trß║ú'
    UPDATE DatPhong
    SET TrangThai = '─É├ú trß║ú',
        GioTraThucTe = CURRENT_TIMESTAMP
    WHERE MaDatPhong = p_MaDatPhong;

    -- 8. Cß║¡p nhß║¡t ph├▓ng sang 'Chß╗¥ dß╗ìn dß║╣p'
    UPDATE Phong
    SET TinhTrang = 'Chß╗¥ dß╗ìn dß║╣p'
    WHERE MaPhong = v_MaPhong;

    RAISE NOTICE '─É├ú Check-out v├á xuß║Ñt h├│a ─æ╞ín % th├ánh c├┤ng cho ph├▓ng %. Tß╗òng thu: % VN─É', 
        p_MaHoaDon, v_SoPhong, v_TongCanThu;
END;
$$;


-- ============================================================================
-- PHß║ªN 4: KHAI TH├üC & THß╗ÉNG K├è Dß╗« LIß╗åU ─ÉA CHIß╗ÇU (ANALYTIC VIEWS)
-- ============================================================================

-- ----------------------------------------------------------------------------
-- VIEW 1: Doanh thu kinh doanh theo th├íng & c╞í cß║Ñu thu chi
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
WHERE hd.TrangThai = '─É├ú thanh to├ín'
GROUP BY TO_CHAR(COALESCE(hd.NgayThanhToan, hd.NgayLap), 'YYYY-MM')
ORDER BY ThangNam DESC;


-- ----------------------------------------------------------------------------
-- VIEW 2: Tß╗╖ lß╗ç lß║Ñp ─æß║ºy ph├▓ng (Occupancy Rate) theo tß╗½ng Loß║íi ph├▓ng
-- ----------------------------------------------------------------------------
CREATE OR REPLACE VIEW vw_KhaiThacCongSuatLoaiPhong AS
SELECT 
    lp.MaLoai,
    lp.TenLoai,
    lp.GiaMotDem,
    COUNT(DISTINCT p.MaPhong)                                AS TongSoPhong,
    COUNT(DISTINCT CASE WHEN p.TinhTrang = '─Éang sß╗¡ dß╗Ñng' THEN p.MaPhong END) AS SoPhongDangCoKhach,
    COUNT(DISTINCT CASE WHEN p.TinhTrang = 'Chß╗¥ dß╗ìn dß║╣p' THEN p.MaPhong END)  AS SoPhongChoDon,
    COUNT(DISTINCT CASE WHEN p.TinhTrang IN ('Hoß║ít ─æß╗Öng', 'Trß╗æng') THEN p.MaPhong END) AS SoPhongSanSangDonKhach,
    ROUND(
        COUNT(DISTINCT CASE WHEN p.TinhTrang = '─Éang sß╗¡ dß╗Ñng' THEN p.MaPhong END)::NUMERIC / 
        NULLIF(COUNT(DISTINCT p.MaPhong), 0) * 100, 
        2
    ) AS TyLeLapDayPhanTram
FROM LoaiPhong lp
LEFT JOIN Phong p ON lp.MaLoai = p.MaLoai
GROUP BY lp.MaLoai, lp.TenLoai, lp.GiaMotDem
ORDER BY lp.MaLoai;


-- ----------------------------------------------------------------------------
-- VIEW 3: Xß║┐p hß║íng Dß╗ïch vß╗Ñ phß╗Ñ trß╗ú ─æ╞░ß╗úc kh├ích h├áng ╞░a chuß╗Öng nhß║Ñt
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
-- VIEW 4: Ph├ón kh├║c kh├ích h├áng VIP & Th├ón thiß║┐t (RFM Analytics)
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
        WHEN COALESCE(SUM(hd.TongTien), 0) >= 15000000 THEN '≡ƒÆÄ VIP Kim C╞░╞íng'
        WHEN COALESCE(SUM(hd.TongTien), 0) >= 7000000  THEN '≡ƒÑç VIP V├áng'
        WHEN COUNT(dp.MaDatPhong) >= 3                 THEN '≡ƒÑê Th├ón thiß║┐t'
        ELSE 'Kh├ích mß╗¢i'
    END AS HangThanhVien
FROM KhachHang kh
LEFT JOIN DatPhong dp ON kh.MaKH = dp.MaKH
LEFT JOIN HoaDon hd ON (hd.MaDatPhong = dp.MaDat OR CAST(dp.MaDatPhong AS TEXT) = hd.MaDatPhong) AND hd.TrangThai = '─É├ú thanh to├ín'
GROUP BY kh.MaKH, kh.MaKHHienThi, kh.HoTen, kh.SoDienThoai, kh.QuocTich
ORDER BY TongChiTieu DESC;


-- ----------------------------------------------------------------------------
-- VIEW 5: Bß║úng tß╗òng quan Dashboard cho Gi├ím ─æß╗æc / Lß╗à t├ón ca trß╗▒c
-- ----------------------------------------------------------------------------
CREATE OR REPLACE VIEW vw_KhaiThacDashboardTongHop AS
SELECT 
    (SELECT COUNT(*) FROM Phong)                                                AS TongSoPhong,
    (SELECT COUNT(*) FROM Phong WHERE TinhTrang = '─Éang sß╗¡ dß╗Ñng')               AS PhongDangO,
    (SELECT COUNT(*) FROM Phong WHERE TinhTrang = 'Chß╗¥ dß╗ìn dß║╣p')                AS PhongChoDon,
    (SELECT COUNT(*) FROM DatPhong WHERE TrangThai = '─É├ú ─æß║╖t' AND NgayNhan = CURRENT_DATE) AS CheckInHomNay,
    (SELECT COUNT(*) FROM DatPhong WHERE TrangThai = '─Éang ß╗ƒ' AND NgayTra = CURRENT_DATE)  AS CheckOutHomNay,
    (SELECT COALESCE(SUM(TongTien), 0) FROM HoaDon WHERE CAST(NgayThanhToan AS DATE) = CURRENT_DATE) AS DoanhThuHomNay,
    (SELECT COALESCE(SUM(TongTien), 0) FROM HoaDon WHERE DATE_TRUNC('month', NgayThanhToan) = DATE_TRUNC('month', CURRENT_DATE)) AS DoanhThuThangNay;


-- ============================================================================
-- PHß║ªN 5: Tß╗ÉI ╞»U H├ôA TRUY Vß║ñN Vß╗ÜI CHß╗ê Mß╗ñC (INDEXING & PERFORMANCE TUNING)
-- ============================================================================

-- ─É├ính chß╗ë mß╗Ñc B-Tree tr├¬n c├íc tr╞░ß╗¥ng kh├│a ngoß║íi, t├¼m kiß║┐m v├á lß╗ìc thß╗¥i gian
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
-- PHß║ªN 6: Bß║óO Mß║¼T PH├éN QUYß╗ÇN (ROLE-BASED ACCESS CONTROL - RBAC)
-- ============================================================================

DO $$
BEGIN
    -- Tß║ío Role Quß║ún Trß╗ï Vi├¬n (Admin)
    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'role_quan_tri_ks') THEN
        CREATE ROLE role_quan_tri_ks WITH LOGIN PASSWORD 'Admin@Hotel2026';
    END IF;

    -- Tß║ío Role Nh├ón Vi├¬n Lß╗à T├ón
    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'role_le_tan_ks') THEN
        CREATE ROLE role_le_tan_ks WITH LOGIN PASSWORD 'LeTan@Hotel2026';
    END IF;
END $$;

-- Ph├ón quyß╗ün cho Quß║ún Trß╗ï Vi├¬n: To├án quyß╗ün tr├¬n Schema public
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO role_quan_tri_ks;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO role_quan_tri_ks;
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public TO role_quan_tri_ks;

-- Ph├ón quyß╗ün cho Lß╗à T├ón: Chß╗ë quyß╗ün nghiß╗çp vß╗Ñ, kh├┤ng quyß╗ün ph├í hß╗ºy cß║Ñu tr├║c
GRANT SELECT, INSERT, UPDATE ON DatPhong, KhachHang, HoaDon, ChiTietHoaDon, Phong, LichSuLuuTru TO role_le_tan_ks;
GRANT SELECT ON LoaiPhong, DichVu, Voucher, PhuongThucThanhToan, vw_KhaiThacDoanhThuTheoThang, vw_KhaiThacCongSuatLoaiPhong, vw_KhaiThacTopDichVu, vw_KhaiThacKhachHangVIP, vw_KhaiThacDashboardTongHop TO role_le_tan_ks;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO role_le_tan_ks;
GRANT EXECUTE ON FUNCTION fn_TimPhongTrong, fn_TinhToanChiPhiDatPhong TO role_le_tan_ks;
GRANT EXECUTE ON PROCEDURE sp_ThucHienCheckIn, sp_ThucHienCheckOut TO role_le_tan_ks;

-- Ng─ân chß║╖n Lß╗à t├ón xem cß╗Öt mß║¡t khß║⌐u trong bß║úng TaiKhoan
REVOKE ALL ON TaiKhoan FROM role_le_tan_ks;

-- ============================================================================
-- TH├öNG B├üO HO├ÇN TH├ÇNH Kß╗èCH Bß║óN CHUY├èN ─Éß╗Ç 1
-- ============================================================================
DO $$
BEGIN
    RAISE NOTICE '=============================================================';
    RAISE NOTICE '≡ƒÄë Kß╗èCH Bß║óN N├éNG CAO CHUY├èN ─Éß╗Ç 1: KHAI TH├üC CSDL ─É├â ─É╞»ß╗óC THIß║╛T Lß║¼P TH├ÇNH C├öNG!';
    RAISE NOTICE 'ΓÇó 4 Triggers to├án vß║╣n (─Éß╗ông bß╗Ö ph├▓ng, Trß╗½ voucher, Tß╗▒ t├¡nh tiß╗ün, Chß╗æng double booking)';
    RAISE NOTICE 'ΓÇó 2 Functions & 2 Stored Procedures nghiß╗çp vß╗Ñ (T├¼m ph├▓ng, T├¡nh gi├í, Check-in, Check-out)';
    RAISE NOTICE 'ΓÇó 5 Views ph├ón t├¡ch khai th├íc sß╗æ liß╗çu (Doanh thu, C├┤ng suß║Ñt, Top dß╗ïch vß╗Ñ, Kh├ích VIP, Dashboard)';
    RAISE NOTICE 'ΓÇó 6 Indexes tß╗æi ╞░u h├│a truy vß║Ñn hiß╗çu n─âng cao';
    RAISE NOTICE 'ΓÇó Ph├ón quyß╗ün RBAC bß║úo mß║¡t hß╗ç thß╗æng (Admin vs Lß╗à T├ón)';
    RAISE NOTICE '=============================================================';
END $$;
