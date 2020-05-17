BEGIN TRAN

	INSERT INTO Employees (
		LastName,
		FirstName,
		BirthDate,
		Title,
		HomePhone)
	VALUES (
		'Halpert',
		'Jim',
		'4/02/1971',
		'Sales',
		'330-555-5555');

		IF @@ERROR <> 0
			BEGIN
				ROLLBACK TRAN
			END

	DECLARE @currDate datetime
	SET @currDate = CONVERT(datetime, GETDATE())

	UPDATE	Employees
	SET		HireDate = @currDate
	WHERE LastName = 'Halpert' AND FirstName = 'Jim'

	IF @@ERROR <> 0
		BEGIN
			ROLLBACK TRAN
	END

COMMIT
GO