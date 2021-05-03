CREATE TABLE testTable (name nvarchar(50), createdDate datetime);
insert into testTable (name, createdDate)
Values (NULL,'20160101 20:36:12'),
('ADAM','20160101 20:38:27'),
('Zbyszek','20160101 20:39:02'),
('ADAM','20160101 20:41:55'),
('ADAM','20160101 20:42:31'),
('ADAM','20160101 20:51:11'),
('ADAM','20160101 20:51:24'),
(NULL,'20160101 20:52:01'),
('Zbyszek','20160101 20:53:07'),
('Zbyszek','20160101 20:53:44'),
('Renata','20160101 20:54:52'),
(NULL,'20160101 20:54:57'),
('Zygmunt','20160101 20:54:59'),
(NULL,'20160101 20:55:03'),
(NULL,'20160101 20:56:12'),
('Renata','20160101 20:57:22'),
('Zygmunt','20160101 20:58:31'),
('Zygmunt','20160101 20:59:41'),
('Zygmunt','20160101 21:02:02'),
('Zygmunt','20160101 21:03:59'),
('ADAM','20160101 21:42:31'),
('ADAM','20160101 21:51:11'),
('ADAM','20160101 21:51:24');

DELETE FROM testTable where name IS NULL
ALTER TABLE testTable ADD Id int identity(1,1)

SELECT * FROM testTable
CREATE TABLE rozw(name varchar(50), ilosc int, minDate datetime, maxDate datetime)
DECLARE @counter INT, @idFirst INT, @idLast INT, @flag BIT, @name varchar(50), @minDate datetime, @maxDate datetime, @maxId int
SET @counter = 1
SET @flag = 0
SET @maxId = (SELECT MAX(Id) FROM testTable)
WHILE (@counter <= @maxId)
BEGIN 
	IF ((SELECT name FROM testTable WHERE Id = @counter) = (SELECT name AS Y FROM testTable WHERE Id = @counter+1) AND @flag = 0)
	BEGIN
		SELECT Id FROM testTable WHERE Id = @counter
		SET @idFirst = @counter
		SET @flag = 1 
	END
	ELSE IF((@counter = @maxId) OR ((SELECT name FROM testTable WHERE Id = @counter) <> (SELECT name AS Y FROM testTable WHERE Id = @counter+1)) AND @flag = 1)
	BEGIN
		SET @flag = 0
		SET @idLast = @counter
		SET @name = (SELECT name FROM testTable WHERE Id = @idLast)
		SET @minDate = (SELECT createdDate FROM testTable WHERE Id = @idFirst)
		SET @maxDate = (SELECT createdDate FROM testTable WHERE Id = @idLast)
		INSERT INTO rozw(name, ilosc, minDate, maxDate) VALUES (@name, @idLast - @idFirst+1, @minDate, @maxDate)
	END
	print @flag
	SET @counter = @counter + 1
END
SELECT * FROM rozw