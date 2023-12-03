CREATE DATABASE SGUMusicStore
GO
USE SGUMusicStore
GO
----------------------------------------- [TAO BANG] ------------------------------------------
CREATE TABLE Bill
(
	idBill NVARCHAR(255) NOT NULL,
	idUser NVARCHAR(255) NULL,
	Shipping INT NOT NULL,
	Total INT NOT NULL,
	PTTT NVARCHAR(255) NOT NULL,
	[status] BIT NOT NULL,
	createdAt DATETIME NOT NULL,
	totalQty INT NOT NULL,
	nameBook NVARCHAR(255) NOT NULL,
	email NVARCHAR(255) NOT NULL,
	phone NVARCHAR(255) NOT NULL,
	[address] NVARCHAR(255) NOT NULL,
	PRIMARY KEY (idBill)
)
GO
CREATE TABLE DetailBIll
(
	idDetailBill NVARCHAR(255) NOT NULL,
	idProduct NVARCHAR(255) NOT NULL,
	idBill NVARCHAR(255) NOT NULL,
	qty INT NOT NULL,
	intoMoney INT NOT NULL,
	PRIMARY KEY (idDetailBill,idBill)
)
GO
CREATE TABLE ImageProduct
(
	idImage NVARCHAR(255) NOT NULL,
	idProduct NVARCHAR(255) NOT NULL,
	URLImage TEXT NOT NULL,
	PRIMARY KEY (idImage)
)
GO
CREATE TABLE Permission
(
	idPermission NVARCHAR(255) NOT NULL,
	namePermission NVARCHAR(255) NOT NULL,
	[level] INT NOT NULL,
	PRIMARY KEY (idPermission)
)
GO
CREATE TABLE Product
(
	nameProduct NVARCHAR(255) NOT NULL,
	idProduct NVARCHAR(255) NOT NULL,
	sizeS INT NOT NULL,
	sizeM INT NOT NULL,
	sizeL INT NOT NULL,
	price FLOAT NOT NULL,
	[description] NTEXT NULL,
	idType NVARCHAR(255) NOT NULL,
	PRIMARY KEY (idProduct)
)
GO
CREATE TABLE [Types]
(
	idType NVARCHAR(255) NOT NULL,
	nameType NVARCHAR(255) NOT NULL,
	PRIMARY KEY (idType) 
)
GO
CREATE TABLE [User]
(
	idUser NVARCHAR(255) NOT NULL,
	idPermission NVARCHAR(255) NOT NULL,
	fullName NVARCHAR(MAX) NOT NULL,
	username NVARCHAR(255) NOT NULL,
	[password] NVARCHAR(255) NOT NULL,
	gender BIT NOT NULL,
	identityCard INT NOT NULL,
	[address] NTEXT NOT NULL,
	email NVARCHAR(255) NOT NULL,
	URLAvatar TEXT NULL,
	phone INT NOT NULL,
	PRIMARY KEY (idUser) 
)
GO
CREATE TABLE [Voucher]
(
	idVoucher NVARCHAR(255) NOT NULL,
	[percent] NVARCHAR(255) NOT NULL,
	dateStart DATETIME NOT NULL,
	dateEnd DATETIME NOT NULL,
	PRIMARY KEY (idVoucher) 
)
----------------------------------------- [TAO LIEN KET KHOA NGOAI] ------------------------------------------
GO
ALTER TABLE DetailBIll
ADD CONSTRAINT LK1
FOREIGN KEY (idBill)
REFERENCES	Bill(idBill)
GO
ALTER TABLE DetailBIll
ADD CONSTRAINT LK2
FOREIGN KEY (idProduct)
REFERENCES	Product(idProduct)
GO
ALTER TABLE Bill
ADD CONSTRAINT LK3
FOREIGN KEY (idUser)
REFERENCES	[User](idUser)
GO
ALTER TABLE [User]
ADD CONSTRAINT LK4
FOREIGN KEY (idPermission)
REFERENCES	Permission(idPermission)
GO
ALTER TABLE ImageProduct
ADD CONSTRAINT LK5
FOREIGN KEY (idProduct)
REFERENCES	Product(idProduct)
GO
ALTER TABLE Product
ADD CONSTRAINT LK6
FOREIGN KEY (idType)
REFERENCES	[Types](idType)
----------------------------------------- [NHAP DU LIEU] ------------------------------------------
GO
INSERT INTO Permission VALUES
	('P01', 'Admin', 1),
	('P02', 'User', 2);
