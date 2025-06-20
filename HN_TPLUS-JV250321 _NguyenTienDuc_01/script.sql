CREATE SCHEMA `script`;
USE `script`;
CREATE TABLE `course`
(
    `course_id`        VARCHAR(10),
    `course_name` VARCHAR(150) ,
    `category`     VARCHAR(255) ,
    `start_date`   DATE,
    `end_date` DATE,
    `fee` DECIMAL(10,2),
    PRIMARY KEY (course_id)
);

CREATE TABLE `student`
(
    `student_id` VARCHAR(10),
    `full_name`  VARCHAR(150) NOT NULL,
   `email` VARCHAR(255) UNIQUE,
    `phone` VARCHAR(15) UNIQUE,
    `dob` DATE,
    PRIMARY KEY (student_id)
);

CREATE TABLE `enrollment`
(
    `enrollment_id`   INT AUTO_INCREMENT,
    `student_id` VARCHAR(10) NOT NULL,
    CONSTRAINT `fk_se_student` FOREIGN KEY (`student_id`)
        REFERENCES `student` (student_id) ON DELETE CASCADE,
    `course_id`    VARCHAR(10) NOT NULL ,
    CONSTRAINT `fk_ce_course` FOREIGN KEY (`course_id`)
        REFERENCES `course` (course_id) ON DELETE CASCADE,
    `enroll_date`    DATE NOT NULL,
    `enrollment_status` ENUM('Confirmed','Cancelled','Pending'),
    PRIMARY KEY (enrollment_id)
);

CREATE TABLE `Payment`
(
    `payment_id`   INT AUTO_INCREMENT,
    `enrollment_id` INT NOT NULL,
    CONSTRAINT `fk_ep_payment` FOREIGN KEY (`enrollment_id`)
        REFERENCES `enrollment`(enrollment_id) ON DELETE CASCADE,
    `payment_method`    ENUM('Credit Card','Bank Transfer','Cash','E-wallet') ,
    `payment_amount` FLOAT,
    `payment_date`    DATE NOT NULL,
    `payment_status` ENUM('Success','Failed','Pending'),
    PRIMARY KEY (payment_id)
);
-- Thêm cột gender có kiểu dữ liệu là enum với các giá trị 'Nam', 'Nữ', 'Khác' trong bảng student.
ALTER TABLE student
ADD COLUMN  `gender` ENUM ('Nam','Nữ','Khác');
-- Thêm cột slot_count trong bảng Enrollment có kiểu dữ liệu là integer, có rằng buộc NOT NULL và giá trị mặc định là 1
ALTER TABLE enrollment
ADD COLUMN  `slot_count` INT NOT NULL DEFAULT 1;
-- Thêm rằng buộc cho cột payment_amount trong bảng Payment phải có giá trị lớn hơn 0 và có kiểu dữ liệu là DECIMAL(10, 2).
ALTER TABLE payment 
MODIFY `payment_amount` DECIMAL(10,2), ADD CONSTRAINT `check_payment_amount` CHECK ( payment_amount > 0 );


-- thêm dữ liệu
-- student
INSERT INTO student (student_id, full_name, email,phone,dob, gender)
VALUES
    ('S0001','Le Hoang Nam','nam.le@example.com',0901001001,'1995-01-01','Nam'),
    ('S0002','Nguyen Minh Chau','chau.nguyen@example.com',0901002002,'1996-02-02','Nữ'),
    ('S0003','Pham Bao Anh','anh.pham@example.com',0901003003,'1997-03-03','Nam'),
    ('S0004','Tran Kim Lien','lien.tran@example.com',0901004,'1998-04-04','Nữ'),
    ('S0005','Hoang Tien Dat','dat.hoang@example.com',0901005005,'1999-05-05','Nam'),
    ('S0006','Vo Thi Mai','mai.vo@example.com',0901006006,'2000-06-06','Nữ'),
    ('S0007','Doan Minh Tri','tri.doan@example.com',0901007007,'2001-07-07','Nam'),
    ('S0008','Nguyen Thanh Ha','ha.nguyen@example.com',0901008008,'2002-08-08','Nữ'),
    ('S0009','Trinh Bao Vy','vi.trinh@example.com',0901009009,'2003-09-09','Nữ'),
    ('S0010','Bui Hoang Nam','nam.bui@example.com',0901001010,'2004-10-10','Nam');
    
-- course    
INSERT INTO course (course_id,course_name,category,start_date,end_date,fee)
VALUES
    ('C001','Web Development','Programming','2025-07-01','2025-08-1',120.0),
    ('C002','Data Analysis','Data Science','2025-07-10','2025-08-15',150.0),
    ('C003','Basic Photoshop','Design','2025-07-05','2025-07-30',90.0),
    ('C004','Intro to Marketing','Marketing','2025-07-12','2025-08-20',110.0);
    
