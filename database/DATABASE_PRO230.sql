/*=============================================================
    SMART RESTAURANT MANAGEMENT DATABASE V2
=============================================================*/

CREATE DATABASE QLNHAHANG_SmartRestaurant;
GO

USE QLNHAHANG_SmartRestaurant;
GO

-- 1. Tạo các bảng không phụ thuộc trước
CREATE TABLE Users (
    Username NVARCHAR(50) PRIMARY KEY,
    Password NVARCHAR(256) NOT NULL,
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) UNIQUE,
    Phone NVARCHAR(15),
    Role NVARCHAR(20) NOT NULL,
    IsActive BIT DEFAULT 1
);
GO

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    Phone NVARCHAR(15) UNIQUE NOT NULL,
    Password NVARCHAR(256) NOT NULL,
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) UNIQUE,
    Rank NVARCHAR(20) DEFAULT 'BRONZE',
    CreatedDate DATETIME DEFAULT GETDATE(),
    IsMember BIT DEFAULT 0,
	IsActive BIT DEFAULT 1
);
GO

CREATE TABLE Dishes (
    DishID INT PRIMARY KEY IDENTITY(1,1),
    DishName NVARCHAR(100) NOT NULL,
    Price FLOAT NOT NULL,
    Image NVARCHAR(255),
    Category NVARCHAR(50),
    IsAvailable BIT DEFAULT 1,
    IsActive BIT DEFAULT 1
);
GO

CREATE TABLE Ingredients (
    IngredientID INT PRIMARY KEY IDENTITY(1,1),
    IngredientName NVARCHAR(100) NOT NULL,
    Quantity FLOAT DEFAULT 0.0,
    Unit NVARCHAR(20) NOT NULL,
    MinQuantity FLOAT DEFAULT 0.0,
    IsActive BIT DEFAULT 1
);
GO

CREATE TABLE Menus (
    MenuID INT PRIMARY KEY IDENTITY(1,1),
    MenuName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(255)
);
GO

CREATE TABLE RestaurantTables (
    TableID INT PRIMARY KEY IDENTITY(1,1),
    TableName NVARCHAR(50) NOT NULL,
    Capacity INT,
    Position NVARCHAR(MAX),
    Status NVARCHAR(20) DEFAULT 'EMPTY',
    QRCode NVARCHAR(MAX),
    IsActive BIT DEFAULT 1
);
GO

-- 2. Tạo các bảng phụ thuộc
CREATE TABLE DishIngredients (
    DishID INT,
    IngredientID INT,
    RequiredQuantity FLOAT,
    PRIMARY KEY (DishID, IngredientID),
    FOREIGN KEY (DishID) REFERENCES Dishes(DishID),
    FOREIGN KEY (IngredientID) REFERENCES Ingredients(IngredientID)
);
GO

CREATE TABLE MenuDishes (
    MenuID INT,
    DishID INT,
    PRIMARY KEY (MenuID, DishID),
    FOREIGN KEY (MenuID) REFERENCES Menus(MenuID),
    FOREIGN KEY (DishID) REFERENCES Dishes(DishID)
);
GO

CREATE TABLE InventoryReceipts (
    ReceiptID INT PRIMARY KEY IDENTITY(1,1),
    ReceiptDate DATETIME DEFAULT GETDATE(),
    Username NVARCHAR(50),
    TotalAmount FLOAT DEFAULT 0.0,
    Type NVARCHAR(20) NOT NULL,
    FOREIGN KEY (Username) REFERENCES Users(Username)
);
GO

CREATE TABLE InventoryDetails (
    InventoryDetailID INT PRIMARY KEY IDENTITY(1,1),
    ReceiptID INT NOT NULL,
    IngredientID INT NOT NULL,
    Quantity FLOAT NOT NULL,
    Price FLOAT NOT NULL,
    FOREIGN KEY (ReceiptID) REFERENCES InventoryReceipts(ReceiptID),
    FOREIGN KEY (IngredientID) REFERENCES Ingredients(IngredientID)
);
GO

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    TableID INT,
    Username NVARCHAR(50),
    CustomerID INT,
    OrderDate DATETIME DEFAULT GETDATE(),
    TotalAmount FLOAT DEFAULT 0.0,
    Status NVARCHAR(20) DEFAULT 'UNPAID',
    FOREIGN KEY (TableID) REFERENCES RestaurantTables(TableID),
    FOREIGN KEY (Username) REFERENCES Users(Username),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
GO

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT NOT NULL,
    DishID INT NOT NULL,
    Quantity INT NOT NULL,
    Price FLOAT NOT NULL,
    Note NVARCHAR(255),
    ItemStatus NVARCHAR(20) DEFAULT 'PENDING',
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (DishID) REFERENCES Dishes(DishID)
);
GO

CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT,
    Username NVARCHAR(50),
    PaymentDate DATETIME DEFAULT GETDATE(),
    Amount FLOAT,
    PaymentMethod NVARCHAR(255),
    Status NVARCHAR(50) DEFAULT 'SUCCESS',
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (Username) REFERENCES Users(Username)
);
GO

