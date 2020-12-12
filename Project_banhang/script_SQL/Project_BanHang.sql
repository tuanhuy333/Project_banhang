/*
CREATE DATABASE Project_BanHang;
USE Project_BanHang;
GO
*/
drop database Project_BanHang
CREATE TABLE [dbo].[Customer]
(
	[ID] int NOT NULL PRIMARY KEY,
	[username] VARCHAR(50) NOT NULL UNIQUE,
	[password] TEXT NOT NULL,
	[firstName] NVARCHAR(50) NOT NULL,
	[lastName] NVARCHAR(20) NOT NULL,
	[gender] BIT NOT NULL,
	[birthDate] VARCHAR(12),
	[address] NVARCHAR(60) NOT NULL,
	[joinDate] VARCHAR(12),
	[isNew] BIT NOT NULL,
)

CREATE TABLE [dbo].[Role]
(
	[ID] INT NOT NULL PRIMARY KEY,
	[Name] NVARCHAR(25) NOT NULL,
)

CREATE TABLE [dbo].[Employee]
(
	[ID] INT NOT NULL PRIMARY KEY,
	[username] VARCHAR(50) NOT NULL UNIQUE,
	[password] TEXT NOT NULL,
	[firstName] NVARCHAR(50) NOT NULL,
	[lastName] NVARCHAR(20) NOT NULL,
	[gender] BIT NOT NULL,
	[birthDate] VARCHAR(12),
	[address] TEXT NOT NULL,
	[joinDate] VARCHAR(11) NOT NULL,
	[Role_ID] INT NOT NULL 
)

CREATE TABLE [dbo].[Catalog]
(
	[ID] INT NOT NULL PRIMARY KEY,
	[Catalog_Name] NVARCHAR(25) NOT NULL,
)

CREATE TABLE [dbo].[Product]
(
	[ID] INT NOT NULL PRIMARY KEY,
	[Product_Name] TEXT NOT NULL,
	[Catalog_ID] INT,
	[Amount] INT NOT NULL, 
	[Price] int NOT NULL,
	[Img] varchar(255)
)

CREATE TABLE [dbo].[ProductDetail]
(
	[Product_ID] INT NOT NULL PRIMARY KEY,
	[Product_Detail] NVARCHAR(650) NOT NULL,
)

CREATE TABLE Combo
(
	[ID] INT NOT NULL PRIMARY KEY ,
	[Combo_Name] TEXT NOT NULL,
	[Product_List] TEXT NOT NULL,
	[startDate] VARCHAR(11) NOT NULL,
	[endDate] VARCHAR(11) NOT NULL,
	[totalMoney] int NOT NULL,
	[discount] VARCHAR(8) NOT NULL,
	[discountMoney] int NOT NULL
)

CREATE TABLE [dbo].[Storage]
(
	[Product_ID] INT PRIMARY KEY,
	[Amount] INT NOT NULL,
	[importDate] NVARCHAR(60) not null,
	[exportDate] NVARCHAR(60) not null
)	

CREATE TABLE [dbo].[Invoice]
(
	[ID] INT NOT NULL PRIMARY KEY,
	[Invoice_Name] NVARCHAR(45) NOT NULL,
	[Customer_ID] INT NOT NULL,
	[Shipper_ID] INT,
	[totalMoney] TEXT NOT NULL,
	[createdDate]NVARCHAR(60) not null,
	[customerAddress] NVARCHAR(60) NOT NULL,
	[shipDate] NVARCHAR(60) not null
)

CREATE TABLE [dbo].[InvoiceDetail]
(
	[Invoice_ID] INT NOT NULL,
	[Product_ID] INT NOT NULL,
	[Combo_ID] INT,
	[Amount] INT NOT NULL,
	[Price] int not null
)