-- enrollment    
INSERT INTO enrollment (enrollment_id,student_id,course_id, enroll_date, enrollment_status, slot_count)
VALUES
    (1,	'S0001','C001',	'2025-06-01','Confirmed',1),
    (2,	'S0002','C002',	'2025-06-01','Pending',2),
    (3,	'S0003','C003',	'2025-06-01','Cancelled',3),
    (4,	'S0004','C004',	'2025-06-01','Confirmed',1),
    (5,	'S0005','C001',	'2025-06-01','Pending',2),
    (6,	'S0006','C002',	'2025-06-01','Cancelled',3),
    (7,	'S0007','C003',	'2025-06-01','Confirmed',1),
    (8,	'S0008','C004',	'2025-06-01','Pending',2),
    (9,	'S0009','C001',	'2025-06-01','Cancelled',3),
    (10,'S0010','C002',	'2025-06-01','Confirmed',1),
    (11,'S0001','C003',	'2025-06-01','Pending',2),
    (12,'S0002','C004',	'2025-06-01','Cancelled',3),
    (13,'S0003','C001',	'2025-06-01','Confirmed',1),
    (14,'S0004','C002',	'2025-06-01','Pending',2),
    (15,'S0005','C003',	'2025-06-01','Cancelled',3),
    (16,'S0006','C004',	'2025-06-01','Confirmed',1),
    (17,'S0007','C001',	'2025-06-01','Pending',2),
    (18,'S0008','C002',	'2025-06-01','Cancelled',3),
    (19,'S0009','C003',	'2025-06-01','Confirmed',1),
    (20,'S0010','C004',	'2025-06-01','Pending',2);

-- payment
INSERT INTO payment (payment_id,enrollment_id,payment_method, payment_amount, payment_date, payment_status)
VALUES
    (1,1,'Credit Card',120.0,'2025-06-01','Success'),
    (2,2,'Bank Transfer',150.0,'2025-06-02','Failed'),
    (3,3,'E-wallet',90.0,'2025-06-03','Pending'),
    (4,4,'Credit Card',110.0,'2025-06-04','Success'),
    (5,5,'Cash',120.0,'2025-06-05','Pending'),
    (6,6,'E-wallet',150.0,'2025-06-06','Success'),
    (7,7,'Credit Card',90.0,'2025-06-07','Failed'),
    (8,8,'Bank Transfer',110.0,'2025-06-08','Pending'),
    (9,9,'Cash',120.0,'2025-06-09','Success'),
    (10,1,'Credit Card',150.0,'2025-06-10','Pending');
    
-- Viết câu UPDATE cho phép cập nhật trạng thái thanh toán trong bảng Payment:

-- Cập nhật trạng thái thanh toán thành "Success" nếu số tiền thanh toán (payment_amount) > 0 và phương thức thanh toán là "Credit Card".
-- Chỉ cập nhật trạng thái thanh toán cho những giao dịch có ngày thanh toán (payment_date) là trước ngày hiện tại (CURRENT_DATE)

UPDATE payment
SET payment_status = 'Success'
WHERE payment_amount > 0
AND payment_method = 'Credit Card'
AND payment_date < CURRENT_DATE ();

-- 	Cập nhật trạng thái thanh toán thành "Pending" nếu phương thức thanh toán là "Bank Transfer" và số tiền thanh toán nhỏ hơn 100.
-- Chỉ cập nhật trạng thái thanh toán cho những giao dịch có ngày thanh toán (payment_date) là trước ngày hiện tại (CURRENT_DATE)

UPDATE payment
SET payment_status = 'Pending'
WHERE payment_amount < 100
AND payment_method = 'Bank Transfer'
AND payment_date < CURRENT_DATE();

-- Xóa các bản ghi trong bảng Payment nếu trạng thái thanh toán là "Pending" và phương thức thanh toán là "Cash".
DELETE FROM payment
WHERE payment_status = 'Pending' 
AND payment_method = 'Cash';

-- TRUY VẤN DỮ LIỆU

-- 1. Lấy 5 học viên gồm mã, tên, email, ngày sinh, giới tính, sắp xếp theo tên tăng dần.

SELECT student_id AS `Mã SV`,
	   full_name AS `Tên`,
       email,
       dob AS `ngày sinh`,
       gender AS `giới tính`
FROM student
ORDER BY full_name ASC
LIMIT 5;

-- 2. Lấy thông tin các khóa học gồm mã, tên, danh mục, sắp xếp theo học phí giảm dần.       

SELECT course_id AS `Mã khóa học`,
	   course_name AS `Tên khóa học`,
       category AS `Danh mục`
