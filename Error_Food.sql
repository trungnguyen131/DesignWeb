create database Error_food
go

use Error_food
go

-- table account
create table Account
(
	User_ varchar(50) primary key not null,
	Password_ char(20) not null,
	Email_ char(50) not null,
	Full_name nvarchar(50)
)
go

-- table food
create table Food
(
	ID_ int identity primary key not null,
	Name_ nvarchar(100) not null,
	IDCategory_ int not null,
	Price_ int not null

)
go

-- table FoodCategory
create table FoodCategory
(
	ID_ int identity primary key not null,
	Name_ nvarchar(100) not null,
)
go

alter table Food add constraint FK_F_IDCategory foreign key(IDCategory_) references FoodCategory(ID_)

create table OrderTable
(
	ID_ int identity primary key not null,
	Name_ nvarchar(100) not null,
	Status_ nvarchar(100),   -- có người || không có người   
)
go

-- table Bill
create table Bill
(
	ID_ int identity primary key not null,
	IDTable_ int not null,
	IDShip_ int null,
	BillDays_ varchar(10) not null default getdate(),
	Status_ int not null default 0,   -- 1 : thanh toán || 0 : chưa thanh toán 
)
go

alter table Bill add constraint FK_B_IDTable foreign key(IDTable_) references OrderTable(ID_)
alter table Bill add constraint FK_B_IDShip foreign key(IDShip_) references Ship_customer(ID_)



-- table BillInfo
create table BillInfo
(
	ID_ int identity primary key not null,
	IDBill_ int not null,
	IDFood_ int not null,
	count int not null default 0,
)
go

alter table BillInfo add constraint FK_BI_IDBill foreign key(IDBill_) references Bill(ID_)
alter table BillInfo add constraint FK_BI_IDFood foreign key(IDFood_) references Food(ID_)


-- table Ship_customer
create table Ship_customer
(
	ID_ int identity primary key not null,
	Name_ nvarchar(50) not null,
	Phone_ int not null,
	Address_ nvarchar(50)
)
go

-- Hóa đơn : tên món ăn, giá món ăn, số lượng, tổng tiền, ngày lập hóa đơn
-- Chuyển hàng cho khách : Tên khách, Số điện thoại, Địa chỉ và Hóa đơn
-- đặt bàn : tên món ăn, số lượng

select * from Food,FoodCategory where Food.IDCategory_ = FoodCategory.ID_ and FoodCategory.Name_ = N'Hải sản'
select * from FoodCategory

insert into Food values (N'Pepsi lớn','9','35000')

update FoodCategory set Name_ = N'Coca lớn' where ID_ = N'8'

select Food.Name_, count(Food.Name_) from Food group by Name_

alter table OrderTable add IDTable_ int

select NameFood_,count(*) from OrderTable group by NameFood_

create table TableuCount
(
	ID_ int identity primary key not null,
	Name_ nvarchar(100) not null,
)
go

insert into TableuCount values (N'11')

alter table OrderTable add constraint FK_OT_ID foreign key(IDTable_) references TableuCount(ID_)

alter table OrderTable drop column Status_

select * from OrderTable

delete OrderTable

select * from TableuCount

select NameFood_ as N'Tên món ăn', Count(NameFood_) as N'Số lượng', Sum(PriceFood_) as N'Tổng tiền món' from OrderTable,TableuCount where OrderTable.IDTable_ = TableuCount.ID_ and TableuCount.ID_ = '1' group by NameFood_

select Sum(PriceFood_) AS 'Tổng tiền' from OrderTable,TableuCount where OrderTable.IDTable_ = TableuCount.ID_ and TableuCount.ID_ = '1'