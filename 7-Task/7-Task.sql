--1
--подсчет суммы комментариев к посту
CREATE PROCEDURE Sum_com  @id_post int, @sum  INT OUTPUT
AS
SELECT @sum = count (*) FROM [dbo].[comment]
WHERE [id_post] = @id_post
go

declare @sum int
exec Sum_com  9, @sum output
print @sum
go

select * from [dbo].[comment]
 go

--2
--—оздадим процедуру, вывод€щую имена поста и блогеров, записи которых получили количество просмотров в некотором диапазоне
CREATE PROCEDURE Blogger_views @first int, @last int
AS BEGIN
	if (@last < @first) begin
		print N'¬ерхн€€ грань просмотров не может быть меньше нижней.';
		return;
	end
	else begin
		declare @n int;
		set @n = @first;
		while (@n <= @last) begin
			select p.[id_blogger], [Name_post] from [dbo].[post] p join [dbo].[blogger] b on b.[ID_blogger] = p.[id_blogger]
				where [views_post] = @n;
			set @n = @n + 1;
		end
	end
END


exec Blogger_views 18, 20
go

--3
--выведем количество комментариев дл€ заданного поста
CREATE PROCEDURE Check_com @post INT = NULL
AS begin
	if @post is null begin
		print N'¬ы не ввели ID поста';
		return;
	end
	IF ((SELECT count(*) FROM [dbo].[comment] WHERE [id_post] = @post) > 0)
	begin
		declare @count int;
		select @count = count(*) FROM [dbo].[comment] WHERE [id_post] = @post
		select distinct @post as ID_post, @count as comment from [dbo].[comment]
	end
	ELSE 
	print N'” этого поста нет комментариев'
end

exec Check_com 
exec Check_com 25
exec Check_com 8

select * from [dbo].[comment]
go

--4
--выводит блогеров, которые получили наибольшее количество просмотров
CREATE PROCEDURE Max_views
AS 
BEGIN
	DECLARE @max INT;
	SELECT @max = MAX([views_post]) 
		FROM [dbo].[post]

	SELECT b.[id_blogger], [Name_blogger], [views_post] from [dbo].[blogger] b
	join [dbo].[post] p on p.[id_blogger] = b.[ID_blogger]
	where [views_post] = @max

END 
      
exec Max_views


--5
--вспомогательна€ процедура дл€ курсора, считает среднее количество просмотров, т.е. все просмотры/кол-во постов
CREATE PROCEDURE totalExpensesSum
   @id_blogger int
AS BEGIN
	declare @sum real, @k int;
	SELECT @sum = SUM([views_post]) FROM [dbo].[post] p
	where [id_blogger] = @id_blogger
	SELECT @k = count(*) FROM [dbo].[post] p
	where [id_blogger] = @id_blogger
	select @sum/@k as Sum_agv;
END
go

exec totalExpensesSum 4
go

--процедура с курсором, дл€ каждого блогера, имеющего комментарий, считаетс€ среднее кол-во просмотров
CREATE PROCEDURE MiddleViws
   AS
    DECLARE @id_blogger int
	DECLARE my_cur CURSOR FOR 
		SELECT DISTINCT [id_blogger] FROM [dbo].[comment]   
   OPEN my_cur
   FETCH NEXT FROM my_cur INTO @id_blogger 
   WHILE @@FETCH_STATUS = 0
   BEGIN
       exec totalExpensesSum @id_blogger 
       FETCH NEXT FROM my_cur INTO @id_blogger 
   END
   CLOSE my_cur
   DEALLOCATE my_cur



exec MiddleViws