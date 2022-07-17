CREATE DATABASE `auction` /*!40100 DEFAULT CHARACTER SET
utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT
ENCRYPTION='N' */;

use auction;

select database();

-- __________________  Dump Tables to Start Fresh __________________
DROP TABLE PERSON CASCADE;
DROP TABLE BILLING_INFO CASCADE;
DROP TABLE CARD_TYPE CASCADE;
DROP TABLE LOGIN CASCADE;
DROP TABLE AUCTION CASCADE;
DROP TABLE AUCTION_STATUS CASCADE;
DROP TABLE ITEM_CATEGORY CASCADE;
DROP TABLE ITEM_CONDITION CASCADE;
DROP TABLE BID CASCADE;


-- __________________  Create Tables Fresh __________________

CREATE TABLE PERSON (
	USER_ID INTEGER AUTO_INCREMENT PRIMARY KEY,
	USERNAME VARCHAR(40) UNIQUE NOT NULL,
	LAST_NAME VARCHAR(96) NOT NULL,
	FIRST_NAME VARCHAR(96) NOT NULL,
	EMAIL_ADDRESS VARCHAR(255) NOT NULL
	);

CREATE TABLE BILLING_INFO(
    BILLING_INFO_ID INTEGER AUTO_INCREMENT PRIMARY KEY,
	USERNAME VARCHAR(40) NOT NULL,
    AUCTION_ID INTEGER,
	LAST_NAME VARCHAR(96) NOT NULL,
	FIRST_NAME VARCHAR(96) NOT NULL,
	CARD_TYPE INTEGER NOT NULL,
	CARD_NUMBER VARCHAR(19) NOT NULL,
	EXP_MONTH INTEGER NOT NULL,
	EXP_DAY INTEGER NOT NULL,
	SECURITY_CODE INTEGER NOT NULL); 

CREATE TABLE CARD_TYPE (
	CARD_TYPE_ID INTEGER AUTO_INCREMENT PRIMARY KEY,
	CARD_NAME VARCHAR(20) NOT NULL );

CREATE TABLE LOGIN (
	USERNAME VARCHAR(40) PRIMARY KEY,
	PWD_HASH VARCHAR(255) NOT NULL,
    LOGGED_IN TINYINT DEFAULT 0);

CREATE TABLE AUCTION (
	AUCTION_ID INTEGER AUTO_INCREMENT PRIMARY KEY,
	STATUS INTEGER NOT NULL,
	SELLER VARCHAR(40) NOT NULL,
    CURRENT_BID_ID INTEGER,
	STARTING_BID NUMERIC(7,2),
	RESERVE_PRICE NUMERIC(7,2),
	OPEN_TIME TIMESTAMP NOT NULL,
	CLOSE_TIME TIMESTAMP NOT NULL,
	ITEM_CATEGORY INTEGER,
	ITEM_NAME VARCHAR(78),
	ITEM_DESCRIPTION TEXT,
	ITEM_CONDITION INTEGER NOT NULL,
	PAID TINYINT DEFAULT 0);

CREATE TABLE AUCTION_STATUS (
	AUCTION_STATUS_ID INTEGER AUTO_INCREMENT PRIMARY KEY,
	NAME VARCHAR(20) NOT NULL );

CREATE TABLE ITEM_CATEGORY (
	ITEM_CATEGORY_ID INTEGER AUTO_INCREMENT PRIMARY KEY,
	NAME VARCHAR(78) NOT NULL );

CREATE TABLE ITEM_CONDITION (
	ITEM_CONDITION_ID INTEGER AUTO_INCREMENT PRIMARY KEY,
	NAME VARCHAR(20) NOT NULL );

CREATE TABLE BID (
	BID_ID INTEGER PRIMARY KEY,
	BIDDER VARCHAR(40) NOT NULL,
	AUCTION INTEGER NOT NULL,
	BID_TIME TIMESTAMP NOT NULL,
	AMOUNT NUMERIC(9,2) NOT NULL );