CREATE TABLE Reservations (
    ReservationID INT PRIMARY KEY IDENTITY(1,1),
    CustomerName NVARCHAR(100) NOT NULL,
    Phone NVARCHAR(15) NOT NULL,
    ReservationTime DATETIME NOT NULL,
    GuestCount INT,
    TableID INT,
    Status NVARCHAR(20) DEFAULT 'PENDING',
    FOREIGN KEY (TableID) REFERENCES RestaurantTables(TableID)
);
GO

CREATE TABLE StockExports (
    ExportID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT,
    IngredientID INT,
    Quantity FLOAT,
    ExportDate DATETIME,
    Note NVARCHAR(MAX),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (IngredientID) REFERENCES Ingredients(IngredientID)
);
GO

INSERT INTO Users
(Username, Password, FullName, Email, Phone, Role, IsActive)
VALUES
('admin', '123456', N'Quản trị viên', 'admin@restaurant.com', '0900000001', 'ADMIN', 1),
('waiter01', '123456', N'Nguyễn Văn Phục Vụ', 'waiter01@restaurant.com', '0900000002', 'WAITER', 1),
('chef01', '123456', N'Trần Văn Đầu Bếp', 'chef01@restaurant.com', '0900000003', 'CHEF', 1),
('store01', '123456', N'Lê Văn Kho', 'store01@restaurant.com', '0900000004', 'STOREKEEPER', 1),
('cashier01', '123456', N'Phạm Văn Thu Ngân', 'cashier01@restaurant.com', '0900000005', 'CASHIER', 1);
GO

INSERT INTO Customers
(Phone, Password, FullName, Email, Rank, CreatedDate, IsMember)
VALUES
('0911111111', '123456', N'Nguyễn Văn An', 'an@gmail.com', 'BRONZE', GETDATE(), 0),
('0922222222', '123456', N'Trần Thị Bình', 'binh@gmail.com', 'SILVER', GETDATE(),1),
('0933333333', '123456', N'Lê Minh Cường', 'cuong@gmail.com', 'GOLD', GETDATE(), 1),
('0944444444', '123456', N'Phạm Thu Dung', 'dung@gmail.com', 'DIAMOND', GETDATE(), 1);
GO


ALTER TABLE Customers
ADD TotalSpent FLOAT DEFAULT 0;
ALTER TABLE Reservations
ADD Duration INT DEFAULT 120;
ALTER TABLE Reservations
ADD CustomerID INT NULL;
ALTER TABLE Reservations
ADD OrderID INT NULL;
ALTER TABLE Reservations
ADD DepositAmount FLOAT DEFAULT 0;

ALTER TABLE Reservations
ADD CONSTRAINT FK_Reservation_Customer
FOREIGN KEY (CustomerID)
REFERENCES Customers(CustomerID);

ALTER TABLE Reservations
ADD CONSTRAINT FK_Reservation_Order
FOREIGN KEY (OrderID)
REFERENCES Orders(OrderID);

ALTER TABLE Orders
ADD ReservationID INT NULL;

ALTER TABLE Orders
ADD CONSTRAINT FK_Orders_Reservations
FOREIGN KEY (ReservationID)
REFERENCES Reservations(ReservationID);

ALTER TABLE Customers
ADD RewardPoints INT DEFAULT 0;

ALTER TABLE RestaurantTables
ADD MergedWith INT NULL;

ALTER TABLE RestaurantTables
ADD CONSTRAINT FK_Table_Merged
FOREIGN KEY (MergedWith)
REFERENCES RestaurantTables(TableID);

INSERT INTO RestaurantTables
(TableName,Capacity,Position,Status,QRCode,IsActive,MergedWith)
VALUES

(N'Bàn 1',4,N'Tầng 1','EMPTY',NULL,1,NULL),
(N'Bàn 2',4,N'Tầng 1','EMPTY',NULL,1,NULL),
(N'Bàn 3',4,N'Tầng 1','EMPTY',NULL,1,NULL),
(N'Bàn 4',4,N'Tầng 1','EMPTY',NULL,1,NULL),
(N'Bàn 5',6,N'Tầng 1','EMPTY',NULL,1,NULL),

(N'Bàn 6',6,N'Tầng 1','EMPTY',NULL,1,NULL),
(N'Bàn 7',8,N'Tầng 1','EMPTY',NULL,1,NULL),
(N'Bàn 8',8,N'Tầng 1','EMPTY',NULL,1,NULL),

(N'Bàn VIP 1',10,N'VIP','EMPTY',NULL,1,NULL),
(N'Bàn VIP 2',10,N'VIP','EMPTY',NULL,1,NULL),

(N'Bàn 11',4,N'Tầng 2','EMPTY',NULL,1,NULL),
(N'Bàn 12',4,N'Tầng 2','EMPTY',NULL,1,NULL),
(N'Bàn 13',4,N'Tầng 2','EMPTY',NULL,1,NULL),
(N'Bàn 14',4,N'Tầng 2','EMPTY',NULL,1,NULL),

(N'Bàn 15',6,N'Tầng 2','EMPTY',NULL,1,NULL),
(N'Bàn 16',6,N'Tầng 2','EMPTY',NULL,1,NULL),

