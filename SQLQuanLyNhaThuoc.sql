CREATE DATABASE QUANLYNHATHUOC
USE QUANLYNHATHUOC

---Bảng Thuoc
GO
CREATE TABLE Thuoc(
	MaThuoc varchar(20) NOT NULL,
	TenThuoc nvarchar(200) NOT NULL,
	ChongChiDinh nvarchar(200),
	ChiDinh nvarchar(200),
	HanSuDung date NOT NULL,
	Gia money NOT NULL
	CONSTRAINT PK_Thuoc PRIMARY KEY (MaThuoc)
)
---Bảng ThanhPhan_Thuoc
GO
CREATE TABLE ThanhPhan_Thuoc(
	ThanhPhan nvarchar(100) NOT NULL,
	MaThuoc varchar(20) NOT NULL,
	CONSTRAINT FK_ThanhPhanThuoc FOREIGN KEY (MaThuoc) REFERENCES Thuoc(MaThuoc) ON DELETE CASCADE,
	CONSTRAINT PK_ThanhPhanThuoc PRIMARY KEY(MaThuoc, ThanhPhan)
)
---Bảng DanhMuc
GO
CREATE TABLE DanhMuc(
	MaDanhMuc varchar(20) NOT NULL,
	TenDanhMuc nvarchar(100) NOT NULL,
	CONSTRAINT PK_DanhMuc PRIMARY KEY(MaDanhMuc)
)
---Bảng DanhMuc_Thuoc
GO
CREATE TABLE DanhMuc_Thuoc(
	MaThuoc varchar(20) NOT NULL,
	MaDanhMuc varchar(20) NOT NULL,
	CONSTRAINT FK_DanhMuc_Thuoc_MaDanhMuc FOREIGN KEY (MaDanhMuc) REFERENCES DanhMuc(MaDanhMuc) ON DELETE CASCADE,
	CONSTRAINT FK_DanhMuc_Thuoc_MaThuoc FOREIGN KEY(MaThuoc) REFERENCES Thuoc(MaThuoc) ON DELETE CASCADE,
	CONSTRAINT PK_DanhMuc_Thuoc PRIMARY KEY(MaThuoc, MaDanhMuc)
)
---Bảng KhoThuoc
GO
CREATE TABLE KhoThuoc(
	MaKho varchar(20) NOT NULL,
	TenKho nvarchar(100) NOT NULL,
	DiaChiKho nvarchar(200) NOT NULL,
	CONSTRAINT PK_KhoThuoc PRIMARY KEY(MaKho)
)
---Bảng Thuoc_KhoThuoc
GO
CREATE TABLE Thuoc_KhoThuoc(
	MaThuoc varchar(20) NOT NULL,
	MaKho varchar(20) NOT NULL,
	SoLuong int NOT NULL,
	CONSTRAINT FK_Thuoc_KhoThuoc_MaThuoc FOREIGN KEY (MaThuoc) REFERENCES Thuoc(MaThuoc) ON DELETE CASCADE,
	CONSTRAINT FK_Thuoc_KhoThuoc_MaKho FOREIGN KEY (MaKho) REFERENCES KhoThuoc(MaKho) ON DELETE CASCADE,
	CONSTRAINT PK_Thuoc_KhoThuoc PRIMARY KEY(MaThuoc, MaKho)
)
---Bảng KhachHang
GO
CREATE TABLE KhachHang(
	MaKH varchar(20) NOT NULL,
	TenKH nvarchar(100) NOT NULL,
	GioiTinhKH nvarchar(20) NOT NULL,
	DiaChiKH nvarchar(200) NOT NULL,
	CONSTRAINT PK_KhachHang PRIMARY KEY(MaKH)
)
---Bảng KhachHangSDT
GO
CREATE TABLE KhachHangSDT(
	MaKH varchar(20) NOT NULL,
	SDT varchar(20) NOT NULL,
	CONSTRAINT FK_KhachHang_SDT_MaKH FOREIGN KEY (MaKH) REFERENCES KhachHang(MaKH) ON DELETE CASCADE,
	CONSTRAINT KhachHang_SDT PRIMARY KEY(MaKH, SDT)
)
---Bảng NhanVien
GO
CREATE TABLE NhanVien(
	MaNV varchar(20) NOT NULL,
	TenNV nvarchar(100) NOT NULL,
	GioiTinhNV nvarchar(20) NOT NULL,
	DiaChiNV nvarchar(200) NOT NULL,
	VaiTro nvarchar(100) NOT NULL,
	CONSTRAINT PK_NhanVien PRIMARY KEY(MaNV)
)
---Bảng NhanVien_SDT
GO
CREATE TABLE NhanVien_SDT(
	MaNV varchar(20) NOT NULL,
	SDT varchar(20) NOT NULL,
	CONSTRAINT FK_NhanVien_SDT_MaNV FOREIGN KEY(MaNV) REFERENCES NhanVien(MaNV) ON DELETE CASCADE,
	CONSTRAINT PK_NhanVien_SDT PRIMARY KEY(MaNV, SDT)
)
---Bảng ThuNgan
GO
CREATE TABLE ThuNgan(
	MaTN varchar(20) NOT NULL,
	NghiepVu nvarchar(50),
	CONSTRAINT FL_ThuNgan_MaTN FOREIGN KEY (MaTN) REFERENCES NhanVien(MaNV) ON DELETE CASCADE,
	CONSTRAINT PK_ThuNgan PRIMARY KEY(MaTN)
)
---Bảng QuanLyKho
GO
CREATE TABLE QuanLyKho(
	MaQLK varchar(20) NOT NULL,
	MaKho varchar(20) NOT NULL,
	CONSTRAINT FK_QuanLyKho_MaKho FOREIGN KEY (MaKho) REFERENCES KhoThuoc(MaKho),
	CONSTRAINT FK_QuanLyKho_MaQLK FOREIGN KEY (MaQLK) REFERENCES NhanVien(MaNV) ON DELETE CASCADE,
	CONSTRAINT PK_QuanLyKho PRIMARY KEY(MaQLK, MaKho)
)
---Bảng HDB
GO
CREATE TABLE HDB(
	MaHDB varchar(20) NOT NULL,
	MaTN varchar(20) NOT NULL,
	MaKH  varchar(20) NOT NULL,
	NgayBan DATE  DEFAULT CONVERT (DATE, SYSDATETIME()) NOT NULL,
	CONSTRAINT FK_HDB_MaTN FOREIGN KEY(MaTN) REFERENCES ThuNgan(MaTN),
	CONSTRAINT FK_HDB_MaKH FOREIGN KEY(MaKH) REFERENCES KhachHang(MaKH),
	CONSTRAINT PK_HDB PRIMARY KEY(MaHDB)
)
---CT_HDB
GO
CREATE TABLE CT_HDB(
	MaThuoc varchar(20) NOT NULL,
	MaHDB varchar(20) NOT NULL,
	SoLuongXuat int NOT NULL,
	CONSTRAINT FK_CT_HDB_MaThuoc FOREIGN KEY(MaThuoc) REFERENCES Thuoc(MaThuoc),
	CONSTRAINT FK_CT_HDB_MaHDB FOREIGN KEY(MaHDB) REFERENCES HDB(MaHDB) ON DELETE CASCADE,
	CONSTRAINT PK_CT_HDB PRIMARY KEY(MaThuoc, MaHDB)
)