-- __________________  Create Indecies __________________
-- CREATE INDEX AUCTION_STATUS_NAME_INDEX ON AUCTION_STATUS (NAME);
-- CREATE INDEX ITEM_CATEGORY_NAME_INDEX ON ITEM_CATEGORY (NAME);
-- CREATE INDEX AUCTION_STATUS_INDEX ON AUCTION (STATUS);
-- CREATE INDEX AUCTION_SELLER_INDEX ON AUCTION (SELLER);
-- CREATE INDEX AUCTION_ITEM_CATEGORY_INDEX ON AUCTION (ITEM_CATEGORY);
-- CREATE INDEX BID_AUCTION_INDEX ON BID (AUCTION);
-- CREATE INDEX BID_BIDDER_INDEX ON BID (BIDDER);

-- __________________  Add Foreign Keys __________________
ALTER TABLE BILLING_INFO ADD FOREIGN KEY (USERNAME) REFERENCES PERSON(USERNAME);
ALTER TABLE BILLING_INFO ADD FOREIGN KEY (AUCTION_ID) REFERENCES AUCTION(AUCTION_ID);
ALTER TABLE BILLING_INFO ADD FOREIGN KEY (CARD_TYPE) REFERENCES CARD_TYPE(CARD_TYPE_ID);
ALTER TABLE LOGIN ADD FOREIGN KEY (USERNAME) REFERENCES PERSON(USERNAME) ;
ALTER TABLE AUCTION ADD FOREIGN KEY (SELLER) REFERENCES PERSON(USERNAME);
ALTER TABLE AUCTION ADD FOREIGN KEY (STATUS) REFERENCES AUCTION_STATUS(AUCTION_STATUS_ID);
ALTER TABLE AUCTION ADD FOREIGN KEY (ITEM_CATEGORY) REFERENCES ITEM_CATEGORY(ITEM_CATEGORY_ID);
ALTER TABLE AUCTION ADD FOREIGN KEY (CURRENT_BID_ID) REFERENCES BID(BID_ID) ;
ALTER TABLE AUCTION ADD FOREIGN KEY (ITEM_CONDITION) REFERENCES ITEM_CONDITION(ITEM_CONDITION_ID);
ALTER TABLE BID ADD FOREIGN KEY (BIDDER) REFERENCES PERSON(USERNAME);
ALTER TABLE BID ADD FOREIGN KEY (AUCTION) REFERENCES AUCTION(AUCTION_ID);


-- __________________  Dummy data __________________
INSERT INTO PERSON VALUES (1, 'sarthakg', 'Sarthak', 'Gupta', 's.gupta@example.com');
INSERT INTO PERSON VALUES (2, 'amitd', 'Amit', 'Dua', 'a.dua@example.com');
INSERT INTO PERSON VALUES (3, 'xyz', 'ABC', 'XYZ', 'abc@example.com');
INSERT INTO PERSON VALUES (4, 'bellford', 'Bell', 'Ford', 'beford@example.com');

SET FOREIGN_KEY_CHECKS=0;

INSERT INTO CARD_TYPE VALUES (1, 'Visa');
INSERT INTO CARD_TYPE VALUES (2, 'Mastercard');

INSERT INTO ITEM_CONDITION VALUES(1, 'New');
INSERT INTO ITEM_CONDITION VALUES(2, 'Very Good');
INSERT INTO ITEM_CONDITION VALUES(3, 'Good');
INSERT INTO ITEM_CONDITION VALUES(4, 'Fair');
INSERT INTO ITEM_CONDITION VALUES(5, 'Poor');

INSERT INTO AUCTION_STATUS VALUES (1, 'Open');
INSERT INTO AUCTION_STATUS VALUES (2, 'Cancelled');
INSERT INTO AUCTION_STATUS VALUES (3, 'Closed');
INSERT INTO AUCTION_STATUS VALUES (4, 'Failed');

INSERT INTO ITEM_CATEGORY VALUES (1, 'Antiques');
INSERT INTO ITEM_CATEGORY VALUES (2, 'Art & Collectibles');
INSERT INTO ITEM_CATEGORY VALUES (3, 'Books & Movies & Music');
INSERT INTO ITEM_CATEGORY VALUES (4, 'Cars');
INSERT INTO ITEM_CATEGORY VALUES (5, 'Clothing');
INSERT INTO ITEM_CATEGORY VALUES (6, 'Computers & Electronics');
INSERT INTO ITEM_CATEGORY VALUES (7, 'Home');
INSERT INTO ITEM_CATEGORY VALUES (8, 'Jewelry');
INSERT INTO ITEM_CATEGORY VALUES (9, 'Musical Instruments');
INSERT INTO ITEM_CATEGORY VALUES (10, 'Tools');
INSERT INTO ITEM_CATEGORY VALUES (11, 'Toys');