(N'Bàn Ngoài Trời 1',4,N'Sân vườn','EMPTY',NULL,1,NULL),
(N'Bàn Ngoài Trời 2',4,N'Sân vườn','EMPTY',NULL,1,NULL),

(N'Bàn Gia Đình 1',12,N'Phòng riêng','EMPTY',NULL,1,NULL),
(N'Bàn Gia Đình 2',12,N'Phòng riêng','EMPTY',NULL,1,NULL);

INSERT INTO Menus(MenuName,Description)
VALUES
(N'Thực đơn chính',
N'Thực đơn phục vụ hàng ngày');

/*==========================================================
=           INGREDIENTS
==========================================================*/

INSERT INTO Ingredients (IngredientName, Quantity, Unit, MinQuantity)
VALUES
(N'Thịt bò',50,N'kg',5),
(N'Thịt heo',50,N'kg',5),
(N'Ức gà',40,N'kg',5),
(N'Đùi gà',40,N'kg',5),
(N'Tôm sú',35,N'kg',5),
(N'Mực ống',30,N'kg',5),
(N'Cá hồi',25,N'kg',3),
(N'Cá diêu hồng',30,N'kg',3),
(N'Ghẹ',20,N'kg',2),
(N'Hàu',20,N'kg',2),

(N'Xúc xích',20,N'kg',2),
(N'Thịt xông khói',20,N'kg',2),

(N'Gạo',200,N'kg',20),
(N'Mì trứng',80,N'kg',10),
(N'Bún',80,N'kg',10),
(N'Bánh phở',80,N'kg',10),

(N'Trứng gà',500,N'quả',50),

(N'Khoai tây',80,N'kg',10),
(N'Cà rốt',60,N'kg',5),
(N'Bắp cải',50,N'kg',5),
(N'Xà lách',40,N'kg',5),
(N'Cà chua',50,N'kg',5),
(N'Dưa leo',40,N'kg',5),
(N'Ớt chuông đỏ',20,N'kg',2),
(N'Ớt chuông xanh',20,N'kg',2),
(N'Hành tây',40,N'kg',5),
(N'Hành lá',20,N'kg',2),
(N'Ngò rí',10,N'kg',1),
(N'Rau thơm',20,N'kg',2),

(N'Nấm kim châm',20,N'kg',2),
(N'Nấm đùi gà',20,N'kg',2),
(N'Nấm đông cô',20,N'kg',2),

(N'Tỏi',30,N'kg',3),
(N'Hành tím',30,N'kg',3),
(N'Gừng',20,N'kg',2),
(N'Sả',20,N'kg',2),
(N'Ớt hiểm',10,N'kg',1),

(N'Bơ lạt',15,N'kg',2),
(N'Phô mai Mozzarella',20,N'kg',2),
(N'Sữa tươi',100,N'lít',10),
(N'Kem tươi',40,N'lít',5),
(N'Sữa đặc',40,N'lon',5),

(N'Đường',100,N'kg',10),
(N'Muối',80,N'kg',10),
(N'Tiêu',20,N'kg',2),
(N'Nước mắm',100,N'lít',10),
(N'Nước tương',80,N'lít',10),
(N'Dầu ăn',200,N'lít',20),
(N'Dầu hào',60,N'lít',5),
(N'Sa tế',20,N'kg',2),
(N'Sốt BBQ',40,N'lít',5),
(N'Tương ớt',40,N'chai',5),
(N'Mayonnaise',30,N'chai',5),
(N'Mật ong',30,N'lít',3),

(N'Chanh',30,N'kg',3),
(N'Cam',30,N'kg',3),
(N'Đào hộp',100,N'hộp',10),
(N'Vải hộp',100,N'hộp',10),

(N'Cà phê hạt',30,N'kg',3),
(N'Trà đen',30,N'kg',3),
(N'Trà lài',30,N'kg',3),

(N'Syrup đào',30,N'chai',5),
(N'Syrup vải',30,N'chai',5),
(N'Syrup chanh',30,N'chai',5),

(N'Coca Cola',200,N'lon',20),
(N'Pepsi',200,N'lon',20),
(N'7Up',150,N'lon',20),
(N'Sting',150,N'lon',20),
(N'Red Bull',150,N'lon',20),
(N'Nước suối Lavie',300,N'chai',30),

(N'Đá viên',500,N'kg',50),
(N'Kem Vani',30,N'hộp',5),
(N'Kem Socola',30,N'hộp',5),
(N'Kem Dâu',30,N'hộp',5),
(N'Bột Flan',20,N'kg',2),
(N'Hạt É',15,N'kg',2),
(N'Nước cốt dừa',30,N'lít',3),
(N'Bột năng',20,N'kg',2),
(N'Rau câu',15,N'kg',2),
(N'Dưa hấu',30,N'kg',3),
(N'Thanh long',30,N'kg',3),
(N'Nho',20,N'kg',2),
(N'Táo',30,N'kg',3),
(N'Kiwi',20,N'kg',2);

/*==========================================================
=                     DISHES
==========================================================*/

INSERT INTO Dishes (DishName, Price, Image, Category)
VALUES