GO
INSERT INTO [Types] VALUES
	('T01', 'Guitar'),
	('T02', 'Violin'),
	('T03', 'Piano'),
	('T04', 'Organ'),
	('T05', 'Harmonica'),
	('T06', 'Drum'),
	('T07', N'Phụ Kiện');
GO
INSERT INTO [User] VALUES
	('U01', 'P01', N'Đặng Chí Bảo', N'chibao', N'0000', 1, 00000000, N' TP HCM', N'chibao@gmaill.com', N'Not Update Avatar', 0123450000),
	('U02', 'P02', N'Nguyễn Tuấn Anh', N'tuananh', N'1111', 0, 11111111, N'Hà Nội', N'tuananh@gmaill.com', N'Not Update Avatar', 01234511111),
	('U03', 'P01', N'Nguyễn Thanh Phong', N'thanhphong', N'2222', 1, 22222222, N'Nhà Bè', N'thanhphong@gmaill.com', N'Not Update Avatar', 0123452222),
	('U04', 'P02', N'Nguyễn Văn A', N'vana', N'3333', 1, 33333333, N'Đồng Nai', N'nguyenvana@gmaill.com', N'Not Update Avatar', 0123453333),
	('U05', 'P02', N'Trần Thị B', N'thib', N'4444', 0, 44444444, N'Cà Mau', N'tranthib@gmaill.com', N'Not Update Avatar', 0123454444);

GO
INSERT INTO Product VALUES
-- GUITAR
	(N'Guitar Classic Yamaha C80', 'P01', 1, 2, 3, 220, N'Đàn Guitar', N'T01'),
	(N'Guitar Yamaha Silent SLG200N', 'P02', 1, 2, 3, 340, N'Đàn Guitar', N'T01'),
	(N'Guitar TAYLOR T5Z CLASSIC KOA', 'P03', 1, 2, 3, 117, N'Đàn Guitar', N'T01'),
	(N'Guitar Classic Cordoba C5-SP', 'P04', 1, 2, 3, 399, N'Đàn Guitar', N'T01'),
	(N'Guitar Electric Yamaha PAC012', 'P05', 1, 2, 3, 470, N'Đàn Guitar', N'T01'),
-- VIOLIN
	(N'Violin Omebo RV205', 'P06', 1, 2, 3, 125, N'Đàn Violin', 'T02'),
	(N'Violin Silent Yamaha SV-150', 'P07', 1, 2, 3, 320, N'Đàn Violin', 'T02'),
	(N'Violin Shifen SV', 'P08', 1, 2, 3, 599, N'Đàn Violin', 'T02'),
	(N'Violin Kapok MV182', 'P09', 1, 2, 3, 370, N'Đàn Violin', 'T02'),
	(N'Violin Yamaha YEV104 Electric', 'P10', 1, 2, 3, 480, N'Đàn Violin', 'T02'),
-- PIANO
	(N'Piano YAMAHA CFX', 'P11', 1, 2, 3, 720, N'Đàn Piano', 'T03'),
	(N'Piano Grand Piano Kawai SKEX', 'P12', 1, 2, 3, 899, N'Đàn Piano', 'T03'),
	(N'Piano GRAND PIANO ĐIỆN ROLAND GP-609', 'P13', 1, 2, 3, 375, N'Đàn Piano', 'T03'),
	(N'Piano Cơ Yamaha YUS5', 'P14', 1, 2, 3, 670, N'Đàn Piano', 'T03'),
	(N'Piano Cơ Upright Atlas A3C', 'P15', 1, 2, 3, 740, N'Đàn Piano', 'T03'),