---Bảng NCC
GO
CREATE TABLE NCC(
	MaNCC varchar(20) NOT NULL,
	TenNCC nvarchar(50) NOT NULL,
	DiaChiNCC nvarchar(200) NOT NULL
	CONSTRAINT PK_NCC PRIMARY KEY(MaNCC)
)
---Bảng NCC_SDT
GO
CREATE TABLE NCC_SDT(
	MaNCC varchar(20) NOT NULL,
	SDT varchar(20) NOT NULL,
	CONSTRAINT FP_NCC_SDT_MaNCC FOREIGN KEY(MaNCC) REFERENCES NCC(MaNCC) ON DELETE CASCADE,
	CONSTRAINT PK_NCC_SDT PRIMARY KEY(MaNCC, SDT)
)
---Bảng ChiNhanh
GO
CREATE TABLE ChiNhanh(
	TenCN nvarchar(100) NOT NULL,
	MaNCC varchar(20) NOT NULL,
	DiaChiCN nvarchar(200) NOT NULL,
	CONSTRAINT FP_ChiNhanhNCC FOREIGN KEY(MaNCC) REFERENCES NCC(MaNCC) ON DELETE CASCADE,
	CONSTRAINT PK_ChiNhanh PRIMARY KEY(TenCN, MaNCC)
)
---Bảng HDN
GO
CREATE TABLE HDN(
	MaHDN varchar(20) NOT NULL,
	MaTN varchar(20) NOT NULL,
	TenCN nvarchar(100) NOT NULL,
	MaNCC varchar(20) NOT NULL,
	NgayNhap date DEFAULT CONVERT (DATE, SYSDATETIME()) NOT NULL,
	CONSTRAINT FK_HDN_MaTN FOREIGN KEY(MaTN) REFERENCES ThuNgan(MaTN),
	CONSTRAINT FK_HDN_TenCN_MaNCC FOREIGN KEY(TenCN,MaNCC) REFERENCES ChiNhanh(TenCN, MaNCC),
	CONSTRAINT PK_HDN PRIMARY KEY(MaHDN) 
)
---Bảng CT_HDN
GO
CREATE TABLE CT_HDN(
	MaThuoc varchar(20) NOT NULL,
	MaHDN varchar(20) NOT NULL,
	SoLuongNhap int NOT NULL,
	CONSTRAINT FK_CT_HDN_MaThuoc FOREIGN KEY(MaThuoc) REFERENCES Thuoc(MaThuoc),
	CONSTRAINT FK_CT_HDN_MaHDN FOREIGN KEY(MaHDN) REFERENCES HDN(MaHDN) ON DELETE CASCADE,
	CONSTRAINT PK_CT_HDN PRIMARY KEY(MaThuoc, MaHDN)
)
--------------------------------------
----------------INSERT -------------------
GO
INSERT INTO Thuoc(MaThuoc,TenThuoc,ChiDinh,ChongChiDinh, HanSuDung, Gia)
VALUES
('0000','Cetirizin','',N'Phụ nữ đang cho con bú','2022/12/12',53),
('0001','Cinnarizin',N'Người bị say tàu xe',N'Bệnh nhân cao tuổi','2024/05/14',46),
('0002','Clorpheniramin maleat',N'Dị ứng thức ăn',N'Bệnh nhân cao tuổi','2025/01/01',31),--chong di ung
('0003','Natri hydrocarbonat',N'Rối loạn tiêu hóa',N'Phụ nữ đang cho con bú','2025/12/12',95000),
('0004','Nor epinephrin','',N'Trẻ em dưới 10 tuổi','2024/12/1',29190),--giaidoc
('0005','Acetylsalicylic acid','',N'Bệnh nhân cao tuổi','2023/12/01',87),
('0006','Meloxicam','',N'Trẻ em dưới 10 tuổi','2022/12/05',4370),
('0007','Paracetamol','',N'Trẻ em dưới 10 tuổi','2025/01/01',1954),--giam dau ha sot
('0008','Allopurinol','',N'Bệnh nhân cao tuổi','2023/12/01',370),
('0009','Colchicin',N'Chống viêm giảm đau trong cơn gout','','2022/12/05',218),--gout
('0010','Valproat natri',N'Co giật, động kinh','','2023/01/01',2350),--co giat dong kinh
('0011','Amlodipin','',N'Bệnh nhân cao tuổi','2024/01/01',798),
('0012','Bisoprolol','',N'Phụ nữ đang cho con bú','2023/01/02',900)--huyet ap