GO
-- Insert (Dữ liệu máy tính, chuột, tai nghe, loa) được trích từ thegioididong.com / Dữ liệu bàn phím được trích từ gearvn.com
	-- Customer
	INSERT INTO [dbo].[Customer] VALUES(1, 'sieusaopolo15', 'Password1234', N'Huỳnh Tuấn', N'Đạt' , 1, '05/05/1999', N'267/16 Tùng Thiện Vương', '17/11/2020', 'true'),
									   (2, 'abcxyz', '123456', N'Nguyễn Văn', N'A' , 1, '01/01/1999', N'193 Hàm Tử', '18/11/2020', 'true'),
									   (3, 'hello', '123456', N'Nguyễn Văn', N'B' , 1, '01/01/1999', N'193 Hàm Tử', '18/11/2020', 'true')
	-- Role
	INSERT INTO [dbo].[Role] VALUES(1, 'admin'),
								   (2, 'employee'),
								   (3, 'Shipper')

	-- Employee
	INSERT INTO [dbo].[Employee] VALUES(1, 'NV_001', '123456', N'Nguyễn Văn', 'A', 1, '01/01/1999', N'193 Hàm Tử', '20/11/2015', 1),
									   (2, 'NV_002', '123456', N'Nguyễn Văn', 'B', 0, '02/01/1999', N'193 Hàm Tử', '20/11/2015', 2),
									   (3, 'NV_003', '123456', N'Nguyễn Văn', 'C', 0, '02/01/1999', N'193 Hàm Tử', '20/11/2015', 3)
	-- Catalog
	INSERT INTO [dbo].[Catalog] VALUES(1, 'Máy vi tính'),
									  (2, 'Bàn Phím'),
									  (3, 'Chuột'),
									  (4, 'Tai nghe'),
									  (5, 'Loa')
	-- Product
	INSERT INTO [dbo].[Product] VALUES(1, 'Laptop Acer Aspire 3 A315 56 36YS i3 1005G1 (NX.HS5SV.008)', 1, 10, 3690000,''),
									  (2, 'Laptop Asus Gaming Rog Strix G512 i7 10750H/144Hz (IAL001T)', 1, 5, 28990000,''),
									  (3, 'Bàn phím Newmen GM368', 2, 18,300000,''),
									  (4, 'Bàn phím E-Dra EK311', 2, 15, 300000,''),
									  (5, 'Chuột Gaming Zadez G151M Đen', 3, 15, 300000,''),
									  (6, 'Chuột không dây Zadez M353 Xám', 3, 10, 300000,''),
									  (7, 'Tai nghe Bluetooth True Wireless Mozard Air 3 Đen', 4, 10, 300000,''),
									  (8, 'Tai nghe Bluetooth True Wireless Jabra Elite Active 65T Xanh Cooper', 4, 5, 3790000,''),
									  (9, 'Loa Bluetooth LG Xboom Go PL7 Xanh Đen', 5, 8, 3390000,''),
									  (10, 'Loa Bluetooth JBL PULSE2BLKAS Đen',5, 6, 952000,'')
	-- Product Detail
	INSERT INTO [dbo].[ProductDetail] VALUES (1, N'CPU: Intel Core i3 Ice Lake, 1005G1, 1.20 GHz;' +
														   N'RAM: 8 GB, DDR4 (On board 4GB +1 khe 4GB), 2400 MHz;' + 
														   N'Ổ cứng: SSD 512 GB M.2 PCIe, Hỗ trợ khe cắm HDD SATA;' +
														   N'Màn hình: 15.6 inch, Full HD (1920 x 1080);' +
														   N'Card màn hình: Card đồ họa tích hợp, Intel UHD Graphics;' +
														   N'Cổng kết nối: 2 x USB 2.0, USB 3.1, HDMI, LAN (RJ45);' +
														   N'Hệ điều hành: Windows 10 Home SL;' +
														   N'Thiết kế: Vỏ nhựa, PIN liền;' +
														   N'Kích thước: Dày 19.9 mm, 1.7 kg'
											 ),
											 (2, N'CPU: Intel Core i7 Comet Lake, 10750H, 2.60 GHz;' +
														   N'RAM: 8 GB, DDR4 (2 khe), 2933 MHz;' + 
														   N'Ổ cứng: Hỗ trợ thêm 2 khe cắm SSD M.2 PCIe, SSD 512 GB M.2 PCIe;' +
														   N'Màn hình: 15.6 inch, Full HD (1920 x 1080), 144Hz;' +
														   N'Card màn hình: Card đồ họa rời, NVIDIA GeForce GTX 1650Ti 4GB;' +
														   N'Cổng kết nối: 3 x USB 3.2, HDMI, LAN (RJ45), USB Type-C;' +
														   N'Hệ điều hành: Windows 10 Home SL;' +
														   N'Thiết kế: Vỏ nhựa, PIN liền;' +
														   N'Kích thước: Dày 25.8 mm, 2.3 Kg'
											 ),
											 (3, N'Model: GM368;' +
														   N'Màu sắc: đen;' + 
														   N'Kiểu kết nối: bàn phím có dây, 160cm;' +
														   N'Kết nối: USB 2.0;' +
														   N'Phím chức năng: Standard;' +
														   N'Kích thước: Full size, 485x230x40mm;' +
														   N'Kiểu bàn phím: bàn phím cơ;' +
														   N'Trọng lượng: 1083g'
											 ),
											 (4, N'Model: EK311;' +
														   N'Loại bàn phím: Bàn phím cơ fullsize;' + 
														   N'Led: LED Rainbow siêu sáng;' +
														   N'Switch: Outmenu;' +
														   N'Kết nối: USB;' +
														   N'Kích thước: Full size, 485x230x40mm;' +
														   N'Chất liệu: kim loại'
											 ),
											 (5, N'Tương thích: Windows;' +
														   N'Độ phân giải: 1200 - 3200 DPI;' + 
														   N'Cách kết nối: Dây cắm USB;' +
														   N'Độ dài dây / Khoảng cách kết nối: Dây dài 158 cm;' +
														   N'Trọng lượng: 69g;' +
														   N'Thương hiệu của: Trung Quốc'
											 ),
											 (6, N'Tương thích: Windows;' +
														   N'Độ phân giải: 1200 - 3200 DPI;' + 
														   N'Cách kết nối: Dây cắm USB;' +
														   N'Độ dài dây / Khoảng cách kết nối: Dây dài 158 cm;' +
														   N'Trọng lượng: 69g;' +
														   N'Thương hiệu của: Trung Quốc'
											 ),
											 (7, N'Tương thích: Android, Windows, iOS (iPhone);' +
														   N'Cổng sạc: Type-C;' + 
														   N'Thời gian sử dụng: 4 giờ;' +
														   N'Thời gian sạc đầy: 2 giờ;' +
														   N'Kết nối cùng lúc: 1 thiết bị;' +
														   N'Hỗ trợ kết nối: 10m (Bluetooth 5.0);' +
														   N'Phím điều khiển: Nghe/nhận cuộc gọi, Phát/dừng chơi nhạc, Chuyển bài hát, Tăng/giảm âm lượng;' +
														   N'Thương hiệu: Thế Giới Di Động;' + 
														   N'Sản xuất tại: Trung Quốc'
											 ),
											 (8, N'Tương thích: Android, Windows, iOS (iPhone);' +
														   N'Cổng sạc: Micro USB;' + 
														   N'Thời gian sử dụng: 5 giờ;' +
														   N'Thời gian sạc đầy: 2 giờ;' +
														   N'Kết nối cùng lúc: 2 thiết bị;' +
														   N'Hỗ trợ kết nối: 10m (Bluetooth 5.0);' +
														   N'Thương hiệu: Đan Mạch;' + 
														   N'Sản xuất tại: Trung Quốc'
											 ),
											 (9, N'Loại loa: Loa bluetooth;' + -- 24
														   N'Tương thích: Android, Windows, iOS (iPhone);' + -- 44
														   N'Tổng công suất: 30W;' + -- 20
														   N'Thời gian sử dụng: dùng khoảng 24 giờ;' + -- 37
														   N'Thời gian sạc đầy: 5 giờ;' + -- 25
														   N'Công nghệ âm thanh: Meridian, Sound boost;' + -- 42
														   N'Kết nối không dây: Bluetooth;' + -- 29
														   N'Kết nối khác: AUX in;' + -- 21
														   N'Tiện ích: Kết nối không dây nhiều loa cùng lúc, Chống nước IPX5, Google Assistant;' + -- 83
														   N'Phím điều khiển: Bật/tắt bluetooth, Nút nguồn, Tăng/giảm âm lượng, Phát/dừng chơi nhạc;' + -- 93
														   N'Điều khiển bằng điện thoại: LG XBoom;' + -- 37
														   N'Kích thước: Dài 25 cm - Đường kính 10 cm - Nặng 1.46 kg;' + -- 56
														   N'Thương hiệu của: Hàn Quốc' -- 25
											 ),
											 (10, N'Loại loa: Loa bluetooth;' +
														   N'Tương thích: Android, Windows, iOS (iPhone);' +
														   N'Tổng công suất: 16W;' +
														   N'Thời gian sử dụng: dùng khoảng 10 giờ;' +
														   N'Công nghệ âm thanh: JBL Connect;' +
														   N'Kết nối không dây: Bluetooth 4.1;' +
														   N'Kết nối khác: Jack 3.5 mm;' + 
														   N'Tiện ích: Có micro đàm thoại, Bật trợ lý ảo trên điện thoại, Chống nước IPX7;' +
														   N'Phím điều khiển: Bật/tắt bluetooth, Nút nguồn, Tăng/giảm âm lượng, Phát/dừng chơi nhạc;' +
														   N'Điều khiển bằng điện thoại: LG XBoom;' +
														   N'Kích thước: Dài 19.5 cm - Đường kính 8 cm - Nặng 775 g;' +
														   N'Thương hiệu của: Mỹ;'
											 )
	-- Combo
	INSERT INTO [dbo].[Combo] VALUES(1, 'Giảm giá Giáng Sinh', '1;2;3;4', '19/12/2020', '1/1/2021', '100000000', '15%', '9000000') -- 15.580.000 - 2.337.000
	-- Storage
	INSERT INTO [dbo].[Storage] VALUES(1, 12, '19/11/2020', '19/11/2020'),
									  (2, 8, '19/11/2020', '19/11/2020'),
									  (3, 25, '19/11/2020', '19/11/2020'),
									  (4, 29, '19/11/2020', '19/11/2020'),
									  (5, 20, '19/11/2020', '19/11/2020'),
									  (6, 17, '19/11/2020', '19/11/2020'),
									  (7, 14, '19/11/2020', '19/11/2020'),
									  (8, 11, '19/11/2020', '19/11/2020'),
									  (9, 12, '19/11/2020', '19/11/2020'),
									  (10, 8, '19/11/2020', '19/11/2020')
