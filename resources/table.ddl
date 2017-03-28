--create schema IDLEGOODS
CREATE SCHEMA IDLEGOODS;

--create sequence
CREATE SEQUENCE IDLEGOODS.GLOBAL_SEQ MAXVALUE 9223372036854775807;

--------------------------------------
--User Model 
--------------------------------------

--create user account
CREATE TABLE IDLEGOODS.USER_ACCOUNT (
	ID BIGINT PRIMARY KEY  NOT NULL,
	NAME VARCHAR(60) NOT NULL,
	REALNAME VARCHAR(60) NOT NULL,
	GENDER INT,
	EMAIL VARCHAR(60) NOT NULL,
	MOBILE VARCHAR(60) NOT NULL,
	ADDRESS_ID BIGINT,
	PASSWORD CHAR(64) DEFAULT NULL,
	LASTUPDATE TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	CREATEDATE TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
);


--log user's login info
CREATE TABLE IDLEGOODS.LOGIN_LOG(
	LOGIN_ID BIGINT NOT NULL,
	USER_ID BIGINT NOT NULL,
	LOGIN_TIME TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	LOGIN_IP CHAR(15) NOT NULL,
	PRIMARY KEY (LOGIN_ID)
);

--user's address
CREATE TABLE IDLEGOODS.ADDRESS (
	ADDRESS_ID BIGINT NOT NULL,
	USER_ID BIGINT NOT NULL,
	ADDRESSTYPE INT NOT NULL,
	MOBILE VARCHAR(32) NOT NULL,
	CONTACTNAME VARCHAR(32) NOT NULL,
	ZIPCODE VARCHAR(32) NOT NULL,
	PROVINCE BIGINT NOT NULL,
	CITY BIGINT NOT NULL,
	DISTRICT BIGINT,
	DETAIL VARCHAR(120),
	OPTCOUNTER SMALLINT NOT NULL DEFAULT 0,
	LASTUPDATE TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	ADDRESS_STATE INT,
	PRIMARY KEY (ADDRESS_ID)
);

------------------------------
--Admin Model
-------------------------------

--create admin account
CREATE TABLE IDLEGOODS.ADMIN (
	ID BIGINT NOT NULL,
	NAME VARCHAR(60) NOT NULL,
	REALNAME VARCHAR(60) NOT NULL,
	GENDER INT,
	EMAIL VARCHAR(60) NOT NULL,
	MOBILE VARCHAR(60) NOT NULL,
	PASSWORD CHAR(64) DEFAULT NULL,
	LASTUPDATE TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	CREATEDATE TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (ID)
);

--log admin operation
CREATE TABLE IDLEGOODS.ADMIN_LOG(
	LOGIN_ID BIGINT NOT NULL,
	ID BIGINT NOT NULL,
	LOGIN_TIME TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	LOGIN_IP CHAR(15) NOT NULL,
	PRIMARY KEY (LOGIN_ID)
);

----------------------------------------
-- Goods Model 
----------------------------------------

--Goods
CREATE TABLE IDLEGOODS.ITEMS(
	ID BIGINT NOT NULL,
	NAME VARCHAR(255),
	SHORTDESCRIPTION VARCHAR(254),
	LONGDESCRIPTION VARCHAR(4000),
	QUANTITY INT NOT NULL,
	PRICE DECIMAL(20,5) NOT NULL,
	FULLIMAGE VARCHAR(254),
	PUBLISHED SMALLINT NOT NULL DEFAULT 0,
	KEYWORD VARCHAR(254),
	CATGROUP_ID BIGINT,
	LASTUPDATE TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (ID)
);

-- Goods category 
CREATE TABLE IDLEGOODS.CATGROUP(
	CATGROUP_ID BIGINT NOT NULL,
	NAME VARCHAR(120),
	SHORTDESCRIPTION VARCHAR(254),
	LONGDESCRIPTION VARCHAR(4000),
	THUMBNAIL VARCHAR(254),
	FULLIMAGE VARCHAR(254),
	PUBLISHED SMALLINT NOT NULL DEFAULT 0,
	KEYWORD VARCHAR(254),
	MARKFORDELETE INT NOT NULL DEFAULT 0,
	OPTCOUNTER SMALLINT NOT NULL DEFAULT 0,
	LASTUPDATE TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (CATGROUP_ID)
);

CREATE TABLE IDLEGOODS.UPLOAD_FILE(
	FILE_ID BIGINT NOT NULL,
	FILE_NAME VARCHAR(60) NOT NULL,
	FILE_HASH CHAR(64) NOT NULL,
	LASTUPDATE TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (FILE_ID)
);