INSERT INTO AUCTION (AUCTION_ID,STATUS, SELLER, CURRENT_BID_ID, STARTING_BID, RESERVE_PRICE, OPEN_TIME,
	CLOSE_TIME,ITEM_CATEGORY,ITEM_NAME,ITEM_DESCRIPTION,ITEM_CONDITION,PAID) VALUES (1001, 1, 'sarthakg', null, 5.00, 20.00, '2021-02-02 15:37:00', '2021-02-25 23:00:00', 7, 'Towels', 'Slightly used towels, set of 42', 3, 0);
INSERT INTO AUCTION (AUCTION_ID,STATUS, SELLER, CURRENT_BID_ID, STARTING_BID, RESERVE_PRICE, OPEN_TIME,
	CLOSE_TIME,ITEM_CATEGORY,ITEM_NAME,ITEM_DESCRIPTION,ITEM_CONDITION,PAID)VALUES (1002, 1, 'sarthakg', null, 5.00, 40.00, '2022-02-02 17:05:00', '2022-02-25 23:00:00', 3, '"My Favourite Bathtime Gurgles" by Grunthos the Flatulent', 'Grunthos'' 12-book epic.  Not to be missed.  Was to be presented at Mid-Galactic Arts Nobbling Council, but the poet''s death prevented its presentation.', 2, 0);
INSERT INTO AUCTION (AUCTION_ID,STATUS, SELLER, CURRENT_BID_ID, STARTING_BID, RESERVE_PRICE, OPEN_TIME,
	CLOSE_TIME,ITEM_CATEGORY,ITEM_NAME,ITEM_DESCRIPTION,ITEM_CONDITION,PAID)VALUES (1003, 1, 'amitd', null, 3.00, 30.00, '2022-02-02 17:06:00', '2022-02-25 22:00:00', 10, 'Toasting knife', 'Bread knife that toasts the bread as you cut it.', 1, 0);
INSERT INTO AUCTION (AUCTION_ID,STATUS, SELLER, CURRENT_BID_ID, STARTING_BID, RESERVE_PRICE, OPEN_TIME,
	CLOSE_TIME,ITEM_CATEGORY,ITEM_NAME,ITEM_DESCRIPTION,ITEM_CONDITION,PAID)VALUES (1004, 2, 'amitd', NULL, 1.00, 30.00, '2021-02-12 10:22:00', '2021-02-25 23:00:00', 11, 'Beach Ball', "This is a beach ball.  It's really cool.  Buy it.", 5, 0);
INSERT INTO AUCTION (AUCTION_ID,STATUS, SELLER, CURRENT_BID_ID, STARTING_BID, RESERVE_PRICE, OPEN_TIME,
	CLOSE_TIME,ITEM_CATEGORY,ITEM_NAME,ITEM_DESCRIPTION,ITEM_CONDITION,PAID)VALUES (1005, 3, 'amitd', null, 50.00, 100.00, '2021-02-12 10:23:00', '2021-02-25 22:00:00', 8, 'Big Ring', 'This is a really cool, shiny ring.  Makes a great gift.', 4, 0);
INSERT INTO AUCTION (AUCTION_ID,STATUS, SELLER, CURRENT_BID_ID, STARTING_BID, RESERVE_PRICE, OPEN_TIME,
	CLOSE_TIME,ITEM_CATEGORY,ITEM_NAME,ITEM_DESCRIPTION,ITEM_CONDITION,PAID)VALUES (1006, 4, 'amitd', NULL, 100.00, 0.00, '2021-02-12 10:24:00', '2021-02-25 20:00:00', 2, 'Mona Lisa', 'The famous painting.  Don''t ask where I got it.', 2, 0);

insert into bid (bid_id, bidder, auction, bid_time, amount) values (1, 'amitd', 1001, '2021-02-10 18:32:00', 10.00);
insert into bid (bid_id, bidder, auction, bid_time, amount) values (2, 'wxy', 1001, '2021-02-15 23:59:00', 20.00);
insert into bid (bid_id, bidder, auction, bid_time, amount) values (3,'amitd', 1001, '2021-02-20 13:45:00', 30.00);

