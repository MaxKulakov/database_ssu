create table New(
N nvarchar(50),
S real);

CREATE PROCEDURE Sum_1
   @id_blogger int
AS BEGIN
	declare @sum real, @id nvarchar (50);
	SELECT @sum = SUM([views_post]) FROM [dbo].[post] p
	where [id_blogger] = @id_blogger
	SELECT @id = [Name_blogger] FROM [dbo].[blogger]
	where [id_blogger] = @id_blogger
	insert into New values(@id, @sum);
END
go


CREATE PROCEDURE Sum_2
   AS
    DECLARE @id_blogger int
	DECLARE my_cur CURSOR FOR 
		SELECT DISTINCT [id_blogger] FROM  [dbo].[post]
   OPEN my_cur
   FETCH NEXT FROM my_cur INTO @id_blogger 
   WHILE @@FETCH_STATUS = 0
   BEGIN
       exec Sum_1 @id_blogger 
       FETCH NEXT FROM my_cur INTO @id_blogger 
   END
   CLOSE my_cur
   DEALLOCATE my_cur










create table New_(
N nvarchar(50),
S int);
go

CREATE PROCEDURE Sum_1_
   @id_blogger int
AS BEGIN
	declare @k int, @id nvarchar (50);
	SELECT @k = count (*) FROM [dbo].[comment]
	where [id_blogger] = @id_blogger
	SELECT @id = [Name_blogger] FROM [dbo].[blogger]
	where [id_blogger] = @id_blogger
	insert into New_ values(@id, @k);
	end
go


CREATE PROCEDURE Sum_2_
   AS
    DECLARE @id_blogger int
	DECLARE my_cur CURSOR FOR 
		SELECT DISTINCT [id_blogger] FROM  [dbo].[blogger]
   OPEN my_cur
   FETCH NEXT FROM my_cur INTO @id_blogger 
   WHILE @@FETCH_STATUS = 0
   BEGIN
       exec Sum_1_ @id_blogger 
       FETCH NEXT FROM my_cur INTO @id_blogger 
   END
   CLOSE my_cur
   DEALLOCATE my_cur
