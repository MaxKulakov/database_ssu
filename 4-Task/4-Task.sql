CREATE TABLE theme_4
(
ID_theme int,
Name_theme nvarchar(50)
);

CREATE TABLE blogger_4
(
ID_blogger int,
Name_blogger nvarchar(50),
date_of_birth datetime,
registration_date datetime,
language_blogger nvarchar(50)
);

declare @n int = 0;
declare @num int;
declare @tmp int;
while (@n < 100000)
begin
set @tmp = round(rand() * 25, 0);
set @n = @n + 1;
insert into blogger_4
values(@n, char(65 + @tmp), null, null, char(65 + @tmp + @tmp))
end


declare @n int = 0;
declare @num int;
declare @tmp int;
while (@n < 100000)
begin
set @tmp = round(rand() * 25, 0);
set @n = @n + 1;
insert into theme_4
values(@n, char(65 + @tmp))
end

--1
select *from theme_4
where ID_theme = 1000

CREATE CLUSTERED INDEX CL_Index
ON theme_4(ID_theme);

--2
SELECT [ID_blogger], [Name_blogger]
	FROM [dbo].[blogger_4]
	WHERE [ID_blogger] BETWEEN 1 AND 212
	AND [Name_blogger] != 'à';

CREATE INDEX index_1
on  [dbo].[blogger_4]([ID_blogger], [Name_blogger]);


---3
SELECT [Name_blogger], [date_of_birth], [registration_date], [language_blogger]
FROM [dbo].[blogger_4]
WHERE [ID_blogger] = 92000;


CREATE INDEX index_2
ON [dbo].[blogger_4]([ID_blogger])
INCLUDE ([Name_blogger], [date_of_birth], [registration_date], [language_blogger])

--4
SELECT [Name_blogger] 
FROM  [dbo].[blogger_4]
WHERE [ID_blogger] = 2000;


CREATE UNIQUE INDEX Unique_Index_3
ON [dbo].[blogger_4]([ID_blogger])
INCLUDE ([Name_blogger])


--5
SELECT [language_blogger]
FROM [dbo].[blogger_4]
WHERE [Name_blogger] = 'f';


CREATE INDEX Index_4
ON [dbo].[blogger_4]([Name_blogger])
INCLUDE ([language_blogger]);


--6
SELECT [ID_blogger], [Name_blogger] 
FROM [dbo].[blogger_4]
WHERE [Name_blogger] = 'M'


CREATE INDEX Index_5
ON [dbo].[blogger_4]([Name_blogger])
INCLUDE ([ID_blogger])
WHERE [Name_blogger] = 'M'
