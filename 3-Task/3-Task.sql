--№1 получает все записи, которые являются общими для обеих таблиц на основе внешнего ключа
SELECT *
FROM [dbo].[blogger] INNER JOIN [dbo].[comment]
	     ON [dbo].[blogger].[ID_blogger] = [dbo].[comment].[id_blogger]

SELECT *
FROM [dbo].[blogger] FULL OUTER JOIN [dbo].[comment]
	     ON [dbo].[blogger].[ID_blogger] = [dbo].[comment].[id_blogger]

SELECT *
FROM [dbo].[blogger] LEFT JOIN [dbo].[comment]
	     ON [dbo].[blogger].[ID_blogger] = [dbo].[comment].[id_blogger]

SELECT *
FROM [dbo].[blogger] RIGHT JOIN [dbo].[comment]
	     ON [dbo].[blogger].[ID_blogger] = [dbo].[comment].[id_blogger]


SELECT t1.[Name_blogger], t1.[date_of_birth], t1.[language_blogger]
    FROM [dbo].[blogger] t1 JOIN [dbo].[blogger] t2
        ON t1.[Name_blogger] = t2.[Name_blogger]
    WHERE t1.[ID_blogger] = t2.[ID_blogger];

--все возможные комбинации соединения строк двух таблиц
SELECT * FROM [dbo].[comment] CROSS JOIN [dbo].[blogger];


--каждая строка из левой таблицы сочетается с каждой строкой из правой (можно использовать фильтр)
SELECT * FROM [dbo].[comment] CROSS APPLY [dbo].[blogger]
	WHERE [language_blogger] = 'рус';



----------------------------------------------------------------------------------------------------------
--#2возвращает все различные значения, входящие в результаты выполнения, как левого, так и правого запроса
SELECT  [id_blogger]   
FROM  [dbo].[post] 
INTERSECT 
SELECT  [id_blogger]   
FROM   [dbo].[comment] 


--возвращает все уникальные значения, возвращенные запросом, указанным слева от оператора EXCEPT, но отсутствующие в результатах выполнения правого запроса.
SELECT  [id_blogger]   
FROM  [dbo].[post] 
EXCEPT
SELECT  [id_blogger]   
FROM   [dbo].[comment] 


--в результирующий набор включается содержимое столбцов таблиц, повторяющиеся значения не включаются в результаты
SELECT  [id_blogger]   
FROM  [dbo].[post] 
UNION
SELECT  [id_blogger]   
FROM   [dbo].[comment] 
ORDER BY [id_blogger] ; 

--повторяющиеся значения включаются в результаты
SELECT  [id_blogger]   
FROM  [dbo].[post] 
UNION   ALL
SELECT  [id_blogger]   
FROM   [dbo].[comment] 
ORDER BY [id_blogger] ;  



-----------------------------------------------------------
--№3 выведем id поста, если колиичество просмотров больше 100
	SELECT DISTINCT [ID_post]
	FROM [dbo].[post] AS [views_post]
	WHERE 
	 EXISTS (SELECT [ID_post]
	 FROM [dbo].[post]
	 WHERE [views_post] > 100
	 AND [ID_post] = [views_post].[ID_post]);

--Определяет, совпадает ли указанная символьная строка с заданным шаблоном.
SELECT  [ID_post], [Name_post]
FROM  [dbo].[post]
WHERE [Name_post] LIKE 'Н%';  

--вывод постов с id=1 и 4
	SELECT *
	FROM [dbo].[post]
	WHERE [ID_post] IN (4, 1);

--Определяет диапазон для проверки.
SELECT [id_blogger], [date_post], [views_post]
FROM [dbo].[post]
WHERE [views_post] BETWEEN 110 AND 150;



---------------------------------------------
--№4 выведем для каждого поста интервал, которому принадлежит количество просмотров
SELECT 
	[ID_post], [Name_post], [views_post],
	CASE
    WHEN [views_post]<100 THEN 'меньше 100'
    WHEN [views_post]<200 THEN 'меньше 200'
    ELSE 'больше 200'
  END [views_post]
  FROM [dbo].[post]


---------------------------------------------------------------------------------------------------------
--#5Функция SQL COALESCE возвращает первое определённое, то есть не-NULL значение из списка её аргументов
SELECT COALESCE (NULL, NULL, (SELECT [id_blogger]
   FROM [dbo].[comment]
   WHERE [ID_comment] = 9), 0)

 --преобразует выражение из одного типа данных в другой тип данных.
 SELECT CONVERT( nvarchar (10), [date_comment])
 FROM [dbo].[comment];

