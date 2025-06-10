use GYM_MEMBERSHIP_SYSTEM;

-- 1. List all members
      SELECT * FROM Members;

-- 2. List all trainers
     SELECT * FROM Trainers;

-- 3. Get all membership types
    SELECT * FROM MembershipTypes;

-- 4. Show all active subscriptions
	SELECT * FROM Subscriptions WHERE Status = 'Active';

-- 5. Show all expired subscriptions
	SELECT * FROM Subscriptions WHERE Status = 'Expired';

-- 6. Find members who joined after Jan 1, 2024
	SELECT * FROM Members WHERE JoinDate > '2024-01-01';

-- 7. List members with emails ending in 'gmail.com'
	SELECT * FROM Members WHERE Email LIKE '%@gmail.com';

-- 8. Count total number of members
	SELECT COUNT(*) AS TotalMembers FROM Members;

-- 9. Count total number of trainers
	SELECT COUNT(*) AS TotalTrainers FROM Trainers;

-- 10. List members ordered by last name
	SELECT * FROM Members ORDER BY LastName ASC;

-- 11. Total revenue from payments
	SELECT SUM(Amount) AS TotalRevenue FROM Payments;

-- 12. Average payment amount
	SELECT AVG(Amount) AS AvgPayment FROM Payments;

-- 13. Highest payment made
	SELECT MAX(Amount) AS MaxPayment FROM Payments;

-- 14. Group payments by method
	SELECT PaymentMethod, COUNT(*) AS Count, SUM(Amount) AS Total FROM Payments GROUP BY PaymentMethod;

-- 15. Join members with their payments
	SELECT m.FirstName, m.LastName, p.Amount FROM Members m JOIN Payments p ON m.MemberID = p.MemberID;

-- 16. Join members with their subscriptions
	SELECT m.FirstName, s.StartDate, s.EndDate FROM Members m JOIN Subscriptions s ON m.MemberID = s.MemberID;

-- 17. Count attendance entries per member
	SELECT MemberID, COUNT(*) AS AttendanceDays FROM Attendance GROUP BY MemberID;

-- 18. List members with more than 5 attendances
	SELECT MemberID FROM Attendance GROUP BY MemberID HAVING COUNT(*) > 5;

-- 19. Show each trainer's assigned members
	SELECT TrainerID, COUNT(*) AS MemberCount FROM TrainerAssignments GROUP BY TrainerID;

-- 20. List members assigned to a trainer
   SELECT m.FirstName, m.LastName FROM Members m JOIN TrainerAssignments ta ON m.MemberID = ta.MemberID WHERE ta.TrainerID = 1;

-- 21. Members with highest total payments
     SELECT MemberID, SUM(Amount) AS TotalPaid FROM Payments GROUP BY MemberID ORDER BY TotalPaid DESC LIMIT 1;

-- 22. List subscriptions ending in current month
	SELECT * FROM Subscriptions WHERE MONTH(EndDate) = MONTH(CURDATE());

-- 23. List top 3 payment amounts
	SELECT DISTINCT Amount FROM Payments ORDER BY Amount DESC LIMIT 3;

-- 24. Members without any payments
	SELECT * FROM Members WHERE MemberID NOT IN (SELECT DISTINCT MemberID FROM Payments);

-- 25. Members who never attended
	SELECT * FROM Members WHERE MemberID NOT IN (SELECT DISTINCT MemberID FROM Attendance);

-- 26. Get monthly revenue
	SELECT MONTH(PaymentDate) AS Month, SUM(Amount) AS Revenue FROM Payments GROUP BY MONTH(PaymentDate);

-- 27. Update expired subscriptions
	UPDATE Subscriptions SET Status = 'Expired' WHERE EndDate < CURDATE();

-- 28. Delete inactive members
	DELETE FROM Members WHERE MemberID NOT IN (SELECT DISTINCT MemberID FROM Subscriptions);

-- 29. Add a new member
	INSERT INTO Members (MemberID, FirstName, LastName, Gender, DOB, JoinDate, Phone, Email) VALUES (101, 'John', 'Doe', 'M', '2000-01-01', CURDATE(), '9998887777', 'john.doe@example.com');

-- 30. Add a payment entry
	INSERT INTO Payments (PaymentID, MemberID, Amount, PaymentDate, PaymentMethod) VALUES (201, 101, 3000, CURDATE(), 'Credit Card');

-- 31. Count members by gender
	SELECT Gender, COUNT(*) AS Total FROM Members GROUP BY Gender;

-- 32. Total fee per membership type
	SELECT MembershipTypeID, SUM(Fee) FROM MembershipTypes GROUP BY MembershipTypeID;

-- 33. Most common payment method
	SELECT PaymentMethod, COUNT(*) AS Uses FROM Payments GROUP BY PaymentMethod ORDER BY Uses DESC LIMIT 1;