FROM course
ORDER BY fee DESC;

-- 3. Lấy thông tin các học viên gồm mã học viên, tên học viên, khoá học đã đăng ký 
-- và trạng thái Enrollment là "Cancelled"

SELECT s.student_id AS `mã học viên`,
	   s.full_name AS `tên học viên`,
       c.course_name AS `tên khóa học`
FROM enrollment AS e
INNER JOIN student AS s ON e.student_id = s.student_id
INNER JOIN course AS c ON e.course_id = c.course_id
WHERE enrollment_status = 'Cancelled';

-- 4. Lấy danh sách các khoá học gồm mã khoá học, mã học viên, khoá học đã đặt, 
-- và số lượng slot_count cho các khoá học có trạng thái "Confirmed", 
-- sắp xếp theo số lượng slot_count giảm dần

SELECT e.student_id `mã học viên`,
	   e.course_id `mã khóa học`,
	   c.course_name `khóa học đã đặt`
FROM enrollment AS e
INNER JOIN course AS c ON c.course_id = e.course_id
WHERE enrollment_status = 'Confirmed'
ORDER BY slot_count DESC;

-- 5. Lấy danh sách các học viên gồm mã khoá học, tên học viên, khoá học đã đăng ký
-- và số lượng slot_count cho các học viên có số lượng slot_count trong khoảng từ 2 đến 3
-- sắp xếp theo tên học viên

SELECT e.course_id AS `mã khóa học`,
       s.full_name AS `tên học viên`,
       c.course_name AS `khóa học đã đăng ký`,
      e.slot_count AS `số lượng slot_count`
FROM enrollment AS e
    INNER JOIN student AS s ON s.student_id = e.student_id
    INNER JOIN course AS c ON c.course_id = e.course_id
WHERE e.slot_count BETWEEN 2 AND 3
ORDER BY s.full_name;

-- 6. Lấy danh sách các học viên có ít nhất 2 slot và thanh toán ở trạng thái 'Pending'.

SELECT s.full_name AS `tên sinh viên`,
	   e.slot_count AS `slot`,
       p.payment_status AS `trạng thái thanh toán`
FROM enrollment AS e
INNER JOIN student AS s ON s.student_id = e.student_id
INNER JOIN payment AS p ON p.enrollment_id = e.enrollment_id
WHERE payment_status ='Pending' AND e.slot_count >= 2;

-- 7. Lấy danh sách các học viên và số tiền đã thanh toán với trạng thái 'Success'.
SELECT s.full_name AS `tên sinh viên`,
	   p.payment_amount AS `số tiền thanh toán`,
       p.payment_status AS `trạng thái thanh toán`
FROM enrollment AS e
INNER JOIN student AS s ON s.student_id = e.student_id
INNER JOIN payment AS p ON p.enrollment_id = e.enrollment_id
WHERE payment_status ='Success';

-- 8. Lấy danh sách 5 học viên đầu tiên có số lượng slot_count lớn hơn 1,
--  sắp xếp theo số lượng slot_count giảm dần, gồm mã học viên, tên học viên, số lượng slot_count và trạng thái enrollment
SELECT e.student_id AS `mã học viên`,
	   s.full_name AS `tên học viên`,
       e.slot_count AS `số lượng slot_count`,
       e.enrollment_status AS `trạng thái enrollment`
FROM enrollment AS e
INNER JOIN student AS s ON s.student_id = e.student_id
WHERE e.slot_count > 1
ORDER BY e.slot_count DESC
LIMIT 5 ;

--  9. Lấy thông tin khoá học có số lượng đăng ký nhiều nhất
SELECT c.*,
	SUM(e.slot_count) AS `tổng số lượng đăng ký`
FROM course AS c
INNER JOIN enrollment AS e ON e.course_id = c.course_id
GROUP BY c.course_id
HAVING SUM(e.slot_count) >= ALL 
(
	SELECT  SUM(e.slot_count) FROM enrollment AS e
	GROUP BY e.course_id
);

-- 10. Lấy danh sách các học viên có ngày sinh trước năm 2000 và đã thanh toán thành công.
SELECT s.*,
	   p.payment_amount AS `số tiền thanh toán`,
       p.payment_status AS `trạng thái thanh toán`
FROM enrollment AS e
INNER JOIN student AS s ON s.student_id = e.student_id
INNER JOIN payment AS p ON p.enrollment_id = e.enrollment_id
WHERE YEAR(s.dob) < 2000 AND p.payment_status = 'Success';

-- TẠO VIEW

-- 1. Tạo view view_all_student_enrollment để lấy danh sách tất cả các học viên và khoá học đã đăng ký,
-- gồm mã học viên, tên học viên, mã khoá học, tên khoá học và số lượng slot_count đã đăng ký