----------------------------
GO
INSERT INTO DanhMuc
VALUES
('#1',N'Chống dị ứng'),
('#2',N'Giải độc'),
('#3',N'Giảm đau, hạ sốt'),
('#4',N'Gout'),
('#5',N'Co giật động kinh'),
('#6',N'Huyết áp')
-------------------------------------
GO
INSERT INTO DanhMuc_Thuoc
VALUES
('0000','#1'),
('0001','#1'),
('0002','#1'),
('0003','#2'),
('0004','#2'),
('0005','#3'),
('0006','#3'),
('0007','#3'),
('0008','#4'),
('0009','#4'),
('0010','#5'),
('0011','#6'),
('0012','#6')
-----------------
GO
INSERT INTO ThanhPhan_Thuoc
VALUES
('Cetirizine dihydrochloride','0000'),
('Lactose monohydrat','0000'),
('Magnesi stearat','0000'),
('Lactose monohydrat','0001'),
('Cinnarizin','0001'),
('Lactose','0002'),
('Povidon','0002'),
('Natri bicacbonat ','0003'),
('Bitartrat monohydrat','0004'),
('Noradrenalin','0004'),
('Aspirin','0005'),
('Meloxicam ','0006'),
('Acetaminophen','0007'),
('Paracetamol','0007'),
('Lactose monohydrat','0008'),
('Povidon','0008'),
('Colchicin','0009'),
('Lactose monohydrat','0009'),
('Magnesi stearat','0009'),
('Natri valproat','0010'),
('Amlodipin besylate','0011'),
('Amlodipine','0011'),
('Bisoprolol fumarat','0012')
----------------------------------------------
GO
INSERT INTO KhoThuoc
VALUES
('KT001',N'Tổng kho Hà Đông',N'Số 48, Nguyễn Trãi, Hà Đông, Hà Nội'),
('KT002',N'97 Hạo Nam',N'Số 19, Trần Đại Nghĩa, Cầu Giấy, Hà Nội'),
('KT003',N'KT Hà Tây', N'Số 90, Lê Đại Hành, Hai Bà Trưng, Long Biên, Hà Nội'),
('KT004',N'Kho thuốc Hà Đông',N'Số 16, Phúc La, Hà Đông, Hà Nội')
------------------------------------
GO
INSERT INTO Thuoc_KhoThuoc
VALUES
('0000','KT001',1000),
('0001','KT001',999),
('0002','KT001',200),
('0004','KT001',100),
('0006','KT001',300),
('0007','KT001',450),
('0008','KT001',200),
('0010','KT001',100),
('0012','KT001',150),
('0000','KT002',200),
('0001','KT002',300),--
('0004','KT002',100),
('0005','KT002',300),
('0006','KT002',200),
('0007','KT002',300),
('0008','KT002',400),
('0009','KT002',300),
('0010','KT002',250),
('0011','KT002',150),
('0003','KT003',500),--
('0007','KT003',400),
('0008','KT003',600),
('0006','KT004',500),
('0009','KT004',300),
('0011','KT004',200),
('0012','KT004',100)
-----------------------------------------
GO
INSERT INTO KhachHang(MaKH,TenKH, DiaChiKH, GioiTinhKH)
VALUES
('000001',N'Phạm Thiên An',N'Số 123 Đường Tô Hiệu, Phường Nguyễn Trãi, Quận Hà Đông, Thành phố Hà Nội',N'Nữ'),
('000002',N'Trần Ngọc Bảo',N'Số nhà 28 ngõ 39 tổ 7 Đa Sỹ, Phường Kiến Hưng, Quận Hà Đông, Thành phố Hà Nội',N'Nam'),
('000003',N'Nguyễn Bảo Anh',N'Số 400 Đường Quang Trung, Phường La Khê, Quận Hà Đông, Thành phố Hà Nội',N'Nữ'),
('000004',N'Nguyễn Trần Quốc Duy',N'Số nhà 34 LK 11B Khu đô thị Mỗ Lao, Phường Mộ Lao, Quận Hà Đông, Thành phố Hà Nội',N'Nam'),
('000005',N'Phan Đức Thanh Duy',N'Số 62, Phố Hương Viên, Phường Đồng Nhân, Quận Hai Bà Trưng, Thành phố Hà Nội',N'Nam'),
('000006',N'Trần Đình Hưng',N'Số nhà 228, Tổ 18, Phố Đức Giang, Phường Thượng Thanh, Quận Long Biên, Thành phố Hà Nội',N'Nam'),
('000007',N'Trần Kiên Hưng',N'Xóm Chùa, Xã Kim Nỗ, Huyện Đông Anh, Thành phố Hà Nội',N'Nam'),
('000008',N'Hứa Lan',N'Số 4, Ngách 61/1/8, Đường Nguyễn Văn Giáp, Tổ 15, Phường Cầu Diễn, Quận Nam Từ Liêm, Thành phố Hà Nội',N'Nữ'),
('000009',N'Hà Đình Đức Huy',N'Thôn Thiết Bình, Xã Vân Hà, Huyện Đông Anh, Thành phố Hà Nội',N'Nam'),
('000010',N'Bùi Hứa Xuân Huy',N'12 Đường Bằng Lăng, Khu Vinhome Riverside, Phường Việt Hưng, Quận Long Biên, Thành phố Hà Nội',N'Nam'),
('000011',N'Đặng Lê Quốc Khang',N'190 Lò Đúc, Phường Đống Mác, Quận Hai Bà Trưng, Thành phố Hà Nội',N'Nam'),
('000012',N'Phạm Đức Quốc Khánh',N'ngõ 44/65 đường Nguyễn Cơ Thạch, Phường Cầu Diễn, Quận Nam Từ Liêm, Thành phố Hà Nội',N'Nam'),
('000013',N'Võ Ngọc Hân',N'Thôn Gia Lương, Xã Việt Hùng, Huyện Đông Anh, Thành phố Hà Nội',N'Nữ'),
('000014',N'Nguyễn Tiến Khoa',N'Tòa HH 02-1C, Khu đô thị Thanh Hà, Xã Cự Khê, Huyện Thanh Oai, Thành phố Hà Nội',N'Nam'),
('000015',N'Vũ Trung Kiên',N'Nhà số 10 Ngõ 44/19 Phố Bằng B, Tổ 5, Phường Hoàng Liệt, Quận Hoàng Mai, Thành phố Hà Nội',N'Nam'),
('000016',N'Nguyễn Thị Thùy Linh',N'Số 9Q8 ngõ 118 đường Nguyễn An Ninh, Tổ 26, Phường Tương Mai, Quận Hoàng Mai, Thành phố Hà Nội',N'Nữ'),
('000017',N'Nguyễn Đình Lộc',N'Số 9, ngõ 93 Đường Hoàng Quốc Việt, Phường Nghĩa Đô, Quận Cầu Giấy, Thành phố Hà Nội',N'Nam'),
('000018',N'Nguyễn Thành Lợi',N'Xóm 2, Xã Chương Dương, Huyện Thường Tín, Thành phố Hà Nội',N'Nam'),
('000019',N'Vũ Đức Minh',N'Số 6 ngõ 89 đường Mễ Trì Thượng, Phường Mễ Trì, Quận Nam Từ Liêm, Thành phố Hà Nội',N'Nam'),
('000020',N'Nguyễn Lê Minh',N'Số 13 Lô 5, Khu nhà ở Phùng Khoang, Phường Trung Văn, Quận Nam Từ Liêm, Thành phố Hà Nội',N'Nam'),
('000021',N'Võ Ngọc Nga',N'Thôn Thanh Vân, Xã Tân Dân, Huyện Sóc Sơn, Thành phố Hà Nội',N'Nữ'),
('000022',N'Bùi Minh Nhật',N'Số 9 Ngõ 15 Tổ dân phố Phú Thứ, Đường Tây Mỗ, Phường Tây Mỗ, Quận Nam Từ Liêm, Thành phố Hà Nội',N'Nữ'),
('000023',N'Đặng Hoàng Phi Yến',N'Số 30D Kim Mã Thượng, Phường Cống Vị, Quận Ba Đình, Thành phố Hà Nội',N'Nam'),
('000024',N'Lê Hoàng Phúc',N'Nhà số 01- B3, Ngõ 201, Đường Trần Quốc Hoàn, Phường Dịch Vọng Hậu, Quận Cầu Giấy, Thành phố Hà Nội',N'Nam')
-----------------------------------
GO