----------------------------------------
-- Order Model
----------------------------------------
CREATE TABLE IDLEGOODS.ORDERS(
	ORDER_ID BIGINT NOT NULL, --Generated unique key.
	USER_ID BIGINT NOT NULL,  --The customer that placed the order. recurring order (REC), or subscription (SUB).
	ORDER_STATUS SMALLINT,  --ORDER STATUS
	ORDER_PAYMENT_STATUS SMALLINT,  --ORDER PAYMENT STATUS
--	CURRENCY  CHAR(10) NOT NULL DEFAULT 'CNY', --The currency of the price. This is a currency code as per ISO 4217 standards. CNY FOR RMB
	ORDER_COMMENTS VARCHAR(254),  --Comments from the customer.
    ADDRESS_ID BIGINT NOT NULL,
	SHIPMODE  INTEGER, --The shipping mode, if still known.
	TOTAL_PRODUCT DECIMAL(20,5) DEFAULT 0, --The sum of ORDERITEMS.TOTALPRODUCT for the OrderItems in the Order.
	TOTAL_SHIPPING DECIMAL(20,5) DEFAULT 0, --The sum of ORDERITEMS.SHIPCHARGE for the OrderItems in the Order.
	TOTAL_ADJUSTMENT DECIMAL(20,5) DEFAULT 0, --The sum of ORDERITEMS.TOTALADJUSTMENT for the order items in the order. This column also includes all kinds of shipping charge adjustments like discount, coupon, shipping adjustment and surcharge.
-- 	RANK DOUBLE PRECISION NOT NULL DEFAULT 1, --(Deprecated, defined in orderitems table instead)
--	OPTCOUNTER SMALLINT NOT NULL DEFAULT 0,
	CREATE_TIME TIMESTAMP WITHOUT TIME ZONE NOT NULL,
	UPDATE_TIME TIMESTAMP WITHOUT TIME ZONE,
	PRIMARY KEY (ORDER_ID)
);


CREATE TABLE IDLEGOODS.ORDERITEMS(
	ORDERITEM_ID BIGINT NOT NULL, --Generated unique key.
	ORDER_ID BIGINT NOT NULL, --The order of which this order item is part.
-- 	MEMBER_ID BIGINT NOT NULL,  --The customer that placed the order.
--	BUSCHN_ID INTEGER, --The Business Channel ID of the order.
	CATENTRY_ID BIGINT NOT NULL, --The catalog entry, if any, of the product being purchased.
	CURRENCY  CHAR(10) NOT NULL DEFAULT 'CNY',  -- The currency for monetary amounts associated with this order. This is the currency code according to ISO 4217 standards.
	PRICE DECIMAL(20,5), --??????????????
	OFFER_ID BIGINT NOT NULL,
	QUANTITY DOUBLE PRECISION NOT NULL,
	PRODUCT DECIMAL(20,5), --PRICE times QUANTITY.
	ADJUSTMENT DECIMAL(20,5) DEFAULT 0, --The total of the monetary amounts of the order item adjustments for this order item, in the currency specified by CURRENCY. This column also includes all kinds of shipping charge adjustments like discount, coupon, shipping adjustment and surcharge.
	SHIPCHARGE DECIMAL(20,5) DEFAULT 0, --The base shipping charge associated with the order item, in the currency specified by CURRENCY, it is the shipping charge before any adjustments. The shipping charge adjustment will be persisted in the ORDERITEMS.TOTALADJUSTMENT column with other adjustments including discount and surcharge. The total shipping charge is the sum of base shipping charge in ORDERITEMS.SHIPCHARGE column and the shipping charge adjustment in ORDERITEMS.TOTALADJUSTMENT column.
	ORDERITEM_STATUS SMALLINT,  --The status for the order item. It may not be the same as the status in the order.
	ORDERITEM_PAYMENT_STATUS SMALLINT,  --ORDER ITEM PAYMENT STATUS
	INVENTORY_STATUS CHAR (4) NOT NULL DEFAULT 'AVL', --NALC:Inventory is not allocated nor on back-order.  	BO:Inventory is on back-order. ALLC:Inventory is allocated. FUL:Inventory has been released for fulfillment. AVL:Inventory is available.
	ORDERITEM_COMMENTS VARCHAR(254),  --Comments from the customer.
	RANK DOUBLE PRECISION NOT NULL DEFAULT 1,
--	OPTCOUNTER SMALLINT NOT NULL DEFAULT 0,
	CREATE_TIME TIMESTAMP WITHOUT TIME ZONE NOT NULL,
	UPDATE_TIME TIMESTAMP WITHOUT TIME ZONE,
	PRIMARY KEY (ORDERITEM_ID)
);