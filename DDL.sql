--------========== SQL PROJECT ===========------------

/*
*
* SQL Project: Library Management System
* Project By: Md Mamun
* Batch ID: ESAD-CS/PNTL-A/49/01
* Trainee ID: 1267055
*
*/

Create database Library_ManagementDB
ON
(
	Name = LibraryManagementData,
	Filename= 'D:\CORE COURSE C#.NET\SQL project\LibraryManagementData.mdf',
	Size=100MB,
	Maxsize=200MB,
	Filegrowth=5%

)
Log on
(
	Name = LibraryManagementLog,
	Filename= 'D:\CORE COURSE C#.NET\SQL project\LibraryManagementLog.ldf',
	Size=50MB,
	Maxsize=200MB,
	Filegrowth=10%
	
)
go
Use Library_ManagementDB
go
CREATE TABLE Publication
(
	publicationID INT PRIMARY KEY IDENTITY ,
	publicationName NVARCHAR (40) NOT NULL
)
GO

CREATE TABLE writer
(
	writerID INT PRIMARY KEY IDENTITY,
	writerName NVARCHAR (40) NOT NULL,
)
GO


CREATE TABLE category
(
	catagoryID INT PRIMARY KEY IDENTITY,
	catagoryName VARCHAR (40) NOT NULL
)
GO
CREATE TABLE BookDetails
(
	bookID INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	publicationID INT REFERENCES Publication (publicationID),
	writerID INT REFERENCES writer (writerID),
	catagoryID INT REFERENCES category (catagoryID),
	bName VARCHAR (50) NOT NULL,
	Noofcopysactual int,
	NoofcopysCurrent int
)
GO
select * from BookDetails
CREATE TABLE Gendertbl
(
	genderID INT PRIMARY KEY IDENTITY,
	gender VARCHAR(6) NOT NULL
)
GO 

CREATE TABLE designations
(
	designationID INT PRIMARY KEY IDENTITY(1000,1),
	designation VARCHAR(30) NOT NULL
)
GO

CREATE TABLE employees
(
	employeeID INT PRIMARY KEY IDENTITY(1001,1),
	firstName VARCHAR(50) NOT NULL,
	lastName VARCHAR(40) NOT NULL,
	genderID INT REFERENCES gendertbl (genderID) NOT NULL,
	designationID INT REFERENCES designations(designationID) NOT NULL,
	birthDate DATE NOT NULL,
	contactNo VARCHAR(15) NOT NULL,
	city VARCHAR(30) NOT NULL
)
GO

CREATE TABLE Members
(
	memberID INT PRIMARY KEY IDENTITY(10000,1),
	[Name] VARCHAR(50) NOT NULL,
	genderID INT REFERENCES gendertbl (genderID) NOT NULL,
	contactNo VARCHAR(15) NOT NULL,
	memberAddress VARCHAR(100),
	city VARCHAR(30),
	memberDate DATE NOT NULL
)
GO

CREATE table Tranjection
(
	tranjectionID INT PRIMARY KEY IDENTITY(10000001,1),
	memberID INT  REFERENCES Members (memberID),
	bookID INT  REFERENCES BookDetails (bookID),
	dateIssue DATE,
	backDate DATE,
)
GO


CREATE TABLE Fine
(
	fineID INT UNIQUE,
	tranjectionID int REFERENCES Tranjection (tranjectionID),
	fineAmount MONEY NOT NULL,
	PRIMARY KEY(tranjectionID,fineID),
	
)
GO
Create table CollectBook
(
	Bookid int identity primary key,
	Bookname Nvarchar (30) not null,
	price money not null,
	Quantity Int not null,
	Commission float,

)
go
create table Reservebook
(
id int primary key,
bookid int references collectbook(bookid),
Olquantity int not null,
lastcount date 

)
go
select * from CollectBook
go

-----------=====Insert Data======------


INSERT INTO Publication VALUES 
('Maa Publication'),
('ity Publication'),
('ABC Publications'),
('IFA Publications'),
('MAB Publications' ),
('Jharna Press'),
('Afjal BookDipo'),
('press World'),
('Bloom Publishing'),
('Heor Kothon'),
('Magic bookres'),
('Man worls'),
('BTC book'),
('Bangla Sahitto')
go
select * from Tranjection
go

go

