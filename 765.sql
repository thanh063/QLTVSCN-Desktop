CREATE DATABASE QuanLySach68;
GO
USE QuanLySach68;

CREATE TABLE SACH (
    MaSach INT IDENTITY(1,1) PRIMARY KEY, -- Mã sách (khóa chính, tự tăng)
    TenSach NVARCHAR(255) NOT NULL,      -- Tên sách
    TacGia NVARCHAR(255),                -- Tác giả
    TheLoai NVARCHAR(100),               -- Thể loại
    NamXuatBan INT,                      -- Năm xuất bản
    TrangThai NVARCHAR(50),              -- Trạng thái (vd: "Còn", "Hết")
    ViTri NVARCHAR(50)                   -- Vị trí (vd: "Tủ A1")
);
CREATE TABLE NGUOIMUON (
    MaNguoiMuon INT IDENTITY(1,1) PRIMARY KEY, -- Mã người mượn (khóa chính, tự tăng)
    TenNguoiMuon NVARCHAR(255) NOT NULL,      -- Tên người mượn
    SDT NVARCHAR(15),                         -- Số điện thoại
    DiaChi NVARCHAR(255),                     -- Địa chỉ
    TenSach NVARCHAR(255),                    -- Tên sách mượn
    NgayMuon DATE,                            -- Ngày mượn
    NgayTra DATE                              -- Ngày trả
);
CREATE TABLE MUONTRA (
    MaMuonTra INT IDENTITY(1,1) PRIMARY KEY,  -- Mã mượn trả (khóa chính, tự tăng)
    MaSach INT NOT NULL,                      -- Mã sách (khóa ngoại)
    MaNguoiMuon INT NOT NULL,                 -- Mã người mượn (khóa ngoại)
    NgayMuon DATE NOT NULL,                   -- Ngày mượn
    NgayTra DATE NOT NULL,                    -- Ngày trả
    TrangThai BIT NOT NULL DEFAULT 0,         -- Trạng thái (0: Chưa trả, 1: Đã trả)
    FOREIGN KEY (MaSach) REFERENCES SACH(MaSach),
    FOREIGN KEY (MaNguoiMuon) REFERENCES NGUOIMUON(MaNguoiMuon)
);
INSERT INTO SACH (TenSach, TacGia, TheLoai, NamXuatBan, TrangThai, ViTri)
VALUES 
('Lập trình C#', 'Nguyễn Văn A', 'Công nghệ thông tin', 2020, 'Còn', 'Tủ A1'),
('Học SQL Server', 'Trần Thị B', 'Công nghệ thông tin', 2019, 'Còn', 'Tủ A2'),
('Kỹ năng sống', 'Lê Văn C', 'Kỹ năng', 2021, 'Hết', 'Tủ B1');
INSERT INTO NGUOIMUON (TenNguoiMuon, SDT, DiaChi, TenSach, NgayMuon, NgayTra)
VALUES
('Nguyễn Văn D', '0123456789', 'Hà Nội', 'Lập trình C#', '2023-11-01', '2023-12-01'),
('Trần Thị E', '0987654321', 'TP. HCM', 'Học SQL Server', '2023-11-05', '2023-12-05');
INSERT INTO MUONTRA (MaSach, MaNguoiMuon, NgayMuon, NgayTra, TrangThai)
VALUES
(1, 1, '2023-11-01', '2023-12-01', 0),
(2, 2, '2023-11-05', '2023-12-05', 0);
SELECT SUM(SoLuong) AS TongSoSach
FROM SACH;
SELECT COUNT(*) AS TongSoSach
FROM SACH
WHERE TrangThai = 'Còn';
SELECT ViTri AS TuSach, COUNT(*) AS SoLuong
FROM SACH
GROUP BY ViTri;
SELECT SACH.TenSach, COUNT(MUONTRA.MaSach) AS SoLuongDangMuon
FROM MUONTRA
INNER JOIN SACH ON MUONTRA.MaSach = SACH.MaSach
WHERE MUONTRA.TrangThai = 0
GROUP BY SACH.TenSach;