-- 34. Attendance records this month
    SELECT * FROM Attendance WHERE MONTH(Date) = MONTH(CURDATE());

-- 35. Member with most attendance
	SELECT MemberID, COUNT(*) AS Days FROM Attendance GROUP BY MemberID ORDER BY Days DESC LIMIT 1;

-- 36. Get member and trainer full info
	SELECT m.FirstName AS MemberName, t.FirstName AS TrainerName FROM Members m JOIN TrainerAssignments ta ON m.MemberID = ta.MemberID JOIN Trainers t ON ta.TrainerID = t.TrainerID;

-- 37. Members with subscriptions over 3 months
	SELECT s.MemberID FROM Subscriptions s JOIN MembershipTypes mt ON s.MembershipTypeID = mt.MembershipTypeID WHERE mt.DurationMonths > 3;

-- 38. Payments between 1000 and 2000
	SELECT * FROM Payments WHERE Amount BETWEEN 1000 AND 2000;

-- 39. Subscriptions expiring next month
	SELECT * FROM Subscriptions WHERE MONTH(EndDate) = MONTH(CURDATE()) + 1;

-- 40. Members joined in last 30 days
	SELECT * FROM Members WHERE JoinDate >= CURDATE() - INTERVAL 30 DAY;

-- 41. Change a member's phone number
	UPDATE Members SET Phone = '8887776666' WHERE MemberID = 101;

-- 42. Add new trainer
	INSERT INTO Trainers (TrainerID, FirstName, LastName, Specialty, HireDate) VALUES (3, 'Ravi', 'Singh', 'Strength', CURDATE());

-- 43. Members with birthday this month
	SELECT * FROM Members WHERE MONTH(DOB) = MONTH(CURDATE());

-- 44. Delete attendance of a member
	DELETE FROM Attendance WHERE MemberID = 101;

-- 45. Attendance summary per day
	SELECT Date, COUNT(*) AS TotalEntries FROM Attendance GROUP BY Date;

-- 46. Members whose subscription ends today
	SELECT * FROM Subscriptions WHERE EndDate = CURDATE();

-- 47. Trainer with most members assigned
	SELECT TrainerID, COUNT(*) AS MemberCount FROM TrainerAssignments GROUP BY TrainerID ORDER BY MemberCount DESC LIMIT 1;

-- 48. Most popular membership type
	SELECT MembershipTypeID, COUNT(*) AS SubCount FROM Subscriptions GROUP BY MembershipTypeID ORDER BY SubCount DESC LIMIT 1;

-- 49. Recent payments (last 7 days)
	SELECT * FROM Payments WHERE PaymentDate >= CURDATE() - INTERVAL 7 DAY;

-- 50. Rename 'Fee' column (example)
	ALTER TABLE MembershipTypes CHANGE Fee MembershipFee DECIMAL(10,2);

-- 51. Create a Stored Procedure to Get Member Info by ID
DELIMITER //
CREATE PROCEDURE GetMemberInfo(IN mem_id INT)
BEGIN
    SELECT * FROM Members WHERE MemberID = mem_id;
END //
DELIMITER ;

-- 52. Create a Trigger to Log Payment Insert
DELIMITER //
CREATE TRIGGER LogPaymentInsert
AFTER INSERT ON Payments
FOR EACH ROW
BEGIN
    INSERT INTO PaymentLogs (MemberID, Amount, LogDate)
    VALUES (NEW.MemberID, NEW.Amount, NOW());
END //
DELIMITER ;

-- 53. Create a View for Active Subscriptions
	CREATE VIEW ActiveSubscriptions AS
	SELECT * FROM Subscriptions WHERE Status = 'Active';

-- 54. Use a Transaction to Insert Payment and Update Subscription
	START TRANSACTION;
	INSERT INTO Payments (PaymentID, MemberID, Amount, PaymentDate, PaymentMethod)
	VALUES (202, 101, 3500, CURDATE(), 'Cash');
	UPDATE Subscriptions SET Status = 'Active' WHERE MemberID = 101;
	COMMIT;

-- 55. Create an Index on Member Email
	CREATE INDEX idx_email ON Members(Email);

-- 56. Use Cursor in a Stored Procedure
DELIMITER //
CREATE PROCEDURE ShowAllMembers()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE mem_id INT;
    DECLARE mem_name VARCHAR(100);
    DECLARE cur CURSOR FOR SELECT MemberID, FirstName FROM Members;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO mem_id, mem_name;
        IF done THEN
            LEAVE read_loop;
        END IF;
        SELECT mem_id, mem_name;
    END LOOP;
    CLOSE cur;
END //
DELIMITER ;

-- 57. Create a User Defined Function to Calculate Age
DELIMITER //
CREATE FUNCTION CalculateAge(dob DATE) RETURNS INT
DETERMINISTIC
BEGIN
    RETURN TIMESTAMPDIFF(YEAR, dob, CURDATE());
END //
DELIMITER ;
