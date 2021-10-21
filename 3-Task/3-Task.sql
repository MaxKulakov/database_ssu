--�1 �������� ��� ������, ������� �������� ������ ��� ����� ������ �� ������ �������� �����
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

--��� ��������� ���������� ���������� ����� ���� ������
SELECT * FROM [dbo].[comment] CROSS JOIN [dbo].[blogger];


--������ ������ �� ����� ������� ���������� � ������ ������� �� ������ (����� ������������ ������)
SELECT * FROM [dbo].[comment] CROSS APPLY [dbo].[blogger]
	WHERE [language_blogger] = '���';



----------------------------------------------------------------------------------------------------------
--#2���������� ��� ��������� ��������, �������� � ���������� ����������, ��� ������, ��� � ������� �������
SELECT  [id_blogger]   
FROM  [dbo].[post] 
INTERSECT 
SELECT  [id_blogger]   
FROM   [dbo].[comment] 


--���������� ��� ���������� ��������, ������������ ��������, ��������� ����� �� ��������� EXCEPT, �� ������������� � ����������� ���������� ������� �������.
SELECT  [id_blogger]   
FROM  [dbo].[post] 
EXCEPT
SELECT  [id_blogger]   
FROM   [dbo].[comment] 


--� �������������� ����� ���������� ���������� �������� ������, ������������� �������� �� ���������� � ����������
SELECT  [id_blogger]   
FROM  [dbo].[post] 
UNION
SELECT  [id_blogger]   
FROM   [dbo].[comment] 
ORDER BY [id_blogger] ; 

--������������� �������� ���������� � ����������
SELECT  [id_blogger]   
FROM  [dbo].[post] 
UNION   ALL
SELECT  [id_blogger]   
FROM   [dbo].[comment] 
ORDER BY [id_blogger] ;  



-----------------------------------------------------------
--�3 ������� id �����, ���� ����������� ���������� ������ 100
	SELECT DISTINCT [ID_post]
	FROM [dbo].[post] AS [views_post]
	WHERE 
	 EXISTS (SELECT [ID_post]
	 FROM [dbo].[post]
	 WHERE [views_post] > 100
	 AND [ID_post] = [views_post].[ID_post]);

--����������, ��������� �� ��������� ���������� ������ � �������� ��������.
SELECT  [ID_post], [Name_post]
FROM  [dbo].[post]
WHERE [Name_post] LIKE '�%';  

--����� ������ � id=1 � 4
	SELECT *
	FROM [dbo].[post]
	WHERE [ID_post] IN (4, 1);

--���������� �������� ��� ��������.
SELECT [id_blogger], [date_post], [views_post]
FROM [dbo].[post]
WHERE [views_post] BETWEEN 110 AND 150;



---------------------------------------------
--�4 ������� ��� ������� ����� ��������, �������� ����������� ���������� ����������
SELECT 
	[ID_post], [Name_post], [views_post],
	CASE
    WHEN [views_post]<100 THEN '������ 100'
    WHEN [views_post]<200 THEN '������ 200'
    ELSE '������ 200'
  END [views_post]
  FROM [dbo].[post]


---------------------------------------------------------------------------------------------------------
--#5������� SQL COALESCE ���������� ������ �����������, �� ���� ��-NULL �������� �� ������ � ����������
SELECT COALESCE (NULL, NULL, (SELECT [id_blogger]
   FROM [dbo].[comment]
   WHERE [ID_comment] = 9), 0)

 --����������� ��������� �� ������ ���� ������ � ������ ��� ������.
 SELECT CONVERT( nvarchar (10), [date_comment])
 FROM [dbo].[comment];

--����������� ��������� �� ������ ���� ������ � ������ ��� ������.
SELECT CAST( [date_comment] AS nvarchar)
FROM [dbo].[comment];

--����������, ����� �� ��������� ��������� ���� NULL.�������� �������� NULL ��������� ���������� ���������.
SELECT  ISNULL ([views_post], 1000) 
FROM [dbo].[post];