-- end of inserts

/*
-- Enable Constraint
	-- Employee
	ALTER TABLE [dbo].[Employee] ADD CONSTRAINT FK_Role FOREIGN KEY(ID) REFERENCES [dbo].[Role] (ID);
	-- Product
	ALTER TABLE [dbo].[Product] ADD CONSTRAINT FK_Catalog FOREIGN KEY(Catalog_ID) REFERENCES [dbo].[Catalog] (ID);
	-- Product Detail
	ALTER TABLE [dbo].[ProductDetail] ADD CONSTRAINT FK_ProductDetail_Product FOREIGN KEY(Product_ID) REFERENCES [dbo].[Product] (ID);
	-- Storage
	ALTER TABLE [dbo].[Storage] ADD CONSTRAINT FK_Storage_Product FOREIGN KEY(Product_ID) REFERENCES [dbo].[Product] (ID);
	-- Invoice
	ALTER TABLE [dbo].[Invoice] ADD CONSTRAINT FK_Customer FOREIGN KEY(ID) REFERENCES [dbo].[Customer] (ID);
	ALTER TABLE [dbo].[Invoice] ADD CONSTRAINT FK_Shipper FOREIGN KEY(Shipper_ID) REFERENCES [dbo].[Employee] (ID);
	-- Combo
	ALTER TABLE [dbo].[InvoiceDetail] ADD CONSTRAINT FK_Invoice FOREIGN KEY(Invoice_ID) REFERENCES [dbo].[Invoice] (ID);
	ALTER TABLE [dbo].[InvoiceDetail] ADD CONSTRAINT FK_InvoiceDetail_Product FOREIGN KEY(Product_ID) REFERENCES [dbo].[Product] (ID);
	ALTER TABLE [dbo].[InvoiceDetail] ADD CONSTRAINT FK_Combo FOREIGN KEY(Combo_ID) REFERENCES [dbo].[Combo] (ID);
-- end of enable constraint
*/

/*
-- Drop Tables
	DROP TABLE [dbo].[Storage];
	DROP TABLE [dbo].[ProductDetail];
	DROP TABLE [dbo].[InvoiceDetail];
	DROP TABLE [dbo].[Combo];
	DROP TABLE [dbo].[Product];
	DROP TABLE [dbo].[Catalog];
	DROP TABLE [dbo].[Invoice];
	DROP TABLE [dbo].[Customer];
	DROP TABLE [dbo].[Employee];
	DROP TABLE [dbo].[Role];
-- end of delete table
*/