update auction set current_bid_id =  3 where auction_id = 1001;

insert into bid (bid_id,bidder, auction, bid_time, amount) values (4,'amitd', 1002, '2022-02-10 18:32:00', 10.00);
insert into bid (bid_id,bidder, auction, bid_time, amount) values (5,'wxy', 1002, '2022-02-15 23:59:00', 20.00);
insert into bid (bid_id,bidder, auction, bid_time, amount) values (6,'amitd', 1002, '2022-02-20 13:45:00', 30.00);
insert into bid (bid_id,bidder, auction, bid_time, amount) values (7,'amitd', 1002, '2022-02-10 18:32:00', 40.00);
insert into bid (bid_id,bidder, auction, bid_time, amount) values (8,'wxy', 1002, '2022-02-15 23:59:00', 50.00);

update auction set current_bid_id =  8 where auction_id = 1002;

insert into bid (bid_id,bidder, auction, bid_time, amount) values (9,'sarthakg', 1003, '2022-02-15 18:32:00', 15.00);
insert into bid (bid_id,bidder, auction, bid_time, amount) values (10,'wxy', 1003, '2022-02-20 23:59:00', 35.00);
insert into bid (bid_id,bidder, auction, bid_time, amount) values (11,'sarthakg', 1003, '2022-02-21 13:45:00', 45.00);

update auction set current_bid_id =  11 where auction_id = 1003;

insert into bid (bid_id, bidder, auction, bid_time, amount) values (12,'wxy', 1004, '2021-02-20 23:00:00', 35.00);

update auction set current_bid_id =  12 where auction_id = 1004;

insert into bid (bid_id, bidder, auction, bid_time, amount) values (13,'sarthakg', 1005, '2021-02-13 18:32:00', 55.00);
insert into bid (bid_id, bidder, auction, bid_time, amount) values (14, 'wxy', 1005, '2021-02-21 23:59:00', 85.00);

update auction set current_bid_id =  14 where auction_id = 1005;

insert into bid (bid_id,bidder, auction, bid_time, amount) values (15,'sarthakg', 1006, '2021-02-14 18:12:00', 155.00);
insert into bid (bid_id,bidder, auction, bid_time, amount) values (16,'wxy', 1006, '2021-02-22 23:48:00', 185.00);
insert into bid (bid_id,bidder, auction, bid_time, amount) values (17,'sarthakg', 1006, '2021-02-24 17:32:00', 195.00);

update auction set current_bid_id =  17 where auction_id = 1006;


-- ____________ procedures ___________________

drop procedure register;

-- stored proedure for registration into the Auction site 

DELIMITER #
CREATE PROCEDURE register(in fname varchar(96),in lname varchar(96),in uname varchar(40),in eadd varchar(255),in passwd varchar(255))
DETERMINISTIC 
SQL SECURITY INVOKER
BEGIN    
start transaction;  
set @firstname = fname;
set @lastname = lname;
set @username = uname;
set @email = eadd;
set @pwd = passwd;

     
insert into person(username, 
				   last_name, 
				   first_name, 
				   email_address) 
select @username, @lastname, @firstname, @email where @username not in (select username from person); 

-- Add login credentials into the login table

insert into login(username, pwd_hash) select @username, @pwd where @username not in (select username from login);
commit;
END#
DELIMITER ;

SET SQL_SAFE_UPDATES = 0;

drop procedure loggingin;

--  stored procedure for logging in into the auction site

DELIMITER #
CREATE PROCEDURE loggingin(in username varchar(40), in passwd varchar(255))
DETERMINISTIC 
SQL SECURITY INVOKER
BEGIN 
start transaction;  
set @username = username;
set @pwd = passwd;
select @username;
UPDATE login 
set logged_in = 1 where pwd_hash = @pwd and login.username = @username;
commit;
END#
DELIMITER ;

DROP PROCEDURE auctioninfo;