-- ================= KHAI VỊ =================
(N'Khoai tây chiên',49000,'khoaitay.jpg',N'Khai vị'),
(N'Khoai tây lắc phô mai',59000,'khoaitay_phomai.jpg',N'Khai vị'),
(N'Xúc xích nướng',69000,'xucxich.jpg',N'Khai vị'),
(N'Cánh gà chiên nước mắm',89000,'canhga_nm.jpg',N'Khai vị'),
(N'Cánh gà BBQ',95000,'canhga_bbq.jpg',N'Khai vị'),
(N'Gỏi bò bóp thấu',99000,'goibo.jpg','NKhai vị'),
(N'Gỏi hải sản',109000,'goihaisan.jpg',N'Khai vị'),
(N'Salad cá hồi',129000,'salad_salmon.jpg',N'Khai vị'),
(N'Salad Caesar',99000,'caesar.jpg',N'Khai vị'),
(N'Súp hải sản',69000,'sup_hs.jpg',N'Khai vị'),

-- ================= CƠM =================
(N'Cơm chiên hải sản',109000,'com_hs.jpg',N'Cơm'),
(N'Cơm chiên bò',99000,'com_bo.jpg',N'Cơm'),
(N'Cơm chiên gà',89000,'com_ga.jpg',N'Cơm'),
(N'Cơm bò lúc lắc',139000,'luc_lac.jpg',N'Cơm'),
(N'Cơm gà nướng',109000,'com_ga_nuong.jpg',N'Cơm'),
(N'Cơm sườn nướng',119000,'com_suon.jpg',N'Cơm'),
(N'Cơm cá hồi sốt teriyaki',169000,'com_salmon.jpg',N'Cơm'),
(N'Cơm chiên Dương Châu',99000,'duongchau.jpg',N'Cơm'),

-- ================= MÌ =================
(N'Mì xào bò',109000,'mi_bo.jpg',N'Mì'),
(N'Mì xào hải sản',119000,'mi_hs.jpg',N'Mì'),
(N'Mì Ý sốt bò bằm',129000,'spaghetti.jpg',N'Mì'),
(N'Mì Ý sốt kem',139000,'carbonara.jpg',N'Mì'),
(N'Mì Ý hải sản',149000,'spaghetti_hs.jpg',N'Mì'),

-- ================= PHỞ - BÚN =================
(N'Phở bò',89000,'pho_bo.jpg',N'Phở'),
(N'Phở gà',79000,'pho_ga.jpg',N'Phở'),
(N'Bún bò Huế',89000,'bunbo.jpg',N'Bún'),
(N'Bún hải sản',99000,'bunhs.jpg',N'Bún'),

-- ================= HẢI SẢN =================
(N'Tôm nướng bơ tỏi',189000,'tom_bt.jpg',N'Hải sản'),
(N'Tôm hấp',179000,'tom_hap.jpg',N'Hải sản'),
(N'Mực nướng sa tế',179000,'muc_satay.jpg',N'Hải sản'),
(N'Mực chiên giòn',169000,'muc_gion.jpg',N'Hải sản'),
(N'Cá hồi áp chảo',229000,'salmon.jpg',N'Hải sản'),
(N'Cá diêu hồng chiên xù',189000,'dieuhong.jpg',N'Hải sản'),
(N'Hàu nướng mỡ hành',149000,'hau.jpg',N'Hải sản'),
(N'Ghẹ hấp',299000,'ghehap.jpg',N'Hải sản'),

-- ================= BÒ =================
(N'Bò lúc lắc',179000,'boluclac.jpg',N'Bò'),
(N'Bò né',169000,'bone.jpg',N'Bò'),
(N'Bít tết bò Mỹ',289000,'steak.jpg',N'Bò'),
(N'Bò nướng BBQ',199000,'bbq_bo.jpg',N'Bò'),
(N'Bò sốt tiêu đen',189000,'pepper.jpg',N'Bò'),

-- ================= GÀ =================
(N'Gà nướng mật ong',159000,'ga_matong.jpg',N'Gà'),
(N'Gà chiên giòn',149000,'gachien.jpg',N'Gà'),
(N'Gà sốt cay Hàn Quốc',169000,'ga_hq.jpg',N'Gà'),
(N'Gà quay',189000,'gaquay.jpg',N'Gà'),

-- ================= LẨU =================
(N'Lẩu Thái',329000,'lauthai.jpg',N'Lẩu'),
(N'Lẩu Hải Sản',369000,'lauhs.jpg',N'Lẩu'),
(N'Lẩu Bò',349000,'laubo.jpg',N'Lẩu'),
(N'Lẩu Kim Chi',339000,'kimchi.jpg',N'Lẩu'),

-- ================= PIZZA =================
(N'Pizza Hải Sản',239000,'pizza_hs.jpg',N'Pizza'),
(N'Pizza Bò',229000,'pizza_bo.jpg',N'Pizza'),
(N'Pizza Xúc Xích',199000,'pizza_xx.jpg',N'Pizza'),
(N'Pizza Phô Mai',189000,'pizza_cheese.jpg',N'Pizza'),