INSERT INTO KhachHangSDT
VALUES
('000001','0912503779'),
('000001','0912503777'),
('000002','0912555779'),
('000003','0262503792'),
('000004','0982503722'),
('000005','0976526543'),
('000006','0261203129'),
('000007','0982539999'),
('000008','0129503574'),
('000009','0269584852'),
('000010','0250948532'),
('000010','0989454649'),
('000011','0935857213'),
('000012','0919583756'),
('000013','0927572657'),
('000014','0985854737'),
('000015','0237867356'),
('000016','0584767352'),
('000017','0349574724'),
('000018','0346493556'),
('000019','0120584747'),
('000021','0349687564'),
('000022','0956487564'),
('000023','0349659486'),
('000024','0229542685'),
('000024','0119584868')

--------------------------------
GO
INSERT INTO NhanVien(MaNV,TenNV, DiaChiNV, GioiTinhNV, VaiTro)
VALUES
('00001',N'Trần Thái Vân Anh',N'Số 197 đường Hoàng Hoa Thám, Phường Liễu Giai, Quận Ba Đình, Thành phố Hà Nội',N'Nữ',N'Quản lý kho'),
('00002',N'Nguyễn Thị Huỳnh Anh',N'Số 112 Đường Láng Hạ, Phường Láng Hạ, Quận Đống Đa, Thành phố Hà Nội',N'Nam',N'Quản lý kho'),
('00003',N'Huỳnh Đức Ngọc Diệp',N'số 7 Cát Linh, Phường Quốc Tử Giám, Quận Đống Đa, Thành phố Hà Nội',N'Nữ',N'Quản lý kho'),
('00004',N'Lê Hồ Minh Duy',N'số 100 Yên Lãng, Phường Thịnh Quang, Quận Đống Đa, Thành phố Hà Nội',N'Nam',N'Quản lý kho'),
('00005',N'Tăng Du Linh',N'Số 20 Ngõ chợ, Thôn Mùi, Xã Bích Hòa, Huyện Thanh Oai, Thành phố Hà Nội',N'Nam',N'Thu ngân'),
('00006',N'Võ Thị Bích Loan',N'Số 178 Thôn Chua, Xã Bình Minh, Huyện Thanh Oai, Thành phố Hà Nội',N'Nữ',N'Thu ngân'),
('00007',N'Lê Thái Toàn',N'Số 64 ngõ 37 Bằng Liệt, Phường Hoàng Liệt, Quận Hoàng Mai, Thành phố Hà Nội',N'Nam',N'Thu ngân'),
('00008',N'Phạm Khánh Vy',N'203 phố Minh Khai, Phường Minh Khai, Quận Hai Bà Trưng, Thành phố Hà Nội',N'Nữ',N'Thu ngân'),
('00009',N'Đào Hiếu',N'Số 48 Tố Hữu, Phường Trung Văn, Quận Nam Từ Liêm, Thành phố Hà Nội',N'Nam',N'Thu ngân'),
('00010',N'Nguyễn Hoàng Minh',N'Số 146 đường Trần Bình, Phường Mỹ Đình 2, Quận Nam Từ Liêm, Thành phố Hà Nội',N'Nam',N'Thu ngân'),
('00011',N'Đinh Nguyễn Hoàng Kim',N'Số 8C phố Cù Chính Lan, Phường Khương Mai, Quận Thanh Xuân, Thành phố Hà Nội',N'Nam',N'Thu ngân'),
('00012',N'Nguyễn Ngọc Phương Trang',N'Số 255 Lê Duẩn, Phường Nguyễn Du, Quận Hai Bà Trưng, Thành phố Hà Nội',N'Nữ',N'Thu ngân'),
('00013',N'Lê Mỹ Phương',N'Số 50 Ngõ 379 Phố Minh Khai, Phường Vĩnh Tuy, Quận Hai Bà Trưng, Thành phố Hà Nội',N'Nữ',N'Thu ngân')
-------------------------------
GO
INSERT INTO NhanVien_SDT
VALUES
('00001','0912521579'),
('00001','0921848574'),
('00002','0922858485'),
('00003','0994774847'),
('00004','0982533722'),
('00005','0916526543'),
('00006','0231403129'),
('00007','0988239999'),
('00008','0729503564'),
('00009','0919584863'),
('00010','0120448545'),
('00010','0972654632'),
('00011','0975887922'),
('00012','0976687822'),
('00013','0978257622'),
('00013','0964657422')
---------------------------
GO

INSERT INTO ThuNgan
VALUES
('00005',''),
('00006',N'Kế toán'),
('00007',N'Kế toán'),
('00008',N'Tư vấn'),
('00009',N'Kế toán'),
('00010',N'Kế toán'),
('00011',N'Tư vấn'),
('00012',N'Tư vấn'),
('00013','')
-------------------
go
INSERT INTO QuanLyKho
VALUES
('00001','KT001'),
('00002','KT002'),
('00003','KT003'),
('00004','KT004')