INSERT INTO writer VALUES
('Kazi Nazrul Islam'),
('Humaiun Ahamed'),
('BEGUM Rokeya'),
('Nazrul Islam'),
('Kamal Ahamed'),
('Rabindro Nath Tagore'),
('Abdullah Muti'),
('Peary Chandra Mitra'),
('Micheal madhushudhan Datta'),
('Jasim Uddin'),
('Ahsan Habib'),
('Rabichandra'),
('Gris Chandra Sen'),
('Abu jafar Samsuddin'),
('Sufiya kamal'),
('Biamal Mitra')
go

INSERT INTO category VALUES 
('DRAMA'),
('LITERATURE'),
('PROGRAMING'),
('POIM'),
('STORY'),
('Science fiction'),
('Religion'),
('novel'),
('short story')
GO
INSERT INTO BookDetails VALUES
(1,2,2,'chandra gona',220,36),
(2,4,7,'Hazar Bochor Dhore',120,23),
(3,3,4,'Jahar lal',400,20),
(4,2,2,'Mina borue',231,85),
(6,6,3,'Srabon megher din',60,15 ),
(7,8,5,'roktakto Prantor',125,60),
(8,5,9,'Lal Nil Dipabali',651,23),
(9,15,5,'Komola Kanter ',176,60),
(10,11,6,'Rater Adhar',56,10),
(11,12,1,'Jibon Biniyog',70,15)

GO
select * from BookDetails
go
insert into Reservebook values
(8,2,50,'12/02/2020'),
(2,2,60,'15/05/2020'),
(3,1,80,'12/05/2019'),
(4,5,82,'20/08/2021'),
(5,3,102,'25/10/2018'),
(6,2,45,'15/06/2018'),
(7,3,86,'18/09/2020')
go





insert into  Members(Name,genderID,contactNo,city) values 
('abbas',1,'0198965574','lalbagh','dhaka')

go
----create view on employees

Create view Vemployees
As
Select e.firstName,e.birthDate,e.city,e.genderID,e.contactNo,e.lastName from employees e
go



----------create Index in gender table---------

Create Index IxGender
on Gendertbl (genderid)
go
----------Drpo Index
Drop Index IxGender on Gendertbl
go


----------Create clustred Index on Gendertbl---
Create clustered index Ix_Genders
On Gendertbl (genderID)
go


----Create Procedure to insert value
Create Proc SpTranjections
							@memberid int,
							@Bookid int,
							@issuedate varchar (20),
							@bdate varchar(20)
As 
insert into Tranjection (memberID,bookID,dateIssue,backDate)values
(@memberid,@Bookid,@issuedate,@bdate) from inserted
go
--Test
Exec SpTranjections 2,1,'15/02/2020','20/03/2019'
go

---------CREATE PROCEDURE TO INSERT DATA-----
Create Proc SpInsertINtoCollectbook				
			@name nvarchar (30),
			@price money,
			@Quantity int,
			@comission Float
	AS
	Begin
	Insert Into CollectBook values 
	(@name,@price,@Quantity,@comission)
	End
	Go

	Exec SpInsertINtoCollectbook 'GITANJALI',150,50,0.10
	Exec SpInsertINtoCollectbook 'MOHASOSAN',200,60,0.12
	Exec SpInsertINtoCollectbook 'SOMMABADI',140,60,0.15
	Exec SpInsertINtoCollectbook 'NAKSI KATHAR MATT',130,48,0.08
	Exec SpInsertINtoCollectbook 'MATIR KANNA',85,50,0.10
	Exec SpInsertINtoCollectbook 'AGNI BINA',100,55,0.12
	Exec SpInsertINtoCollectbook 'RUPOSI BANGLA',120,65,0.10
	Exec SpInsertINtoCollectbook 'Megnath Bodh',130,60,0.03
	Exec SpInsertINtoCollectbook 'UDDATTO PRIITHIBI',105,59,0.12
	Exec SpInsertINtoCollectbook 'CHARPOTRO',120,50,0.05
	Exec SpInsertINtoCollectbook 'Aparajito',140,79,0.06
	Exec SpInsertINtoCollectbook 'Ghare Bahire',134,87,0.20
	Exec SpInsertINtoCollectbook 'Sheser Kobita',578,78,0.10
	Exec SpInsertINtoCollectbook 'Debja',658,67,0.15
	go
	select * from CollectBook