-- ================= ĐỒ UỐNG =================
(N'Coca Cola',25000,'coca.jpg',N'Đồ uống'),
(N'Pepsi',25000,'pepsi.jpg',N'Đồ uống'),
(N'7Up',25000,'7up.jpg',N'Đồ uống'),
(N'Sting',25000,'sting.jpg',N'Đồ uống'),
(N'Red Bull',30000,'redbull.jpg',N'Đồ uống'),
(N'Nước suối',15000,'water.jpg',N'Đồ uống'),
(N'Trà đào',39000,'tradao.jpg',N'Đồ uống'),
(N'Trà vải',39000,'travai.jpg',N'Đồ uống'),
(N'Trà chanh',35000,'trachanh.jpg',N'Đồ uống'),
(N'Cà phê đen',35000,'cf_den.jpg',N'Đồ uống'),
(N'Cà phê sữa',39000,'cf_sua.jpg',N'Đồ uống'),
(N'Bạc xỉu',45000,'bacxiu.jpg',N'Đồ uống'),
(N'Cam ép',49000,'camep.jpg',N'Đồ uống'),
(N'Nước chanh',39000,'nuocchanh.jpg',N'Đồ uống'),

-- ================= TRÁNG MIỆNG =================
(N'Kem Vani',49000,'kemvani.jpg',N'Tráng miệng'),
(N'Kem Socola',49000,'kemsocola.jpg',N'Tráng miệng'),
(N'Kem Dâu',49000,'kemdau.jpg',N'Tráng miệng'),
(N'Flan',35000,'flan.jpg',N'Tráng miệng'),
(N'Rau câu',35000,'raucau.jpg',N'Tráng miệng'),
(N'Chè hạt é',39000,'chehate.jpg',N'Tráng miệng'),
(N'Trái cây thập cẩm',59000,'fruit.jpg',N'Tráng miệng');

/*==========================================================
=      DISH INGREDIENTS (1 -> 20)
==========================================================*/

-- 1 Khoai tây chiên
INSERT INTO DishIngredients VALUES (1,18,0.30);

-- 2 Khoai tây lắc phô mai
INSERT INTO DishIngredients VALUES (2,18,0.30);
INSERT INTO DishIngredients VALUES (2,39,0.05);

-- 3 Xúc xích nướng
INSERT INTO DishIngredients VALUES (3,11,0.25);
INSERT INTO DishIngredients VALUES (3,48,0.01);

-- 4 Cánh gà chiên nước mắm
INSERT INTO DishIngredients VALUES (4,4,0.35);
INSERT INTO DishIngredients VALUES (4,46,0.03);
INSERT INTO DishIngredients VALUES (4,33,0.01);
INSERT INTO DishIngredients VALUES (4,48,0.02);

-- 5 Cánh gà BBQ
INSERT INTO DishIngredients VALUES (5,4,0.35);
INSERT INTO DishIngredients VALUES (5,51,0.03);
INSERT INTO DishIngredients VALUES (5,48,0.02);

-- 6 Gỏi bò bóp thấu
INSERT INTO DishIngredients VALUES (6,1,0.20);
INSERT INTO DishIngredients VALUES (6,22,0.10);
INSERT INTO DishIngredients VALUES (6,23,0.05);
INSERT INTO DishIngredients VALUES (6,55,0.03);
INSERT INTO DishIngredients VALUES (6,43,0.01);

-- 7 Gỏi hải sản
INSERT INTO DishIngredients VALUES (7,5,0.15);
INSERT INTO DishIngredients VALUES (7,6,0.15);
INSERT INTO DishIngredients VALUES (7,21,0.10);
INSERT INTO DishIngredients VALUES (7,22,0.05);
INSERT INTO DishIngredients VALUES (7,55,0.03);

-- 8 Salad cá hồi
INSERT INTO DishIngredients VALUES (8,7,0.20);
INSERT INTO DishIngredients VALUES (8,21,0.10);
INSERT INTO DishIngredients VALUES (8,22,0.05);
INSERT INTO DishIngredients VALUES (8,53,0.02);

-- 9 Caesar Salad
INSERT INTO DishIngredients VALUES (9,3,0.15);
INSERT INTO DishIngredients VALUES (9,21,0.15);
INSERT INTO DishIngredients VALUES (9,53,0.03);

--10 Súp hải sản
INSERT INTO DishIngredients VALUES (10,5,0.10);
INSERT INTO DishIngredients VALUES (10,6,0.10);
INSERT INTO DishIngredients VALUES (10,17,1);
INSERT INTO DishIngredients VALUES (10,40,0.10);

-----------------------------------------------------------

--11 Cơm chiên hải sản
INSERT INTO DishIngredients VALUES (11,13,0.25);
INSERT INTO DishIngredients VALUES (11,5,0.10);
INSERT INTO DishIngredients VALUES (11,6,0.10);
INSERT INTO DishIngredients VALUES (11,17,1);

--12 Cơm chiên bò
INSERT INTO DishIngredients VALUES (12,13,0.25);
INSERT INTO DishIngredients VALUES (12,1,0.15);
INSERT INTO DishIngredients VALUES (12,17,1);

--13 Cơm chiên gà
INSERT INTO DishIngredients VALUES (13,13,0.25);
INSERT INTO DishIngredients VALUES (13,3,0.15);
INSERT INTO DishIngredients VALUES (13,17,1);