-----------------------
GO
INSERT INTO HDB
VALUES
('HDB00001','00005','000001','2021/05/12'),
('HDB00002','00005','000002','2021/06/07'),
('HDB00003','00006','000001','2021/07/11'),
('HDB00004','00007','000003','2021/07/21'),
('HDB00005','00005','000004','2021/10/25'),
('HDB00006','00008','000005','2021/11/09'),
('HDB00007','00009','000006','2022/01/06'),
('HDB00008','00010','000008','2022/01/30'),
('HDB00009','00011','000009','2022/02/18'),
('HDB00010','00012','000007','2022/02/09'),
('HDB00011','00006','000003','2022/03/04'),
('HDB00012','00006','000008','2022/03/05'),
('HDB00013','00007','000009','2022/03/06'),
('HDB00014','00008','000010','2022/04/05'),
('HDB00015','00009','000012','2022/05/02'),
('HDB00016','00011','000013','2022/05/02'),
('HDB00017','00012','000014','2022/05/03'),
('HDB00018','00013','000015','2022/06/04'),
('HDB00019','00013','000016','2022/06/06'),
('HDB00020','00005','000016','2022/06/06'),
('HDB00021','00008','000017','2022/06/24'),
('HDB00022','00009','000016','2022/07/14'),
('HDB00023','00006','000017','2022/07/22'),
('HDB00024','00007','000018','2022/08/26'),
('HDB00025','00005','000019','2022/09/25'),
('HDB00026','00006','000001','2022/09/23'),
('HDB00027','00009','000019','2022/09/24'),
('HDB00028','00010','000020','2022/10/25'),
('HDB00029','00011','000021','2022/10/26'),
('HDB00030','00012','000022','2022/11/02'),
('HDB00031','00013','000023','2022/11/06'),
('HDB00032','00006','000024','2022/12/07'),
('HDB00033','00008','000002','2022/12/09')

-------------
GO
INSERT INTO CT_HDB
VALUES
('0000','HDB00001',10),
('0001','HDB00001',4),
('0002','HDB00001',6),
('0001','HDB00002',3),
('0004','HDB00002',4),
('0002','HDB00002',6),
('0003','HDB00002',5),
('0001','HDB00003',1),
('0002','HDB00003',7),
('0003','HDB00003',4),
('0005','HDB00004',5),
('0004','HDB00005',3),
('0005','HDB00006',5),
('0005','HDB00007',10),
('0006','HDB00007',6),
('0008','HDB00008',2),
('0007','HDB00009',3),
('0010','HDB00010',7),
('0010','HDB00011',2),
('0005','HDB00012',4),
('0006','HDB00013',5),
('0008','HDB00014',8),
('0009','HDB00015',1),
('0006','HDB00016',2),
('0010','HDB00016',5),
('0010','HDB00017',10),
('0007','HDB00018',9),
('0008','HDB00018',10),
('0001','HDB00019',19),
('0002','HDB00020',2),
('0004','HDB00021',9),
('0006','HDB00022',10),
('0007','HDB00023',8),
('0008','HDB00024',7),
('0001','HDB00025',7),
('0002','HDB00026',5),
('0003','HDB00027',6),
('0004','HDB00027',6),
('0007','HDB00028',7),
('0009','HDB00029',8),
('0010','HDB00029',10),
('0002','HDB00030',10),
('0003','HDB00031',6),
('0006','HDB00032',8),
('0007','HDB00033',5),
('0008','HDB00033',8)
-------------------------------
GO
INSERT INTO NCC
VALUES
('NT0001',N'Công ty TNHH Mediphar USA',N'Số nhà 28 ngõ 39 tổ 7 Đa Sỹ, Phường Kiến Hưng, Quận Hà Đông, Thành phố Hà Nội'),
('NT0002',N'Công ty cổ phần Traphaco',N'75 Yên Ninh, Ba Đình, Hà Nội, Việt Nam'),
('NT0003',N'Công ty cổ phần dược Hậu Giang',N'288 Bis Nguyễn Văn Cừ, P. An Hòa, Q. Ninh Kiều, TP. Cần Thơi'),
('NT0004',N'Công ty cổ phần dược phẩm Hà Tây',N'10A Quang Trung – Hà Đông – Hà Nội'),
('NT0005',N'Công ty cổ phần hóa dược phẩm Mekophar',N'297/5 Lý Thường Kiệt, Quận 11, Tp Hồ Chí Minh, Việt Nam')
-----------------------------------
GO
INSERT INTO NCC_SDT
VALUES
('NT0001','09988866666'),
('NT0001','09277777744'),
('NT0002','02228886666'),
('NT0002','01228584855'),
('NT0003','09947748474'),
('NT0003','02933331433'),
('NT0003','02999991433'),
('NT0004','04235225222'),
('NT0004','04335225225'),
('NT0005','02838650258')
------------------------------------------
GO
INSERT INTO ChiNhanh
VALUES
(N'Chi nhánh công ty Mediphar brand no.1','NT0001',N'Số 4, Ngách 61/1/8, Đường Nguyễn Văn Giáp, Tổ 15, Phường Cầu Diễn, Quận Nam Từ Liêm, Thành phố Hà Nội'),
(N'Chi nhánh công ty Mediphar brand no.2','NT0001',N'BL5.12 Đường Bằng Lăng, Khu Vinhome Riverside, Phường Việt Hưng, Quận Long Biên, Thành phố Hà Nội'),
(N'Chi nhánh công ty Mediphar brand no.3','NT0001',N'35D3 190 Lò Đúc, Phường Đống Mác, Quận Hai Bà Trưng, Thành phố Hà Nội'),
(N'Chi nhánh công ty cổ phần Traphaco','NT0002',N'Nhà A3 khu X3, ngõ 44/65 đường Nguyễn Cơ Thạch, Phường Cầu Diễn, Quận Nam Từ Liêm, Thành phố Hà Nội'),
(N'Chi nhánh công ty cổ phần dược Hậu Giang brand no.1','NT0003',N'Số 9Q8 ngõ 118 đường Nguyễn An Ninh, Tổ 26, Phường Tương Mai, Quận Hoàng Mai, Thành phố Hà Nội'),
(N'Chi nhánh công ty cổ phần dược Hậu Giang brand no.2','NT0003',N'Số 9, ngõ 93 Đường Hoàng Quốc Việt, Phường Nghĩa Đô, Quận Cầu Giấy, Thành phố Hà Nội'),
(N'Chi nhánh công ty cổ phần dược phẩm Hà Tây','NT0004',N'Số 6 ngõ 89 đường Mễ Trì Thượng, Phường Mễ Trì, Quận Nam Từ Liêm, Thành phố Hà Nội'),
(N'Chi nhánh công ty cổ phần hóa dược phẩm Mekophar','NT0005',N'Số 13 Lô 5, Khu nhà ở Phùng Khoang, Phường Trung Văn, Quận Nam Từ Liêm, Thành phố Hà Nội')