CREATE VIEW view_all_student_enrollment AS
SELECT s.student_id AS `mã học viên`,
	   s.full_name AS `tên học viên`,
       c.course_id AS `mã khóa học`,
       c.course_name AS `tên khóa học`,
       e.slot_count AS `số lượng slot_count`
FROM student AS s
INNER JOIN enrollment AS e ON s.student_id = e.student_id
INNER JOIN course AS c ON c.course_id = e.course_id;

-- 2. Tạo view view_successful_payment để lấy danh sách các học viên đã thanh toán thành công,
-- gồm mã học viên, tên học viên và số tiền thanh toán,
-- chỉ lấy các giao dịch có trạng thái thanh toán "Success"

CREATE VIEW view_successful_payment AS
SELECT s.student_id AS `Mã học viên`,
	   s.full_name AS `tên học viên`,
	   p.payment_amount AS `số tiền thanh toán`,
       p.payment_status AS `trạng thái thanh toán`
FROM enrollment AS e
INNER JOIN student AS s ON s.student_id = e.student_id
INNER JOIN payment AS p ON p.enrollment_id = e.enrollment_id
WHERE p.payment_status = 'Success';

-- TẠO TRIGGER 
-- 1. Tạo một trigger để kiểm tra và đảm bảo rằng số slot_count trong bảng 
-- Enrollment không bị giảm xuống dưới 1 khi có sự thay đổi.
-- Nếu số slot_count nhỏ hơn 1, trigger sẽ thông báo lỗi SIGNAL SQLSTATE và không cho phép cập nhật.
DELIMITER $$
CREATE TRIGGER CheckSlotCount 
BEFORE UPDATE ON  enrollment 
FOR EACH ROW
BEGIN
		IF NEW.slot_count < 1 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'không được phép cập nhật';
		END IF;
END; $$
DELIMITER ;

UPDATE  enrollment
SET slot_count = 2
WHERE enrollment_id = 1;

-- 2. Tạo một trigger để khi thực hiện chèn dữ liệu vào bảng Payment,
-- sẽ tự động kiểm tra trạng thái thanh toán, 
-- nếu như trạng thái thanh toán là “Success” thì 
-- tiến hành cập nhật trạng thái enrollment_status của
--  bảng Enrollment tương ứng với đơn đăng ký đó thành “Confirmed”

DELIMITER $$
CREATE TRIGGER CheckPaymentStatus 
AFTER INSERT ON  payment 
FOR EACH ROW
BEGIN
	IF NEW.payment_status = 'Success' THEN
		UPDATE enrollment
		SET enrollment_status = 'Confirmed'
		WHERE enrollment_id = NEW.enrollment_id;
    END IF;
END; $$
DELIMITER ;

INSERT INTO enrollment (enrollment_id,student_id,course_id, enroll_date, enrollment_status, slot_count)
VALUES
    (21,'S0010','C001',	'2025-06-03','Pending',1);

INSERT INTO payment (payment_id,enrollment_id,payment_method, payment_amount, payment_date, payment_status)
VALUES
    (12,21,'Credit Card',120.0,'2025-06-03','Success');
    
    
-- TẠO  STORE PROCEDURE

-- 1. Tạo một stored procedure có tên GetAllStudentEnrollments để lấy thông tin tất cả các sinh viên và khoá học họ đã đăng ký
DELIMITER $$
CREATE PROCEDURE GetAllStudentEnrollments()
BEGIN
		SELECT s.*,
        c.course_name AS `tên khóa học`
        FROM student AS s
        INNER JOIN enrollment AS e ON s.student_id = e.student_id
		INNER JOIN course AS c ON c.course_id = e.course_id;
END $$
DELIMITER ;
CALL GetAllStudentEnrollments();

-- 2. Tạo một stored procedure có tên UpdateEnrollment để thực hiện thao tác cập nhật một bản ghi trong vào bảng Enrollment dựa theo khóa chính.
-- Các tham số đầu vào:
-- 	p_enrollment_id: Mã đăng ký.
-- 	p_student_id: Mã học viên.
-- 	p_course_id: Mã khoá học.
-- 	p_slot_count: Số lượng slot đăng ký.

DELIMITER $$
CREATE PROCEDURE UpdateEnrollment (
    IN p_enrollment_id INT,
    IN p_student_id VARCHAR(25),
    IN p_course_id VARCHAR(25),
    IN p_slot_count INT
)
BEGIN
    UPDATE enrollment AS e
        SET
            e.student_id = p_student_id ,
            e.course_id = p_course_id,
            e.slot_count = p_slot_count
    WHERE e.enrollment_id =  p_enrollment_id;

END; $$
DELIMITER ;

CALL UpdateEnrollment (1, 'S0001', 'C001',4);