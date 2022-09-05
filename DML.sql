--------========== SQL PROJECT ===========------------

/*
*
* SQL Project: Library Management System
* Project By: Md Mamun
* Batch ID: ESAD-CS/PNTL-A/49/01
* Trainee ID: 1267055
*
*/
use Library_ManagementDB
go
EXEC SP_HELPDB Library_ManagementDB
GO
--------------Sub Query=============


select b.Bookid,b.Bookname,b.Commission,b.price,b.Quantity from CollectBook b
where b.price=(select distinct b.price from CollectBook where b.Commission>=0.05  )
go




-----=========Create join 
select b.bName,b.Noofcopysactual,c.catagoryName,w.writerName,p.publicationName  from BookDetails B
Join category c on b.catagoryID=c.catagoryID
left join writer w on b.writerID = w.writerID
join Publication p on b.publicationID=p.publicationID

go




---------Join with subquery

select b.bookID,b.bName,p.publicationName,sum(p.publicationID) 'Total published',w.writerName,c.catagoryName ,(select count(bookID)from BookDetails)'Total Book'
from BookDetails b
join Publication p on b.publicationID=p.publicationID
join writer w on w.writerID=b.writerID
join category c on c.catagoryID=b.catagoryID
group by b.bookID ,b.bName,p.publicationName,w.writerName,c.catagoryName
order by b.bookID ASC
go


---------====Agregiate function====

select	sum	(price)	'total tk',
		max (quantity) 'More',
		min (Quantity) 'much',
		AVG	(Commission)'Revenue'

from CollectBook



-------- number of total fine-----
select count (f.fineID) 'Number of Fine',sum (f.fineAmount) 'Total Amount' from Fine f
Where tranjectionID>= 10
go


-------Test view on employees===
select * from Vemployees
go



--------Test view on VmembersGender
select * from VmembersGender
go



----- view With with encrypt-----
select * from Vemployees
go



---------=======create view with option========
drop table VFinewithoption
go


-----======Test trigger with rollback=====

EXEC sp_helptext Trimembers
GO

-----====Test  Instead of trigger with raise error-----
EXEC sp_helptext TricheckBookDetails
GO


-------------test instead of trigger on view ---
EXEC sp_helptext TriVemployees
GO

-----Testinsert trigger for membertbl inserted
EXEC sp_helptext Trmember
GO


------Alter table 
ALTER TABLE employees
ADD Email varchar(25)
go


------ Delete table -----
delete from employees where employeeID=2
go