-------------------------------------------
GO
INSERT INTO HDN
VALUES
('HDN00001','00005',N'Chi nhánh công ty Mediphar brand no.1','NT0001','2021/02/11'),
('HDN00002','00005',N'Chi nhánh công ty Mediphar brand no.1','NT0001','2021/03/09'),
('HDN00003','00006',N'Chi nhánh công ty Mediphar brand no.1','NT0001','2021/07/11'),
('HDN00004','00009',N'Chi nhánh công ty cổ phần Traphaco','NT0002','2021/07/21'),
('HDN00005','00007',N'Chi nhánh công ty cổ phần Traphaco','NT0002','2021/10/25'),
('HDN00006','00009',N'Chi nhánh công ty cổ phần dược Hậu Giang brand no.2','NT0003','2021/12/09'),
('HDN00007','00007',N'Chi nhánh công ty cổ phần dược phẩm Hà Tây','NT0004','2022/01/16'),
('HDN00008','00011',N'Chi nhánh công ty Mediphar brand no.3','NT0001','2022/01/31'),
('HDN00009','00011',N'Chi nhánh công ty cổ phần dược Hậu Giang brand no.1','NT0003','2022/02/23'),
('HDN00010','00012',N'Chi nhánh công ty cổ phần hóa dược phẩm Mekophar','NT0005','2022/02/24'),
('HDN00011','00007',N'Chi nhánh công ty cổ phần dược Hậu Giang brand no.2','NT0003','2022/02/24'),
('HDN00012','00008',N'Chi nhánh công ty cổ phần dược phẩm Hà Tây','NT0004','2022/03/10'),
('HDN00013','00007',N'Chi nhánh công ty Mediphar brand no.1','NT0001','2022/03/12'),
('HDN00014','00010',N'Chi nhánh công ty cổ phần hóa dược phẩm Mekophar','NT0005','2022/04/12'),
('HDN00015','00009',N'Chi nhánh công ty cổ phần dược Hậu Giang brand no.2','NT0003','2022/05/12'),
('HDN00016','00011',N'Chi nhánh công ty cổ phần Traphaco','NT0002','2022/05/20'),
('HDN00017','00012',N'Chi nhánh công ty cổ phần hóa dược phẩm Mekophar','NT0005','2022/05/20'),
('HDN00018','00010',N'Chi nhánh công ty Mediphar brand no.1','NT0001','2022/06/04'),
('HDN00019','00010',N'Chi nhánh công ty cổ phần dược Hậu Giang brand no.2','NT0003','2022/06/04'),
('HDN00020','00005',N'Chi nhánh công ty cổ phần Traphaco','NT0002','2022/06/06'),
('HDN00021','00008',N'Chi nhánh công ty cổ phần dược phẩm Hà Tây','NT0004','2022/06/24'),
('HDN00022','00009',N'Chi nhánh công ty cổ phần dược Hậu Giang brand no.2','NT0003','2022/07/25'),
('HDN00023','00006',N'Chi nhánh công ty cổ phần Traphaco','NT0002','2022/07/30'),
('HDN00024','00007',N'Chi nhánh công ty cổ phần dược phẩm Hà Tây','NT0004','2022/08/25'),
('HDN00025','00005',N'Chi nhánh công ty cổ phần Traphaco','NT0002','2022/09/01'),
('HDN00026','00006',N'Chi nhánh công ty cổ phần dược Hậu Giang brand no.2','NT0003','2022/09/20'),
('HDN00027','00009',N'Chi nhánh công ty cổ phần hóa dược phẩm Mekophar','NT0005','2022/09/20'),
('HDN00028','00010',N'Chi nhánh công ty cổ phần Traphaco','NT0002','2022/10/21'),
('HDN00029','00007',N'Chi nhánh công ty cổ phần dược Hậu Giang brand no.2','NT0003','2022/10/26'),
('HDN00030','00008',N'Chi nhánh công ty Mediphar brand no.1','NT0001','2022/11/05'),
('HDN00031','00013',N'Chi nhánh công ty cổ phần hóa dược phẩm Mekophar','NT0005','2022/11/05'),
('HDN00032','00005',N'Chi nhánh công ty cổ phần dược Hậu Giang brand no.2','NT0003','2022/11/05'),
('HDN00033','00007',N'Chi nhánh công ty cổ phần dược phẩm Hà Tây','NT0004','2022/12/12')
--------------------------------------
GO
INSERT INTO CT_HDN
VALUES
('0000','HDN00001',1000),
('0001','HDN00001',4000),
('0002','HDN00001',6000),
('0001','HDN00002',3000),
('0004','HDN00002',4000),
('0002','HDN00002',600),
('0003','HDN00002',500),
('0001','HDN00003',1000),
('0002','HDN00003',7000),
('0003','HDN00003',4000),
('0005','HDN00004',500),
('0004','HDN00005',300),
('0005','HDN00006',5000),
('0005','HDN00007',1000),
('0006','HDN00007',6000),
('0008','HDN00008',2000),
('0007','HDN00009',3000),
('0010','HDN00010',7000),
('0010','HDN00011',2000),
('0005','HDN00012',4000),
('0006','HDN00013',5000),
('0008','HDN00014',8000),
('0009','HDN00015',1000),
('0006','HDN00016',2000),
('0010','HDN00016',5000),
('0010','HDN00017',1000),
('0007','HDN00018',9000),
('0008','HDN00018',1000),
('0001','HDN00019',9000),
('0002','HDN00020',2000),
('0004','HDN00021',9000),
('0006','HDN00022',1000),
('0007','HDN00023',8000),
('0008','HDN00024',7000),
('0001','HDN00025',7000),
('0002','HDN00026',5000),
('0003','HDN00027',6000),
('0004','HDN00027',6000),
('0007','HDN00028',7000),
('0009','HDN00029',8000),
('0010','HDN00029',10000),
('0002','HDN00030',1000),
('0003','HDN00031',6000),
('0006','HDN00032',8000),
('0007','HDN00033',5000),
('0008','HDN00033',8000)