--14 Cơm bò lúc lắc
INSERT INTO DishIngredients VALUES (14,13,0.25);
INSERT INTO DishIngredients VALUES (14,1,0.25);
INSERT INTO DishIngredients VALUES (14,24,0.05);

--15 Cơm gà nướng
INSERT INTO DishIngredients VALUES (15,13,0.25);
INSERT INTO DishIngredients VALUES (15,3,0.25);
INSERT INTO DishIngredients VALUES (15,54,0.02);

--16 Cơm sườn nướng
INSERT INTO DishIngredients VALUES (16,13,0.25);
INSERT INTO DishIngredients VALUES (16,2,0.30);
INSERT INTO DishIngredients VALUES (16,51,0.03);

--17 Cơm cá hồi
INSERT INTO DishIngredients VALUES (17,13,0.25);
INSERT INTO DishIngredients VALUES (17,7,0.25);
INSERT INTO DishIngredients VALUES (17,47,0.02);

--18 Cơm chiên Dương Châu
INSERT INTO DishIngredients VALUES (18,13,0.25);
INSERT INTO DishIngredients VALUES (18,2,0.10);
INSERT INTO DishIngredients VALUES (18,11,0.05);
INSERT INTO DishIngredients VALUES (18,17,1);

-----------------------------------------------------------

--19 Mì xào bò
INSERT INTO DishIngredients VALUES (19,14,0.20);
INSERT INTO DishIngredients VALUES (19,1,0.20);
INSERT INTO DishIngredients VALUES (19,47,0.02);

--20 Mì xào hải sản
INSERT INTO DishIngredients VALUES (20,14,0.20);
INSERT INTO DishIngredients VALUES (20,5,0.10);
INSERT INTO DishIngredients VALUES (20,6,0.10);
INSERT INTO DishIngredients VALUES (20,47,0.02);

/*==========================================================
=      DISH INGREDIENTS (21 -> 40)
==========================================================*/

--21 Mì Ý sốt bò bằm
INSERT INTO DishIngredients VALUES (21,14,0.20);
INSERT INTO DishIngredients VALUES (21,1,0.15);
INSERT INTO DishIngredients VALUES (21,44,0.10);
INSERT INTO DishIngredients VALUES (21,39,0.03);

--22 Mì Ý sốt kem
INSERT INTO DishIngredients VALUES (22,14,0.20);
INSERT INTO DishIngredients VALUES (22,40,0.15);
INSERT INTO DishIngredients VALUES (22,39,0.03);
INSERT INTO DishIngredients VALUES (22,17,1);

--23 Mì Ý hải sản
INSERT INTO DishIngredients VALUES (23,14,0.20);
INSERT INTO DishIngredients VALUES (23,5,0.10);
INSERT INTO DishIngredients VALUES (23,6,0.10);
INSERT INTO DishIngredients VALUES (23,44,0.10);

------------------------------------------------------------

--24 Phở bò
INSERT INTO DishIngredients VALUES (24,15,0.20);
INSERT INTO DishIngredients VALUES (24,1,0.20);
INSERT INTO DishIngredients VALUES (24,17,1);
INSERT INTO DishIngredients VALUES (24,23,0.03);

--25 Phở gà
INSERT INTO DishIngredients VALUES (25,15,0.20);
INSERT INTO DishIngredients VALUES (25,3,0.20);
INSERT INTO DishIngredients VALUES (25,17,1);
INSERT INTO DishIngredients VALUES (25,23,0.03);

--26 Bún bò Huế
INSERT INTO DishIngredients VALUES (26,16,0.20);
INSERT INTO DishIngredients VALUES (26,1,0.18);
INSERT INTO DishIngredients VALUES (26,17,1);
INSERT INTO DishIngredients VALUES (26,45,0.05);

--27 Bún hải sản
INSERT INTO DishIngredients VALUES (27,16,0.20);
INSERT INTO DishIngredients VALUES (27,5,0.10);
INSERT INTO DishIngredients VALUES (27,6,0.10);
INSERT INTO DishIngredients VALUES (27,17,1);

------------------------------------------------------------

--28 Tôm nướng bơ tỏi
INSERT INTO DishIngredients VALUES (28,5,0.35);
INSERT INTO DishIngredients VALUES (28,37,0.03);
INSERT INTO DishIngredients VALUES (28,33,0.02);

--29 Tôm hấp
INSERT INTO DishIngredients VALUES (29,5,0.35);
INSERT INTO DishIngredients VALUES (29,17,1);

--30 Mực nướng sa tế
INSERT INTO DishIngredients VALUES (30,6,0.35);
INSERT INTO DishIngredients VALUES (30,45,0.03);

--31 Mực chiên giòn
INSERT INTO DishIngredients VALUES (31,6,0.35);
INSERT INTO DishIngredients VALUES (31,41,0.05);
INSERT INTO DishIngredients VALUES (31,17,1);

--32 Cá hồi áp chảo
INSERT INTO DishIngredients VALUES (32,7,0.35);
INSERT INTO DishIngredients VALUES (32,37,0.03);
INSERT INTO DishIngredients VALUES (32,48,0.01);