--преобразует выражение из одного типа данных в другой тип данных.
SELECT CAST( [date_comment] AS nvarchar)
FROM [dbo].[comment];

--Определяет, может ли указанное выражение быть NULL.Заменяет значение NULL указанным замещающим значением.
SELECT  ISNULL ([views_post], 1000) 
FROM [dbo].[post];

--Возвращает значение NULL, если два указанных выражения равны.
SELECT NULLIF (DATEPART(yy, [date_of_birth]), 1999 )  
FROM [dbo].[blogger];

--Возвращает элемент по указанному индексу из списка значений
SELECT [ID_comment], CHOOSE ( [ID_comment],  'младшая', 'средняя', 'младшая', 'средняя', 'младшая', 'средняя', 'младшая', 'средняя', 'младшая', 'средняя' )  
FROM [dbo].[comment];

--возвращает одно из двух значений в зависимости от того, принимает логическое выражение значение true или false.
SELECT [date_of_birth], IIF ( DATEPART(yy, [date_of_birth]) < 2000, 'old', 'not old' )  
From [dbo].[blogger] ;



--------------------------------------------
--#6 Замена во всех именах пробелов на *
	UPDATE [dbo].[blogger]
	SET [Name_blogger] = REPLACE([Name_blogger], ' ', '*');

	SELECT *
    FROM [dbo].[blogger]
	
	UPDATE [dbo].[blogger]
	SET [Name_blogger] = REPLACE([Name_blogger], '*', ' ');

--вывод символов от 2 до 5
	SELECT [Name_blogger], SUBSTRING([Name_blogger], 2, 5) 
	FROM [dbo].[blogger];

--вывод символов с заменой первых 4х на *
	SELECT [Name_blogger], STUFF([Name_blogger], 1, 4, '****')
	FROM [dbo].[blogger]; 

--преобразует в строку часть даты
	SELECT  STR(DATEPART(yy, [date_of_birth]), 5, 3)
	FROM [dbo].[blogger];

--Возвращает целочисленное значение, соответствующее стандарту Юникод, для первого символа входного выражения.
	SELECT UNICODE ([Name_blogger]) 
	FROM [dbo].[blogger];

--Возвращает символьное выражение после преобразования символов верхнего регистра в символы нижнего регистра.
	SELECT LOWER ( [Name_blogger] ) 
	FROM [dbo].[blogger];

--Возвращает символьное выражение, в котором символы нижнего регистра преобразованы в символы верхнего регистра
	SELECT UPPER ( [Name_blogger] ) 
	FROM [dbo].[blogger];


---------------------------------------------------------
--#7выводит день от даты
	SELECT DATEPART(dd, [date_of_birth])
	FROM [dbo].[blogger]
	WHERE [ID_blogger]  = 3;

--функция добавляет указанное значение number (целое число со знаком) к заданному аргументу datepart входного значения date, а затем возвращает это измененное значение.
	SELECT DATEADD(hh, 1, [date_comment])
	FROM [dbo].[comment];

--функция возвращает количество пересеченных границ (целое число со знаком), указанных в аргументе datepart, за период времени, указанный в аргументах startdate и enddate.
	SELECT DATEDIFF(dd, [date_comment], '2021-12-05')
	FROM [dbo].[comment];

--Возвращает текущую системную метку времени базы данных в виде значения datetime без смещения часового пояса базы данных
	SELECT GETDATE();

-- дату и время компьютера, на котором запущен экземпляр SQL Server. Смещение часового пояса включается
	SELECT SYSDATETIMEOFFSET();



---------------------------------------------------------------------------
--#8 выведем максимальный, минимальный и средний год рождения блогера
SELECT MIN(DATEPART(yy, [date_of_birth])) as min, 
MAX(DATEPART(yy, [date_of_birth])) AS max, AVG(DATEPART(yy, [date_of_birth])) as avg
FROM [dbo].[blogger];

--выведем id блогеров, у которых год рождения больше 1995
SELECT [ID_blogger], MIN(DATEPART(yy, [date_of_birth])) AS Experience   
FROM [dbo].[blogger] GROUP BY [ID_blogger]
HAVING MIN(DATEPART(yy, [date_of_birth])) > 1995
 