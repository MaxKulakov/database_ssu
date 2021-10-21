--------------обычные представления
CREATE VIEW blogger_view  
AS   
SELECT *
FROM [dbo].[blogger]  
go

Select * from blogger_view 
go
--------------------------------------

CREATE VIEW blogger_view_2  
AS   
SELECT [Name_blogger],  [language_blogger], [Name_post], [content], [views_post]
FROM [dbo].[post] p   
JOIN [dbo].[blogger] AS b ON p.[id_blogger] = b.[ID_blogger];
go 

Select * from  blogger_view_2 
go
---------------------------------------

CREATE VIEW  blogger_view_3 
AS   
SELECT [Name_blogger],  [language_blogger], [Name_post], [content], [views_post], [date_comment]
FROM [dbo].[post] p   
JOIN [dbo].[blogger] AS b ON p.[id_blogger] = b.[ID_blogger]
join [dbo].[comment] as c on c.[id_post] = p.[ID_post]
go

Select * from blogger_view_3
go

--------------------представление с WITH CHECK OPTION

CREATE VIEW post_view
AS
SELECT [Name_post], [content], [views_post]
FROM [dbo].[post]  
WHERE [views_post] >= 100
WITH CHECK OPTION;
go 

Select * from post_view
go

---не добавляются данные, т.к. не удовлетворяют условию
insert into post_view
values
('Мое путешествие', 'Фото', 10)
go

--добавляются данные, т.к. удовлетворяют условию представления
insert into post_view
values
('Мое путешествие', 'Фото', 110)
go



--------------------индексированное представление
SET NUMERIC_ROUNDABORT OFF;
SET ANSI_PADDING, 
ANSI_WARNINGS,
CONCAT_NULL_YIELDS_NULL, 
ARITHABORT, 
QUOTED_IDENTIFIER, 
ANSI_NULLS ON;
go

CREATE VIEW post_view_new
   WITH SCHEMABINDING
   AS  
		SELECT [ID_post], [Name_blogger],  [language_blogger], [Name_post], [content], [views_post]
		FROM [dbo].[post] p   
		JOIN [dbo].[blogger] AS b ON p.[id_blogger] = b.[ID_blogger]
		WHERE b.[ID_blogger] BETWEEN 1 and 15
go

--стоимость поддерева без индекса 0,0073
Select * from post_view_new
go


CREATE UNIQUE CLUSTERED INDEX INDEX_views_post
   ON post_view_new (ID_post);
 go 

--стоимость поддерева с индексом 0,0032
Select * from post_view_new
  with (noexpand);

--даже на таком маленьком количестве строк видно, что поиск ускоряется в 2 раза