-- ORGAN
	(N'Organ Yamaha Genos', 'P16', 1, 2, 3, 270, N'Đàn Organ', 'T04'),
	(N'Organ Roland AT 900C', 'P17', 1, 2, 3, 120, N'Đàn Organ', 'T04'),
	(N'Organ KURTZMAN K150', 'P18', 1, 2, 3, 499, N'Đàn Organ', 'T04'),
	(N'Organ CASIO CT-X700', 'P19', 1, 2, 3, 330, N'Đàn Organ', 'T04'),
	(N'Organ CASIOTONE CT-S1', 'P20', 1, 2, 3, 630, N'Đàn Organ', 'T04'),
-- HARMONICA
	(N'Harmonica Yamaha Chromatic SS-220', 'P21', 1, 2, 3, 420, N'Kèn Harmonica', 'T05'),
	(N'Harmonica Suzuki Mr 250c', 'P22', 1, 2, 3, 680, N'Kèn Harmonica', 'T05'),
	(N'Harmonica Fender Blues Deville', 'P23', 1, 2, 3, 599, N'Kèn Harmonica', 'T05'),
	(N'Harmonica Suzuki MR-200A', 'P24', 1, 2, 3, 550, N'Kèn Harmonica', 'T05'),
	(N'Harmonica Yamaha Pianica', 'P25', 1, 2, 3, 250, N'Kèn Harmonica', 'T05'),
-- DRUM
	(N'Drum Roland VAD706 V-Drums Acoustic Design', 'P26', 1, 2, 3, 620, N'Bộ trống', 'T06'),
	(N'Drum Yamaha Recording Custom, Surf Green', 'P27', 1, 2, 3, 165, N'Bộ trống', 'T06'),
	(N'Drum ROLAND SPD-30', 'P28', 1, 2, 3, 780, N'Bộ trống', 'T06'),
	(N'Drum Casio LD-80 Touch-Sensitive Digital', 'P29', 1, 2, 3, 520, N'Bộ trống', 'T06'),
	(N'Drum DTX10K-X', 'P30', 1, 2, 3, 690, N'Bộ trống', 'T06'),
-- PHU KIEN
	(N'Loa Marshall Woburn 3', 'P31', 1, 2, 3, 599, N'Phụ kiện', 'T07'),
	(N'MICRO THU ÂM RODE NT2-A', 'P32', 1, 2, 3, 200, N'Phụ kiện', 'T07'),
	(N'Elixir 16027', 'P33', 1, 2, 3, 290, N'Phụ kiện', 'T07'),
	(N'Jack Âm Thanh 6 Ly', 'P34', 1, 2, 3, 150, N'Phụ kiện', 'T07'),
	(N'Tuner ET-33', 'P35', 1, 2, 3, 450, N'Phụ kiện', 'T07'),
	(N'Gối đàn Violin KPE 510', 'P36', 1, 2, 3, 300, N'Phụ kiện', 'T07'),
	(N'CORDOBA CAPO 04039', 'P37', 1, 2, 3, 190, N'Phụ kiện', 'T07'),
	(N'Nhựa Thông Rosin 603', 'P38', 1, 2, 3, 100, N'Phụ kiện', 'T07'),
	(N'Boss GE-7 Phơ Guitar Solo', 'P39', 1, 2, 3, 590, N'Phụ kiện', 'T07'),
	(N'Guitar Pick (Tặng kèm)', 'P40', 1, 2, 3, 0, N'Phụ kiện', 'T07'),
	(N'Tai nghe kiểm âm Takstar HD2000', 'P41', 1, 2, 3, 280, N'Phụ kiện', 'T07'),
	(N'Card âm thanh Xonar U7', 'P42', 1, 2, 3, 770, N'Phụ kiện', 'T07'),
	(N'Bộ Dụng Cụ Vệ Sinh Dây Đàn', 'P43', 1, 2, 3, 275, N'Phụ kiện', 'T07'),
	(N'Dầu lau dây Jim Dunlop 6582', 'P44', 1, 2, 3, 110, N'Phụ kiện', 'T07'),
	(N'Nguồn Đàn Organ Yamaha PA-3C', 'P45', 1, 2, 3, 220, N'Phụ kiện', 'T07');