--33 Cá diêu hồng chiên xù
INSERT INTO DishIngredients VALUES (33,8,0.45);
INSERT INTO DishIngredients VALUES (33,41,0.05);

--34 Hàu nướng mỡ hành
INSERT INTO DishIngredients VALUES (34,9,0.40);
INSERT INTO DishIngredients VALUES (34,37,0.03);
INSERT INTO DishIngredients VALUES (34,23,0.02);

--35 Ghẹ hấp
INSERT INTO DishIngredients VALUES (35,10,0.60);
INSERT INTO DishIngredients VALUES (35,17,1);

------------------------------------------------------------

--36 Bò lúc lắc
INSERT INTO DishIngredients VALUES (36,1,0.30);
INSERT INTO DishIngredients VALUES (36,24,0.05);
INSERT INTO DishIngredients VALUES (36,47,0.02);

--37 Bò né
INSERT INTO DishIngredients VALUES (37,1,0.30);
INSERT INTO DishIngredients VALUES (37,17,1);
INSERT INTO DishIngredients VALUES (37,24,0.05);

--38 Bít tết bò Mỹ
INSERT INTO DishIngredients VALUES (38,1,0.35);
INSERT INTO DishIngredients VALUES (38,48,0.02);
INSERT INTO DishIngredients VALUES (38,37,0.03);

--39 Bò nướng BBQ
INSERT INTO DishIngredients VALUES (39,1,0.35);
INSERT INTO DishIngredients VALUES (39,51,0.03);

--40 Bò sốt tiêu đen
INSERT INTO DishIngredients VALUES (40,1,0.30);
INSERT INTO DishIngredients VALUES (40,48,0.02);
INSERT INTO DishIngredients VALUES (40,44,0.08);

/*==========================================================
=      DISH INGREDIENTS (41 -> 60)
==========================================================*/

--41 Gà nướng mật ong
INSERT INTO DishIngredients VALUES (41,3,0.35);
INSERT INTO DishIngredients VALUES (41,54,0.03);
INSERT INTO DishIngredients VALUES (41,33,0.01);

--42 Gà chiên giòn
INSERT INTO DishIngredients VALUES (42,3,0.35);
INSERT INTO DishIngredients VALUES (42,17,1);
INSERT INTO DishIngredients VALUES (42,48,0.02);

--43 Gà sốt cay Hàn Quốc
INSERT INTO DishIngredients VALUES (43,3,0.35);
INSERT INTO DishIngredients VALUES (43,45,0.03);
INSERT INTO DishIngredients VALUES (43,52,0.02);

--44 Gà quay
INSERT INTO DishIngredients VALUES (44,4,0.50);
INSERT INTO DishIngredients VALUES (44,33,0.02);
INSERT INTO DishIngredients VALUES (44,34,0.02);

------------------------------------------------------------

--45 Lẩu Thái
INSERT INTO DishIngredients VALUES (45,5,0.20);
INSERT INTO DishIngredients VALUES (45,6,0.20);
INSERT INTO DishIngredients VALUES (45,8,0.20);
INSERT INTO DishIngredients VALUES (45,30,0.10);
INSERT INTO DishIngredients VALUES (45,31,0.10);
INSERT INTO DishIngredients VALUES (45,32,0.10);

--46 Lẩu Hải Sản
INSERT INTO DishIngredients VALUES (46,5,0.20);
INSERT INTO DishIngredients VALUES (46,6,0.20);
INSERT INTO DishIngredients VALUES (46,9,0.20);
INSERT INTO DishIngredients VALUES (46,30,0.10);
INSERT INTO DishIngredients VALUES (46,31,0.10);

--47 Lẩu Bò
INSERT INTO DishIngredients VALUES (47,1,0.35);
INSERT INTO DishIngredients VALUES (47,30,0.10);
INSERT INTO DishIngredients VALUES (47,31,0.10);
INSERT INTO DishIngredients VALUES (47,32,0.10);

--48 Lẩu Kim Chi
INSERT INTO DishIngredients VALUES (48,2,0.20);
INSERT INTO DishIngredients VALUES (48,3,0.20);
INSERT INTO DishIngredients VALUES (48,30,0.10);
INSERT INTO DishIngredients VALUES (48,31,0.10);

------------------------------------------------------------

--49 Pizza Hải Sản
INSERT INTO DishIngredients VALUES (49,39,0.12);
INSERT INTO DishIngredients VALUES (49,5,0.15);
INSERT INTO DishIngredients VALUES (49,6,0.15);
INSERT INTO DishIngredients VALUES (49,44,0.08);

--50 Pizza Bò
INSERT INTO DishIngredients VALUES (50,39,0.12);
INSERT INTO DishIngredients VALUES (50,1,0.20);
INSERT INTO DishIngredients VALUES (50,44,0.08);

--51 Pizza Xúc Xích
INSERT INTO DishIngredients VALUES (51,39,0.12);
INSERT INTO DishIngredients VALUES (51,11,0.20);
INSERT INTO DishIngredients VALUES (51,44,0.08);