--1 Thống kê thuốc có thành phần Lactose monohydrat và chống chỉ định với người cao tuổi
SELECT t.MaThuoc [Mã thuốc], t.TenThuoc [Tên thuốc], t.ChongChiDinh [Chống chỉ định], tp.ThanhPhan [Thành phần] 
FROM Thuoc AS t
LEFT JOIN ThanhPhan_Thuoc AS tp ON tp.MaThuoc = t.MaThuoc
WHERE t.ChongChiDinh LIKE N'%cao tuổi%' AND tp.ThanhPhan = 'Lactose monohydrat'


--2 Thống kê doanh thu của từng nhân viên có địa chỉ ở Hai Bà Trưng trong năm 2022
SELECT C.MaTN AS [Mã thu ngân], SUM( C.SoLuongXuat*C.Gia ) AS [Doanh thu]
FROM (SELECT B.MaTN, B.MaThuoc, B.SoLuongXuat, Thuoc.Gia
	  FROM Thuoc, (SELECT CT_HDB.MaThuoc, CT_HDB.MaHDB, A.MaTN, CT_HDB.SoLuongXuat
			       FROM CT_HDB, (SELECT * FROM HDB
							     WHERE EXISTS ( SELECT * FROM NhanVien 
												WHERE MaNV = HDB.MaTN 
												AND DiaChiNV LIKE N'%Hai Bà Trưng%' 
												AND VaiTro != 'Quản lý Kho' 
												AND YEAR(NgayBan) = '2022')) AS A
				   WHERE CT_HDB.MaHDB = A.MaHDB) AS B
	  WHERE Thuoc.MaThuoc = B.MaThuoc) AS C
GROUP BY C.MaTN


SELECT C.MaTN AS [Mã thu ngân], SUM( C.SoLuongXuat*C.Gia ) AS [Doanh thu]
FROM (SELECT B.MaTN, B.MaThuoc, B.SoLuongXuat, Thuoc.Gia
	FROM Thuoc, (SELECT CT_HDB.MaThuoc, CT_HDB.MaHDB, A.MaTN, CT_HDB.SoLuongXuat
				FROM CT_HDB, (SELECT * FROM HDB
							WHERE EXISTS ( SELECT * FROM NhanVien 
										WHERE MaNV = HDB.MaTN 
										AND DiaChiNV LIKE N'%Hai Bà Trưng%' 
										AND VaiTro != 'Quản lý Kho' 
										AND YEAR(NgayBan) = '2022')) AS A
				WHERE CT_HDB.MaHDB = A.MaHDB) AS B
	  WHERE Thuoc.MaThuoc = B.MaThuoc) AS C
GROUP BY C.MaTN


--3 Thống kê doanh thu của của hàng từ ngày 20/1/2022 đến ngày 20/10/2022
SELECT  SUM( c.SoLuongXuat*t.Gia ) AS 'Doanh Thu' 
FROM ((CT_HDB  AS c
LEFT JOIN HDB AS h  ON c.MaHDB =h.MaHDB)
LEFT JOIN Thuoc AS t ON c.MaThuoc = t.MaThuoc)
WHERE h.NgayBan BETWEEN '2022/01/20 ' AND '2022/10/20'


--4 Thống kê doanh thu tổng của cửa hàng
SELECT  SUM( c.SoLuongXuat*t.Gia ) AS [Tổng doanh thu]
FROM ((CT_HDB  AS c
LEFT JOIN HDB AS h  ON c.MaHDB = h.MaHDB)
LEFT JOIN Thuoc AS t ON c.MaThuoc = t.MaThuoc)

--5 Liệt kê tên chi nhánh tại Nam Từ Liêm, tên nhà cung cấp được nhập hàng từ nhân viên nam nhập nhiều lần nhất và số lần nhập
SELECT ChiNhanh.TenCN AS [Tên chi nhánh], ChiNhanh.DiaChiCN AS [Địa chỉ chi nhánh], NCC.TenNCC AS [Tên nhà cung cấp], A.SoLanNhap AS [Số lần nhập]
FROM ChiNhanh, NCC, (SELECT HDN.TenCN, HDN.MaNCC, COUNT(MaHDN) AS SoLanNhap
					FROM HDN, ChiNhanh, NhanVien
					WHERE ChiNhanh.DiaChiCN like N'%Nam Từ Liêm%' 
					AND HDN.MaNCC = ChiNhanh.MaNCC
					AND HDN.MaTN = NhanVien.MaNV
					AND NhanVien.GioiTinhNV = 'Nam'
					GROUP BY HDN.TenCN, HDN.MaNCC) AS A,
					(SELECT MAX(SoLanNhap) As MAX 
					FROM (SELECT HDN.TenCN,HDN.MaNCC,COUNT(MaHDN) AS SoLanNhap
						FROM HDN, ChiNhanh, NhanVien
						WHERE ChiNhanh.DiaChiCN like N'%Nam Từ Liêm%' 
						AND HDN.MaNCC = ChiNhanh.MaNCC
						AND HDN.MaTN = NhanVien.MaNV
						AND NhanVien.GioiTinhNV = 'Nam'
						GROUP BY HDN.TenCN, HDN.MaNCC) AS A)AS B
WHERE A.SoLanNhap = B.MAX 
AND A.MaNCC = ChiNhanh.MaNCC
AND A.TenCN = ChiNhanh.TenCN
AND ChiNhanh.MaNCC = NCC.MaNCC


--6.Liệt kê mã, tên, đơn giá của khách hàng có địa chỉ tại Hà Đông có đơn giá cao nhất kể từ năm 2022
SELECT A.MaKH AS [Mã khách hàng], A.TenKH AS [Tên khách hàng], A.DiaChiKH [Địa chỉ khách hàng], A.[Tổng hóa đơn] 
	FROM (SELECT SUM(SoLuongXuat*Gia) AS [Tổng hóa đơn], MaKH, TenKH, DiaChiKH 
		FROM (SELECT ct.MaThuoc, ct.SoLuongXuat, t.Gia, hdb.MaKH, kh.TenKH, kh.DiaChiKH 
			FROM CT_HDB AS ct, Thuoc AS t, HDB AS hdb, KhachHang AS kh
			WHERE t.MaThuoc = ct.MaThuoc 
			AND hdb.MaHDB = ct.MaHDB 
			AND hdb.NgayBan >='2022/01/01'
			AND hdb.MaKH = KH.MaKH) AS M
		WHERE DiaChiKH LIKE N'%Hà Đông%'
		GROUP BY MaKH, TenKH, DiaChiKH) AS A,
		(SELECT MAX([Tổng hóa đơn]) AS [Max value] 
		FROM (SELECT SUM(SoLuongXuat*Gia) AS [Tổng hóa đơn], MaKH, DiaChiKH 
			FROM (SELECT ct.MaThuoc, ct.SoLuongXuat, t.Gia, hdb.MaKH, kh.DiaChiKH 
				FROM CT_HDB AS ct, Thuoc AS t, HDB AS hdb, KhachHang AS kh
				WHERE t.MaThuoc = ct.MaThuoc 
				AND hdb.MaHDB = ct.MaHDB
				AND hdb.NgayBan >='2022/01/01'
				AND hdb.MaKH = KH.MaKH) AS M
			GROUP BY MaKH, DiaChiKH) AS A
		WHERE DiaChiKH LIKE N'%Hà Đông%') AS B
