USE pubs;

UPDATE dbo.discounts
SET stor_id = 7896
WHERE discounttype = 'Initial Customer';
GO

DECLARE @highDiscount money
DECLARE @storeName varchar(55)
DECLARE @discountAmt money
DECLARE @totalNewDiscount money

SET @highDiscount = 10.50
SELECT @storeName = (SELECT stor_name FROM dbo.stores s JOIN dbo.discounts d ON s.stor_id = d.stor_id WHERE discount = @highDiscount)
SET @discountAmt = (SELECT @highDiscount * .10)
SET @totalNewDiscount = (SELECT SUM(@highDiscount + @discountAmt))

SELECT @storeName AS 'Store Name', @highDiscount AS 'High Discount', @discountAMT AS 'Discount Rate', @totalNewDiscount AS 'New Discount';