--52 Pizza Phô Mai
INSERT INTO DishIngredients VALUES (52,39,0.20);
INSERT INTO DishIngredients VALUES (52,44,0.08);

------------------------------------------------------------

--53 Coca Cola
INSERT INTO DishIngredients VALUES (53,65,1);

--54 Pepsi
INSERT INTO DishIngredients VALUES (54,66,1);

--55 7Up
INSERT INTO DishIngredients VALUES (55,67,1);

--56 Sting
INSERT INTO DishIngredients VALUES (56,68,1);

--57 Red Bull
INSERT INTO DishIngredients VALUES (57,69,1);

--58 Nước suối
INSERT INTO DishIngredients VALUES (58,70,1);

--59 Trà đào
INSERT INTO DishIngredients VALUES (59,60,0.02);
INSERT INTO DishIngredients VALUES (59,62,0.03);
INSERT INTO DishIngredients VALUES (59,57,0.20);
INSERT INTO DishIngredients VALUES (59,71,0.20);

--60 Trà vải
INSERT INTO DishIngredients VALUES (60,60,0.02);
INSERT INTO DishIngredients VALUES (60,63,0.03);
INSERT INTO DishIngredients VALUES (60,58,0.20);
INSERT INTO DishIngredients VALUES (60,71,0.20);

/*==========================================================
=      DISH INGREDIENTS (61 -> 71)
==========================================================*/

------------------------------------------------------------
--61 Trà chanh
------------------------------------------------------------
INSERT INTO DishIngredients VALUES (61,60,0.02);
INSERT INTO DishIngredients VALUES (61,55,0.05);
INSERT INTO DishIngredients VALUES (61,43,0.03);
INSERT INTO DishIngredients VALUES (61,71,0.20);
------------------------------------------------------------
--62 Cà phê đen
------------------------------------------------------------
INSERT INTO DishIngredients VALUES (62,59,0.03);
INSERT INTO DishIngredients VALUES (62,71,0.10);

------------------------------------------------------------
--63 Cà phê sữa
------------------------------------------------------------
INSERT INTO DishIngredients VALUES (63,59,0.03);
INSERT INTO DishIngredients VALUES (63,42,0.03);
INSERT INTO DishIngredients VALUES (63,71,0.10);

------------------------------------------------------------
--64 Bạc xỉu
------------------------------------------------------------
INSERT INTO DishIngredients VALUES (64,59,0.02);
INSERT INTO DishIngredients VALUES (64,42,0.05);
INSERT INTO DishIngredients VALUES (64,40,0.10);
INSERT INTO DishIngredients VALUES (64,71,0.10);

------------------------------------------------------------
--65 Cam ép
------------------------------------------------------------
INSERT INTO DishIngredients VALUES (65,56,0.30);
INSERT INTO DishIngredients VALUES (65,43,0.02);
INSERT INTO DishIngredients VALUES (65,71,0.20);

------------------------------------------------------------
--66 Nước chanh
------------------------------------------------------------
INSERT INTO DishIngredients VALUES (66,55,0.10);
INSERT INTO DishIngredients VALUES (66,43,0.03);
INSERT INTO DishIngredients VALUES (66,71,0.20);

------------------------------------------------------------
--67 Kem Vani
------------------------------------------------------------
INSERT INTO DishIngredients VALUES (67,72,1);

------------------------------------------------------------
--68 Kem Socola
------------------------------------------------------------
INSERT INTO DishIngredients VALUES (68,73,1);

------------------------------------------------------------
--69 Kem Dâu
------------------------------------------------------------
INSERT INTO DishIngredients VALUES (69,74,1);

------------------------------------------------------------
--70 Flan
------------------------------------------------------------
INSERT INTO DishIngredients VALUES (70,17,2);
INSERT INTO DishIngredients VALUES (70,40,0.15);
INSERT INTO DishIngredients VALUES (70,43,0.05);
INSERT INTO DishIngredients VALUES (70,75,0.03);

------------------------------------------------------------
--71 Rau câu
------------------------------------------------------------
INSERT INTO DishIngredients VALUES (71,79,0.03);
INSERT INTO DishIngredients VALUES (71,43,0.05);

------------------------------------------------------------
--72 Chè hạt é
------------------------------------------------------------
INSERT INTO DishIngredients VALUES (72,76,0.03);
INSERT INTO DishIngredients VALUES (72,43,0.05);
INSERT INTO DishIngredients VALUES (72,77,0.05);
INSERT INTO DishIngredients VALUES (72,71,0.20);

------------------------------------------------------------
--73 Trái cây thập cẩm
------------------------------------------------------------
INSERT INTO DishIngredients VALUES (73,56,0.10);
INSERT INTO DishIngredients VALUES (73,83,0.10);
INSERT INTO DishIngredients VALUES (73,82,0.10);
INSERT INTO DishIngredients VALUES (73,80,0.10);
INSERT INTO DishIngredients VALUES (73,81,0.10);
INSERT INTO DishIngredients VALUES (73,84,0.10);

SELECT * FROM DishIngredients
SELECT * FROM Dishes

GO
ALTER TABLE Users ADD Avatar NVARCHAR(255);
ALTER TABLE Customers ADD Avatar NVARCHAR(255);
GO