--���������� �������� NULL, ���� ��� ��������� ��������� �����.
SELECT NULLIF (DATEPART(yy, [date_of_birth]), 1999 )  
FROM [dbo].[blogger];

--���������� ������� �� ���������� ������� �� ������ ��������
SELECT [ID_comment], CHOOSE ( [ID_comment],  '�������', '�������', '�������', '�������', '�������', '�������', '�������', '�������', '�������', '�������' )  
FROM [dbo].[comment];

--���������� ���� �� ���� �������� � ����������� �� ����, ��������� ���������� ��������� �������� true ��� false.
SELECT [date_of_birth], IIF ( DATEPART(yy, [date_of_birth]) < 2000, 'old', 'not old' )  
From [dbo].[blogger] ;



--------------------------------------------
--#6 ������ �� ���� ������ �������� �� *
	UPDATE [dbo].[blogger]
	SET [Name_blogger] = REPLACE([Name_blogger], ' ', '*');

	SELECT *
    FROM [dbo].[blogger]
	
	UPDATE [dbo].[blogger]
	SET [Name_blogger] = REPLACE([Name_blogger], '*', ' ');

--����� �������� �� 2 �� 5
	SELECT [Name_blogger], SUBSTRING([Name_blogger], 2, 5) 
	FROM [dbo].[blogger];

--����� �������� � ������� ������ 4� �� *
	SELECT [Name_blogger], STUFF([Name_blogger], 1, 4, '****')
	FROM [dbo].[blogger]; 

--����������� � ������ ����� ����
	SELECT  STR(DATEPART(yy, [date_of_birth]), 5, 3)
	FROM [dbo].[blogger];

--���������� ������������� ��������, ��������������� ��������� ������, ��� ������� ������� �������� ���������.
	SELECT UNICODE ([Name_blogger]) 
	FROM [dbo].[blogger];

--���������� ���������� ��������� ����� �������������� �������� �������� �������� � ������� ������� ��������.
	SELECT LOWER ( [Name_blogger] ) 
	FROM [dbo].[blogger];

--���������� ���������� ���������, � ������� ������� ������� �������� ������������� � ������� �������� ��������
	SELECT UPPER ( [Name_blogger] ) 
	FROM [dbo].[blogger];


---------------------------------------------------------
--#7������� ���� �� ����
	SELECT DATEPART(dd, [date_of_birth])
	FROM [dbo].[blogger]
	WHERE [ID_blogger]  = 3;

--������� ��������� ��������� �������� number (����� ����� �� ������) � ��������� ��������� datepart �������� �������� date, � ����� ���������� ��� ���������� ��������.
	SELECT DATEADD(hh, 1, [date_comment])
	FROM [dbo].[comment];

--������� ���������� ���������� ������������ ������ (����� ����� �� ������), ��������� � ��������� datepart, �� ������ �������, ��������� � ���������� startdate � enddate.
	SELECT DATEDIFF(dd, [date_comment], '2021-12-05')
	FROM [dbo].[comment];

--���������� ������� ��������� ����� ������� ���� ������ � ���� �������� datetime ��� �������� �������� ����� ���� ������
	SELECT GETDATE();

-- ���� � ����� ����������, �� ������� ������� ��������� SQL Server. �������� �������� ����� ����������
	SELECT SYSDATETIMEOFFSET();



---------------------------------------------------------------------------
--#8 ������� ������������, ����������� � ������� ��� �������� �������
SELECT MIN(DATEPART(yy, [date_of_birth])) as min, 
MAX(DATEPART(yy, [date_of_birth])) AS max, AVG(DATEPART(yy, [date_of_birth])) as avg
FROM [dbo].[blogger];

--������� id ��������, � ������� ��� �������� ������ 1995
SELECT [ID_blogger], MIN(DATEPART(yy, [date_of_birth])) AS Experience   
FROM [dbo].[blogger] GROUP BY [ID_blogger]
HAVING MIN(DATEPART(yy, [date_of_birth])) > 1995
 