DELIMITER #
CREATE PROCEDURE auctioninfo(in auction_id INTEGER)
DETERMINISTIC 
SQL SECURITY INVOKER
BEGIN
start transaction;
set @auction_id = auction_id;
SELECT
        S.NAME AS STATUS,
		P.USERNAME AS SELLER_USERNAME,
		P.USER_ID AS SELLER_ID,
        A.CLOSE_TIME,
        A.ITEM_NAME,
        A.ITEM_DESCRIPTION,
		A.CURRENT_BID_ID,
		A.STARTING_BID AS MIN_BID,
		A.RESERVE_PRICE
        FROM AUCTION A
            JOIN PERSON P ON A.SELLER = P.USERNAME
			JOIN AUCTION_STATUS S ON A.STATUS = S.AUCTION_STATUS_ID
        WHERE A.AUCTION_ID = @auction_id;
commit;
END#
DELIMITER ;

-- find current highest bidder 

drop function currenthighbid;

DELIMITER #
CREATE FUNCTION currenthighbid(auctionId integer) returns varchar(40)
DETERMINISTIC
BEGIN
set @bid_id = (select current_bid_id from auction where auction_id = auctionId);
set @highestBidder = (select bidder from bid where bid_id = @bid_id);
return @highestBidder;
END#
DELIMITER ;

drop procedure addItem;
-- adding Item For Auction 

DELIMITER #
CREATE PROCEDURE addItem(in auction_id INTEGER, in status INTEGER, in seller VARCHAR(40), 
                         in startingBid NUMERIC(7,2), in reservePrice NUMERIC(7,2), 
                         in close_time TIMESTAMP, in item_category INTEGER, 
                         in item_name VARCHAR(78), in item_description VARCHAR(998), in item_condition INTEGER)
DETERMINISTIC 
SQL SECURITY INVOKER
BEGIN
start transaction;
INSERT INTO AUCTION
	(AUCTION_ID, STATUS, SELLER, CURRENT_BID_ID, STARTING_BID, RESERVE_PRICE, OPEN_TIME, CLOSE_TIME, ITEM_CATEGORY, ITEM_NAME, ITEM_DESCRIPTION, ITEM_CONDITION)
        select auction_id, status, seller, NULL, startingBid, reservePrice, CURRENT_TIMESTAMP, close_time, item_category, item_name, item_description, item_condition
        where (select logged_in from login where username = seller) > 0 and close_time > CURRENT_TIMESTAMP;
        
commit;
END#
DELIMITER ;

-- close auction 

DROP PROCEDURE closeAuction;


DELIMITER #
create procedure closeAuction(inout auctionId integer)
DETERMINISTIC
SQL SECURITY INVOKER
BEGIN 
start transaction;


set @close_time = (select close_time from auction where auction_id = auctionId);

UPDATE AUCTION 
SET STATUS = 3 WHERE @close_time<current_timestamp AND AUCTION_ID = auctionId;
set @current_bid = (select current_bid_id from auction where auction_id=auctionId);
set @highestBid = (select amount from bid where bid_id = @current_bid);

UPDATE AUCTION 
SET STATUS = 4 WHERE status = 3 and reserve_price > @highestBid;
commit;
END#
DELIMITER ;



-- confirm Payment

drop procedure payment;

DELIMITER #
create procedure payment(in bidder varchar(40), in auctionId integer, 
						 in card_type integer, in card_number varchar (19), 
						 in exp_month integer, in exp_day integer, 
                         in security_code integer)
DETERMINISTIC
SQL SECURITY INVOKER
BEGIN
start transaction;
call closeAuction(auctionId);
set @auctonId = (select auctionId);
set @lname = (select LAST_NAME from person where username = bidder);
set @fname = (select FIRST_NAME from person where username = bidder);
set @stat = (select status from auction where auction_id = auctionId);

set @billing_info_id = (select max(billing_info_id) from billing_info)+1;
insert into billing_info select @billing_info_id, bidder, auctionId, @lname, @fname, 
card_type, card_number, exp_month, exp_day, security_code where @stat = 3;

update auction set paid = 1 where status = 3 and auction_id = (select auction_id from billing_info where auction_id = auctionId and username = bidder);
commit;
END#
DELIMITER ;

drop procedure removeItem;
-- remove item 
DELIMITER #
create procedure removeItem(in auctionId integer)
DETERMINISTIC
SQL SECURITY INVOKER
BEGIN
start transaction;
set @seller = (select seller from auction where auction_id = auctionId);
UPDATE AUCTION
		SET STATUS = 2
		WHERE AUCTION_ID = auctionId and close_time > CURRENT_TIMESTAMP and (select logged_in from login where username = @seller) > 0;
        