GO
INSERT INTO ImageProduct VALUES
-- GUITAR
	('I01', 'P01', N'/Images/guitar1a.jpg'),
	('I02', 'P02', N'/Images/guitar2a.jpg'),
	('I03', 'P03', N'/Images/guitar3a.jpg'),
	('I04', 'P04', N'/Images/guitar4a.jpg'),
	('I05', 'P05', N'/Images/guitar5a.jpg'),

	('I06', 'P01', N'/Images/guitar1b.jpg'),
	('I07', 'P02', N'/Images/guitar2b.jpg'),
	('I08', 'P03', N'/Images/guitar3b.jpg'),
	('I09', 'P04', N'/Images/guitar4b.jpg'),
	('I10', 'P05', N'/Images/guitar5b.jpg'),
-- VIOLIN
	('I11', 'P06', N'/Images/violin1a.jpg'),
	('I12', 'P07', N'/Images/violin2a.jpg'),
	('I13', 'P08', N'/Images/violin3a.jpg'),
	('I14', 'P09', N'/Images/violin4a.jpg'),
	('I15', 'P10', N'/Images/violin5a.jpg'),

	('I16', 'P06', N'/Images/violin1b.jpg'),
	('I17', 'P07', N'/Images/violin2b.jpg'),
	('I18', 'P08', N'/Images/violin3b.jpg'),
	('I19', 'P09', N'/Images/violin4b.jpg'),
	('I20', 'P10', N'/Images/violin5b.jpg'),
-- PIANO
	('I21', 'P11', N'/Images/piano1a.jpg'),
	('I22', 'P12', N'/Images/piano2a.jpg'),
	('I23', 'P13', N'/Images/piano3a.jpg'),
	('I24', 'P14', N'/Images/piano4a.jpg'),
	('I25', 'P15', N'/Images/piano5a.jpg'),

	('I26', 'P11', N'/Images/piano1b.jpg'),
	('I27', 'P12', N'/Images/piano2b.jpg'),
	('I28', 'P13', N'/Images/piano3b.jpg'),
	('I29', 'P14', N'/Images/piano4b.jpg'),
	('I30', 'P15', N'/Images/piano5b.jpg'),
-- ORGAN
	('I31', 'P16', N'/Images/organ1a.jpg'),
	('I32', 'P17', N'/Images/organ2a.jpg'),
	('I33', 'P18', N'/Images/organ3a.jpg'),
	('I34', 'P19', N'/Images/organ4a.jpg'),
	('I35', 'P20', N'/Images/organ5a.jpg'),

	('I36', 'P16', N'/Images/organ1b.jpg'),
	('I37', 'P17', N'/Images/organ2b.jpg'),
	('I38', 'P18', N'/Images/organ3b.jpg'),
	('I39', 'P19', N'/Images/organ4b.jpg'),
	('I40', 'P20', N'/Images/organ5b.jpg'),
-- HARMONICA
	('I41', 'P21', N'/Images/har1a.jpg'),
	('I42', 'P22', N'/Images/har2a.jpg'),
	('I43', 'P23', N'/Images/har3a.jpg'),
	('I44', 'P24', N'/Images/har4a.jpg'),
	('I45', 'P25', N'/Images/har5a.jpg'),

	('I46', 'P21', N'/Images/har1b.jpg'),
	('I47', 'P22', N'/Images/har2b.jpg'),
	('I48', 'P23', N'/Images/har3b.jpg'),
	('I49', 'P24', N'/Images/har4b.jpg'),
	('I50', 'P25', N'/Images/har5b.jpg'),
-- DRUM
	('I51', 'P26', N'/Images/drum1a.jpg'),
	('I52', 'P27', N'/Images/drum2a.jpg'),
	('I53', 'P28', N'/Images/drum3a.jpg'),
	('I54', 'P29', N'/Images/drum4a.jpg'),
	('I55', 'P30', N'/Images/drum5a.jpg'),

	('I56', 'P26', N'/Images/drum1b.jpg'),
	('I57', 'P27', N'/Images/drum2b.jpg'),
	('I58', 'P28', N'/Images/drum3b.jpg'),
	('I59', 'P29', N'/Images/drum4b.jpg'),
	('I60', 'P30', N'/Images/drum5b.jpg'),