WHERE A.[Tổng hóa đơn] = B.[Max value]

--7 Liệt kê mã, tên nhà cung cấp ở Nam Từ Liêm có số lượng hàng lớn nhất kể từ năm 2022
SELECT NCC.MaNCC AS [Mã nhà cung cấp], NCC.TenNCC AS [Tên nhà cung cấp], A.tong AS [Số lượng hàng] FROM NCC, ChiNhanh, (
	SELECT HDN.MaNCC, NCC.TenNCC, SUM(soluongnhap) 'Tong' FROM HDN, CT_HDN, ChiNhanh, NCC
	WHERE HDN.MaHDN = CT_HDN.MaHDN
	AND ChiNhanh.TenCN = HDN.TenCN
	AND NCC.MaNCC = ChiNhanh.MaNCC
	AND ChiNhanh.DiaChiCN LIKE N'%Nam Từ Liêm%'
	AND HDN.NgayNhap >= '2022/01/01'
	GROUP BY HDN.MaNCC, NCC.TenNCC) AS A, (
		SELECT MAX(tong) AS MAX FROM (
			SELECT HDN.MaNCC, NCC.TenNCC, SUM(soluongnhap) 'Tong' FROM HDN, CT_HDN, ChiNhanh, NCC
			WHERE HDN.MaHDN = CT_HDN.MaHDN
			AND ChiNhanh.TenCN = HDN.TenCN
			AND NCC.MaNCC = ChiNhanh.MaNCC
			AND ChiNhanh.DiaChiCN LIKE N'%Nam Từ Liêm%'
			AND HDN.NgayNhap >= '20220101'
			GROUP BY HDN.MaNCC, NCC.TenNCC
		) AS A
	) AS B 
WHERE A.Tong = B.MAX
AND NCC.MaNCC = ChiNhanh.MaNCC
AND A.MaNCC = NCC.MaNCC

--8 Liệt kê mã, tên của loại thuốc được khách hàng tại Hà Đông mua với số lượng nhiều nhất kể từ tháng 3 năm 2022 đến tháng 10 năm 2022
SELECT A.MaThuoc AS [Mã thuốc], A.TenThuoc AS [Tên thuốc], A.[Số Lượng]  
	FROM (SELECT SUM(SoLuongXuat) AS [Số Lượng], MaThuoc, TenThuoc 
		FROM (SELECT t.MaThuoc, t.TenThuoc, ct.SoLuongXuat,kh.MaKH, kh.DiaChiKH, hdb.NgayBan, hdb.MaHDB 
			FROM Thuoc AS t, CT_HDB AS ct, KhachHang AS kh, HDB AS HDB
			WHERE t.MaThuoc = ct.MaThuoc 
			AND hdb.MaKH = kh.MaKH 
			AND ct.MaHDB = hdb.MaHDB 
			AND kh.DiaChiKH LIKE N'%Hà Đông%' 
			AND NgayBan BETWEEN '2022/03/01' 
			AND '2022/10/01') AS M
		GROUP BY MaThuoc, TenThuoc) AS A,
		(SELECT MAX ([Số Lượng]) AS MAX 
		FROM (SELECT SUM(SoLuongXuat) AS [Số Lượng], MaThuoc, TenThuoc 
			FROM (SELECT t.MaThuoc, t.TenThuoc, ct.SoLuongXuat,kh.MaKH, kh.DiaChiKH, hdb.NgayBan, hdb.MaHDB 
				FROM Thuoc AS t, CT_HDB AS ct, KhachHang AS kh, HDB AS HDB
				WHERE t.MaThuoc = ct.MaThuoc 
				AND hdb.MaKH = kh.MaKH 
				AND ct.MaHDB = hdb.MaHDB 
				AND kh.DiaChiKH LIKE N'%Hà Đông%' 
				AND NgayBan BETWEEN '2022/03/01' 
				AND '2022/10/01') AS M
		GROUP BY MaThuoc, TenThuoc) AS A) AS B
WHERE A.[Số Lượng] = B.MAX

--9. Tháng mấy trong năm 2022 doanh số bán hàng cao nhất
SELECT MONTH(NgayBan) AS [Tháng], SUM([Total Bill]) AS [Doanh thu]
FROM (SELECT SUM(Gia*SoLuongXuat) AS [Total Bill], MaHDB, NgayBan 
	FROM (SELECT hdb.MaHDB, t.MaThuoc, ct.SoLuongXuat, t.Gia, hdb.NgayBan 
		FROM HDB AS hdb, CT_HDB AS ct, Thuoc AS t
		WHERE t.MaThuoc = ct.MaThuoc 
		AND ct.MaHDB = HDB.MaHDB) AS A
	GROUP BY MaHDB, NgayBan) AS B
WHERE YEAR(NgayBan) = 2022
GROUP BY MONTH(NgayBan)
HAVING SUM([Total Bill]) >=ALL
(SELECT SUM([Total Bill]) 
FROM (SELECT SUM(Gia*SoLuongXuat) AS [Total Bill], MaHDB, NgayBan 
	FROM (SELECT hdb.MaHDB, t.MaThuoc, ct.SoLuongXuat, t.Gia, hdb.NgayBan 
		FROM HDB AS hdb, CT_HDB AS ct, Thuoc AS t
		WHERE t.MaThuoc = ct.MaThuoc 
		AND ct.MaHDB = HDB.MaHDB) AS A
	GROUP BY MaHDB, NgayBan) AS B
WHERE YEAR(NgayBan) = 2022
GROUP BY MONTH(NgayBan))