END#
commit;
DELIMITER ;

-- edit item 
drop procedure editItem;
DELIMITER #
CREATE PROCEDURE editItem( in auctionId integer,  in reservePrice NUMERIC(7,2), 
                           in close_time TIMESTAMP, in item_category INTEGER, 
                           in item_description VARCHAR(998))
DETERMINISTIC 
SQL SECURITY INVOKER
BEGIN
start transaction;
-- user cannot edit auction_id, seller, current_bid_id, auction_status, item_name,starting_bid, open_time, item_condition

set @seller = (select seller from auction where auction_id = auctionId);
set @reserve_price = coalesce(reservePrice, (select reserve_price from auction where auction_id = auctionId and seller = @seller));
set @close_time = ifnull(close_time, (select close_time from auction where auction_id = auctionId and seller = @seller));
set @item_category = coalesce(item_category, (select item_category from auction where auction_id = auctionId and seller = @seller));
set @item_description = coalesce(item_description, (select item_description from auction where auction_id = auctionId and seller = @seller));

UPDATE AUCTION SET
	RESERVE_PRICE = @reserve_price,CLOSE_TIME = @close_time, ITEM_CATEGORY = @item_category, ITEM_DESCRIPTION = @item_description
        where ((select logged_in from login where username = @seller) > 0) and (auction_id = auctionId) and (seller = @seller) and status=1;
commit;
END#
DELIMITER ;

-- Add bidding

drop procedure add_bid;

DELIMITER #
create procedure add_bid(in bidder varchar(40), in auctionId integer, in bidTime timestamp, in amt numeric(9,2))
DETERMINISTIC
SQL SECURITY INVOKER
BEGIN 
start transaction;
set @auctionId = auctionId;
call closeAuction(@auctionId);
set @bidder = bidder;
set @auction = @auctionId;
set @bid_time = bidTime;
set @amount = amt;
set @close_time = (select close_time from auction where auction_id = auctionId);
set @bid_id = (select max(bid_id)+1 from bid);
insert into bid (bid_id, bidder, auction, bid_time, amount) select @bid_id, @bidder, @auctionId, @bid_time, @amount where @bid_time < @close_time;

update auction set current_bid_id = @bid_id where auction_id = @auctionId and status=1;
commit;
END#
DELIMITER ;

-- logging out from the auction site 

drop procedure logout;

DELIMITER #
create procedure logOut(in username varchar(40))
DETERMINISTIC
SQL SECURITY INVOKER
BEGIN
start transaction;

update login set logged_in = 0 where login.username = username;
        
commit;
END#
DELIMITER ;

-- current active 

drop procedure currentActive;

DELIMITER #
create procedure currentActive()
DETERMINISTIC
SQL SECURITY INVOKER
BEGIN
start transaction;
select auction_id, username, current_bid_id, starting_bid, reserve_price, open_time, close_time, item_category.name as item_category, 
item_name,item_description,item_condition.name as item_condition from auction,person,item_category,item_condition where
status = 1 and auction.seller = person.username and auction.item_category = item_category.item_category_id and
auction.item_condition = item_condition.item_condition_id;
commit;        
END#
DELIMITER ;

drop procedure userInfo;
   
-- userInfo 

DELIMITER #
create procedure userInfo(in username varchar(40))
DETERMINISTIC
SQL SECURITY INVOKER
BEGIN
start transaction;
select bid_id, auction_id,starting_bid,reserve_price,open_time,close_time,item_category.name as item_category, item_name, item_description,
item_condition.name as item_condition from bid,auction,item_category,item_condition where bidder = username and bid.auction = auction_id and
auction.item_category = item_category.item_category_id and auction.item_condition = item_condition.item_condition_id;
commit;        
END#
DELIMITER ;

-- Items bought by a user

drop procedure itemBought;

DELIMITER #
create procedure itemBought(in username varchar(40))
DETERMINISTIC
SQL SECURITY INVOKER
BEGIN
start transaction;
set @usernm = username;
select auction_id, auction.item_name as item_name from auction,bid where status = 3 and auction.auction_id = bid.auction
and auction.current_bid_id = bid.bid_id and bidder = @usernm; 
commit;        
END#
DELIMITER ;


