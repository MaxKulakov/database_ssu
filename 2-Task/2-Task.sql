CREATE TABLE theme
(
ID_theme int IDENTITY(1,1) NOT NULL CONSTRAINT PK_ID_theme PRIMARY KEY,
Name_theme nvarchar(50)
);

CREATE TABLE post_theme
(
ID_post_theme int IDENTITY(1,1) NOT NULL CONSTRAINT PK_ID_post_theme PRIMARY KEY,
id_theme int,
id_post int
);

CREATE TABLE tag
(
ID_tag int IDENTITY(1,1) NOT NULL CONSTRAINT PK_ID_tag PRIMARY KEY,
Name_tag nvarchar(50)
);

CREATE TABLE post_tag
(
ID_post_tag int IDENTITY(1,1) NOT NULL CONSTRAINT PK_ID_post_tag PRIMARY KEY,
id_tag int,
id_post int
);

CREATE TABLE post
(
ID_post int IDENTITY(1,1) NOT NULL CONSTRAINT PK_ID_post PRIMARY KEY,
id_blogger int,
Name_post nvarchar(50),
content nvarchar(50),
date_post datetime,
views_post int
);

CREATE TABLE blogger
(
ID_blogger int IDENTITY(1,1) NOT NULL CONSTRAINT PK_ID_blogger PRIMARY KEY,
Name_blogger nvarchar(50),
date_of_birth datetime,
registration_date datetime,
language_blogger nvarchar(50)
);

CREATE TABLE comment
(
ID_comment int IDENTITY(1,1) NOT NULL CONSTRAINT PK_ID_comment PRIMARY KEY,
id_blogger int,
id_post int,
date_comment datetime
);

CREATE TABLE achievement_name
(
ID_achievement_name int IDENTITY(1,1) NOT NULL CONSTRAINT PK_ID_achievement_name PRIMARY KEY,
Name_achievement nvarchar(50)
);

CREATE TABLE achievement
(
ID_achievement int IDENTITY(1,1) NOT NULL CONSTRAINT PK_ID_achievement PRIMARY KEY,
id_achievement_name int,
id_blogger int
);

CREATE TABLE cause
(
ID_cause int IDENTITY(1,1) NOT NULL CONSTRAINT PK_ID_cause PRIMARY KEY,
Name_cause nvarchar(50)
);

CREATE TABLE moderator
(
ID_moderator int IDENTITY(1,1) NOT NULL CONSTRAINT PK_ID_moderator PRIMARY KEY,
id_blogger int,
position nvarchar(50)
);

CREATE TABLE actions_on_posts
(
ID_actions_on_posts int IDENTITY(1,1) NOT NULL CONSTRAINT PK_ID_actions_on_posts PRIMARY KEY,
id_post int,
id_moderator int,
id_cause int,
Name_action nvarchar(50),
date_actions_on_posts datetime
);

CREATE TABLE actions_on_comment
(
ID_actions_on_comment int IDENTITY(1,1) NOT NULL CONSTRAINT PK_ID_actions_on_comment PRIMARY KEY,
id_comment int,
id_moderator int,
id_cause int,
Name_action nvarchar(50),
date_actions_on_posts datetime
); 



ALTER TABLE post_theme ADD CONSTRAINT FK1
FOREIGN KEY(id_theme) REFERENCES theme(ID_theme)

ALTER TABLE post_theme ADD CONSTRAINT FK2
FOREIGN KEY(id_post) REFERENCES post(ID_post)

ALTER TABLE post_tag ADD CONSTRAINT FK3
FOREIGN KEY(id_tag) REFERENCES tag(ID_tag)

ALTER TABLE post_tag ADD CONSTRAINT FK4
FOREIGN KEY(id_post) REFERENCES post(ID_post)

ALTER TABLE post ADD CONSTRAINT FK5
FOREIGN KEY(id_blogger) REFERENCES blogger(ID_blogger)

ALTER TABLE comment ADD CONSTRAINT FK6
FOREIGN KEY(id_blogger) REFERENCES blogger(ID_blogger)

ALTER TABLE comment ADD CONSTRAINT FK7
FOREIGN KEY(id_post) REFERENCES post(ID_post)

ALTER TABLE achievement ADD CONSTRAINT FK8
FOREIGN KEY(id_blogger) REFERENCES blogger(ID_blogger)

ALTER TABLE achievement ADD CONSTRAINT FK9
FOREIGN KEY(id_achievement_name) REFERENCES achievement_name(ID_achievement_name)

ALTER TABLE moderator ADD CONSTRAINT FK10
FOREIGN KEY(id_blogger) REFERENCES blogger(ID_blogger)

ALTER TABLE actions_on_posts ADD CONSTRAINT FK11
FOREIGN KEY(id_moderator) REFERENCES moderator(ID_moderator)

ALTER TABLE actions_on_posts ADD CONSTRAINT FK12
FOREIGN KEY(id_post) REFERENCES post(ID_post)

ALTER TABLE actions_on_posts ADD CONSTRAINT FK13
FOREIGN KEY(id_cause) REFERENCES cause(ID_cause)

ALTER TABLE actions_on_comment ADD CONSTRAINT FK14
FOREIGN KEY(id_moderator) REFERENCES moderator(ID_moderator)

ALTER TABLE actions_on_comment ADD CONSTRAINT FK15
FOREIGN KEY(id_comment) REFERENCES comment(ID_comment)

ALTER TABLE actions_on_comment ADD CONSTRAINT FK16
FOREIGN KEY(id_cause) REFERENCES cause(ID_cause)

INSERT [dbo].[blogger]
VALUES  
   ('Иванов Иван', '2000-10-12', '2018-01-01', 'русский'),
   ('Кирилл Латанов', '1999-02-12', '2019-01-01', 'русский'),
   ('Виктор Краснов', '1999-18-05', '2020-01-01', 'русский')

select * from [dbo].[blogger]

delete from [dbo].[blogger] where [ID_blogger] = 2

select * from [dbo].[blogger]

INSERT [dbo].[cause]
VALUES  
   ('содержатся персональные данные'),
   ('содержит оскорбления, мат'),
   ('скрытая реклама'),
   ('избыток грамматических ошибок'),
   ('содержатся призывы к противозаконным действиям')

select * from [dbo].[cause]

delete from [dbo].[cause]

select * from [dbo].[cause]