------create procedure for delete data from disignation tble---
Create Proc SpDeletedesignations
			
			@DgID int
			
	AS
	Begin
	Delete From designations where designationID=@DgID
	End
	go

------- create procedure to insert data in fine tbl----
Create Proc SpFineinsrt			
			@fid int,
			@tranid int,
			@Amount int
		
	AS
	Begin
	Insert Into Fine values 
	(@fid,@tranid,@Amount)
	End
	Go

--------========= Inserting Data by Proc--------

exec SpFineinsrt 1,1,500.00
exec SpFineinsrt 2,5,550.00
exec SpFineinsrt 3,5,600.00
exec SpFineinsrt 4,5,600.00
exec SpFineinsrt 5,5,800.00
exec SpFineinsrt 6,6,680.00
exec SpFineinsrt 7,5,578.00
exec SpFineinsrt 8,5,577.00
exec SpFineinsrt 9,8,457.00
exec SpFineinsrt 10,8,750.00
exec SpFineinsrt 11,2,520.00
exec SpFineinsrt 12,4,450.00



----- Return value by store procedure from designations
Create proc 	@id int,
				@disig Nvarchar (20)
As
insert into designations (designationID,designation) values(@id,@disig)
select @id = IDENT_CURRENT('designations')
return @id
go


------Create function Collectbook table----

CREATE FUNCTION fnDiscountCalculate (@price money,@quantity int,@comissionpercent float)
Returns Money
as
Begin	
		Declare @comissinedprice money
		set @comissinedprice=@price*@quantity*@comissionpercent
		return @comissinedprice
End
go

--Test
Select dbo.fnDiscountCalculate (400.00,40,0.10) 'Comission'
go

-------Create Table Function on  collect book tbl

Create function Fncollectbooknetprice (@Book nvarchar (30))
Returns table
AS
Return
(
	select sum(price*Quantity)'total buy',
			sum(price*Quantity*Commission) 'Commission earn',
			sum(price*Quantity*(1-Commission)) 'Net Paid'
	
	from CollectBook
	where (Bookid)=@Book 
)
go

select * from dbo.Fncollectbooknetprice  (14)
go
select * from CollectBook
go

-----Create view to member and gender---

Create view VmembersGender
As
select m.Name,m.city,m.memberAddress,g.gender from Members M
join Gendertbl g on m.genderID=g.genderID
go


------Create insert trigger for membertbl inserted
Create trigger Trmember
on Members
for Insert 
as
Begin
		Declare @MId Int,
				@name varchar (20),
				@Gid int,
				@contracts varchar (20),
				@city Varchar,
				@date date
				
		select @MId=memberID,@name=Name,@Gid=genderID,@contracts=contactNo,
		@city=city,@date=memberDate from Inserted
		Update Members set city=@city where memberID=@MId
End

-------------create instead of trigger on view ---

CREATE TRIGGER TriVemployees
ON Vemployees
instead of insert
AS
BEGIN
		insert into employees( firstName,birthDate,city,contactNo) 
		select firstName,birthDate,city,contactNo  from inserted
END
GO

-------Create Instead of trigger with raise error-----

Create trigger TricheckBookDetails
On BookDetails
Instead Of Insert 
AS
Begin
		Declare @Bid int,
				@pid int,
				@book varchar(50),
				@NocA int,
				@c int
		select @Bid=bookID,@pid=publicationID,@book=bName,@NocA=NoofcopysCurrent from inserted
		select @c=count(Publicationid)from Publication 

        where publicationID=@pid and bookID =@Bid
		If @c>2
			Begin
					insert into BookDetails
					Select bookID,publicationID,bName from inserted
			End
		Else 
			begin
				Raiseerror('Prosssesing For Publication',10,1)
				Rollback transaction
			End
End
Go
------=====create trigger with rollback=====

CREATE TRIGGER Trimembers
	ON Members

	FOR INSERT,UPDATE,DELETE
AS
	PRINT 'You can''t modify this table!'
	ROLLBACK TRANSACTION
GO


----- view With with encrypt-----
Alter view Vemployees
With Encryption
AS
Select e.firstName,e.birthDate,e.city,e.genderID,e.contactNo,e.lastName from employees e
go
----------=======create view with option========
create view VFinewithoption
With Encryption,Schemabinding
AS
Select f.fineID,f.fineAmount,f.tranjectionID from dbo.Fine f
go