-- PHU KIEN
	('I61', 'P31', N'/Images/phukien1a.jpg'),
	('I62', 'P32', N'/Images/phukien2a.jpg'),
	('I63', 'P33', N'/Images/phukien3a.jpg'),
	('I64', 'P34', N'/Images/phukien4a.jpg'),
	('I65', 'P35', N'/Images/phukien5a.jpg'),
	('I66', 'P36', N'/Images/phukien6a.jpg'),
	('I67', 'P37', N'/Images/phukien7a.jpg'),
	('I68', 'P38', N'/Images/phukien8a.jpg'),
	('I69', 'P39', N'/Images/phukien9a.jpg'),
	('I70', 'P40', N'/Images/phukien10a.jpg'),
	('I71', 'P41', N'/Images/phukien11a.jpg'),
	('I72', 'P42', N'/Images/phukien12a.jpg'),
	('I73', 'P43', N'/Images/phukien13a.jpg'),
	('I74', 'P44', N'/Images/phukien14a.jpg'),
	('I75', 'P45', N'/Images/phukien15a.jpg'),

	('I76', 'P31', N'/Images/phukien1b.jpg'),
	('I77', 'P32', N'/Images/phukien2b.jpg'),
	('I78', 'P33', N'/Images/phukien3b.jpg'),
	('I79', 'P34', N'/Images/phukien4b.jpg'),
	('I80', 'P35', N'/Images/phukien5b.jpg'),
	('I81', 'P36', N'/Images/phukien6b.jpg'),
	('I82', 'P37', N'/Images/phukien7b.jpg'),
	('I83', 'P38', N'/Images/phukien8b.jpg'),
	('I84', 'P39', N'/Images/phukien9b.jpg'),
	('I85', 'P40', N'/Images/phukien10b.jpg'),
	('I86', 'P41', N'/Images/phukien11b.jpg'),
	('I87', 'P42', N'/Images/phukien12b.jpg'),
	('I88', 'P43', N'/Images/phukien13b.jpg'),
	('I89', 'P44', N'/Images/phukien14b.jpg'),
	('I90', 'P45', N'/Images/phukien15b.jpg');
GO
INSERT INTO Bill VALUES
	('B01', N'U02', 0, 150, N'Tiền mặt', 1, CAST(N'2023-05-21T22:21:40.250' AS DateTime), 3, N'Nguyễn Tuấn Anh', N'tuananh@gmail.com', N'0123451111', N'Cầu chữ Y, Quận 8, TPHCM'),
	('B02', N'U03', 0, 250, N'Chuyển khoản', 0, CAST(N'2023-05-21T22:21:40.250' AS DateTime), 4, N'Nguyễn Thanh Phong', N'thanhphong@gmail.com', N'0123452222', N'Huyện Mộc Hóa, Tỉnh Long An'),
	('B03', N'U03', 0, 750, N'Ghi nợ', 0, CAST(N'2023-05-21T22:21:40.250' AS DateTime), 8, N'Nguyễn Thanh Phong', N'thanhphong@gmail.com', N'0123452222', N'Chợ Bến Thành, Quận 1, TP HCM'),
	('B04', N'U04', 0, 750, N'Trả góp', 1, CAST(N'2023-05-21T22:21:40.250' AS DateTime), 2, N'Nguyễn Văn A', N'nguyenvana@gmail.com', N'0123453333', N'Xã Bàu Sao, Tỉnh Đồng Nai'),
	('B05', N'U05', 0, 750, N'Khuyến mãi', 0, CAST(N'2023-05-21T22:21:40.250' AS DateTime), 5, N'Trần Thị B', N'tranthib@gmail.com', N'0123454444', N'Chợ nổi, tỉnh Cà Mau');
--GO
INSERT INTO DetailBIll VALUES
	(N'D01', N'P08', N'B01', 3, 150),
	(N'D02', N'P10', N'B02', 4, 250),
	(N'D03', N'P21', N'B03', 8, 750),
	(N'D04', N'P33', N'B04', 2, 350),
	(N'D05', N'P38', N'B05', 5, 280);

----------------------------------------- [TRA CUU DU LIEU] ------------------------------------------

SELECT * FROM Permission
SELECT * FROM [Types]
SELECT * FROM [User]
SELECT * FROM Product
SELECT * FROM ImageProduct
SELECT * FROM Bill
SELECT * FROM DetailBIll