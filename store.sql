/*---DATABASE---*/
DROP DATABASE IF EXISTS group_buy;
CREATE DATABASE group_buy;

USE group_buy;

/*---TABLE---*/


/*---管理端帳號---*/
CREATE TABLE admin_user(
	aid char(25) NOT NULL DEFAULT '',
	a_name varchar(25) NOT NULL DEFAULT '',
	a_acc varchar(25) NOT NULL DEFAULT '',
	a_pwd char(64) NOT NULL DEFAULT '',
	a_status int(2) NOT NULL DEFAULT 0,
	a_note varchar(255) NOT NULL DEFAULT '',
    tier int(1) NOT NULL DEFAULT 0,
    primary key(aid)
)ENGINE = MyISAM DEFAULT CHARSET = utf8;

INSERT INTO admin_user VALUES
('7414', 'admin', 'admin',  sha2( 'admin', 256), 1, '', 1);

/*---會員階級參考檔---*/
CREATE TABLE member_tier(
	tid int(5) NOT NULL AUTO_INCREMENT,
    tcode varchar(5) NOT NULL DEFAULT '',
    tname varchar(20) NOT NULL DEFAULT '',
    quantity int(10) NOT NULL DEFAULT 0,
    note varchar(100) NOT NULL DEFAULT '',
    primary key(tid)
)ENGINE = MyISAM DEFAULT CHARSET = utf8;

INSERT INTO member_tier (tcode, tname, quantity) VALUES
('00', '未分類', 9999),
('01', 'VIP', 20),
('02', 'NORMAL', 20);

/*---會員---*/
CREATE TABLE members(
	uid char(25) NOT NULL DEFAULT '',
    tid int(5) NOT NULL DEFAULT 0,
	m_acc char(25) NOT NULL DEFAULT '',
	m_pwd char(64) NOT NULL DEFAULT '',
	m_name varchar(15) NOT NULL DEFAULT '',
	m_gender int(5) NOT NULL DEFAULT 0,
	m_birth varchar(10) NOT NULL DEFAULT '',
	m_phone char(10) NOT NULL DEFAULT '',
	m_email char(50) NOT NULL DEFAULT '',
	m_add varchar(50) NOT NULL DEFAULT '',
    b_code char(5) NOT NULL DEFAULT '',
    b_acc varchar(20) NOT NULL DEFAULT '',
    m_status int(1) NOT NULL DEFAULT 0,
    join_date DATETIME NOT NULL DEFAULT 0,
    m_note VARCHAR(100) NOT NULL DEFAULT '',
    primary key(uid)
)ENGINE = MyISAM DEFAULT CHARSET = utf8;

INSERT INTO members VALUES
('ROOT000001', 1, 'root', sha2('root', 256), '根', 1, '2000-01-01', '0900000000', 'a123@gmail.com', '台北市 中山區 復興北路514巷38號', '700', '1234567890', 0, 0, ''),
('54138', 1, 'u123', sha2('u123', 256), '', 1, '', '', '', '', '700', '1234567890', 0, 0, ''); 

/*---異動紀錄---*/
CREATE TABLE goods_record(
	rid int(10) NOT NULL AUTO_INCREMENT,
	gid int(10) NOT NULL DEFAULT 0,
	r_type char(10) NOT NULL DEFAULT '',
	r_desc varchar(150) NOT NULL DEFAULT '',
    r_time DATETIME NOT NULL DEFAULT 0,
    aid char(25) NOT NULL DEFAULT '',
    PRIMARY KEY(rid) 
)ENGINE = MyISAM DEFAULT CHARSET = utf8;

/*---熟飯友---*/
CREATE TABLE know_well(
	uid char(25) NOT NULL DEFAULT '',
	om_autonum int(5) NOT NULL AUTO_INCREMENT,
	om_name varchar(15) NOT NULL DEFAULT '',
	om_phone char(10) NOT NULL DEFAULT '',
	om_add varchar(50) NOT NULL DEFAULT '',
    om_ps varchar(255) NOT NULL DEFAULT '',
    PRIMARY KEY(uid, om_autonum)  
)ENGINE = MyISAM DEFAULT CHARSET = utf8;

INSERT INTO know_well (uid, om_name, om_phone, om_add, om_ps)
VALUES
('ROOT000001', '熟販友A', '0222113336', '台北市 中山區 復興北路514巷38號', '販友收貨位置是公司，週一至週五早上9點~晚上6點可收貨，公司假日無人可代收'),
('ROOT000001', '熟販友B', '0222113336', '台北市 中山區 復興北路514巷38號', '假日可收，警衛代收'),
('ROOT000001', '熟販友C', '0222113336', '台北市 中山區 復興北路514巷38號', ''),
('ROOT000001', '熟販友D', '0222113336', '台北市 中山區 復興北路514巷38號', ''),
('54138', '熟販友A', '0222113336', '台北市 中山區 復興北路514巷38號', '');


/*---購買人清單---*/
CREATE TABLE buyer_list(
	buyer_id int(25) NOT NULL AUTO_INCREMENT,
	b_name varchar(15) NOT NULL DEFAULT '',
	b_add varchar(50) NOT NULL DEFAULT '',
    b_phone char(10) NOT NULL DEFAULT '',
	b_payyes boolean NOT NULL DEFAULT TRUE,
	b_pay varchar(10) NOT NULL DEFAULT '',
	b_note varchar(100) NOT NULL DEFAULT '',
    primary key(buyer_id)
)ENGINE = MyISAM DEFAULT CHARSET = utf8;

INSERT INTO buyer_list(b_name, b_add, b_phone, b_payyes, b_pay, b_note)
VALUES
('蔡小販', '台北市中山區復興北路514巷38號','0225070035', TRUE, 'ATM匯款', '週一～週五早上９點～下午６點可收貨'),
('小販A', '台北市中山區復興北路514巷38號','0225070035', false, 'ATM匯款', '週一～週五早上９點～下午６點可收貨'),
('小販B', '台北市中山區復興北路514巷38號','0225070035', TRUE, 'ATM匯款', '週一～週五早上９點～下午６點可收貨'),
('小販C', '台北市中山區復興北路514巷38號','0225070035', false, 'ATM匯款', '週一～週五早上９點～下午６點可收貨'),
('小販D', '台北市中山區復興北路514巷38號','0225070035', TRUE, 'ATM匯款', '週一～週五早上９點～下午６點可收貨'),
('小販E', '台北市中山區復興北路514巷38號','0225070035', false, 'ATM匯款', '週一～週五早上９點～下午６點可收貨');

/*---訂購商品---*/
CREATE TABLE order_pro(
	ol_id char(25) NOT NULL DEFAULT '',
	gl_id char(12) NOT NULL DEFAULT '',
	lc_autonum int(10) NOT NULL DEFAULT 0,
	buyer_id int(25) NOT NULL DEFAULT 0,
	op_qnt double NOT NULL
)ENGINE = MyISAM DEFAULT CHARSET = utf8;

INSERT INTO order_pro (ol_id, gl_id, lc_autonum, buyer_id, op_qnt)
VALUES
('ABC123123123', 'FA0100050001', 1, 1, 20),
('ABC123123123', 'FA0100050001', 2, 1, 30),
('ABC123123123', 'FA0100050001', 1, 2, 15),
('ABC456456456', 'FA0100050002', 1, 3, 80),
('ABC456456456', 'FA0100050002', 1, 4, 80),
('ABC789789789', 'FA0100050003', 1, 5, 80);

/*---開團單---*/
CREATE TABLE open_list(
	ol_id char(25) NOT NULL DEFAULT '',
    uid char(25) NOT NULL DEFAULT '',
	ol_time DATETIME NOT NULL DEFAULT 0,
	ol_name varchar(25) NOT NULL DEFAULT '',
	ol_cond int(5) NOT NULL DEFAULT 0,
	ol_status int(2) NOT NULL DEFAULT 0,
    ol_orderyes boolean NOT NULL DEFAULT TRUE,
	ol_trafyes boolean NOT NULL DEFAULT TRUE,
    ol_note varchar(100) NOT NULL DEFAULT '',
    primary key(ol_id)
)ENGINE = MyISAM DEFAULT CHARSET = utf8;

INSERT INTO open_list VALUES
('ABC123123123', 'ROOT000001', '2021-09-01 00:00',  '澎湖海鮮冷凍食品(商品任選滿5千元)', 100, 1, false, false, ''),
('ABC123456789', 'ROOT000001', '2021-09-02 00:00',  '一口宜口櫻桃鴨胸10片組', 100, 1, false, false, ''),
('ABC456456456', '54138', '2021-09-03 00:00',  '海鮮冷凍食品(商品任選滿5千元)', 100, 1, false, false, ''),
('ABC789789789', 'ROOT000001', '2021-09-04 00:00',  '澎湖海鮮冷凍食品(商品任選滿5千元)', 100, 2, false, false, ''),
('ABC987654321', 'ROOT000001', '2021-09-05 00:00',  '澎湖海鮮冷凍食品(商品任選滿5千元)', 100, 0, false, TRUE, '');

/*---個人售價---*/
CREATE TABLE personal_price(
	ol_id char(25) NOT NULL DEFAULT '',
	gl_id char(12) NOT NULL DEFAULT '',
	lc_autonum int(10) NOT NULL DEFAULT 0,
	price double NOT NULL DEFAULT 0,
    primary key(ol_id, gl_id, lc_autonum)
)ENGINE = MyISAM DEFAULT CHARSET = utf8;

INSERT INTO personal_price VALUES
('ABC123123123','FA0100050001', 1, 150),
('ABC123123123','FA0100050001', 2, 200),
('ABC123456789','FA0100050002',  1, 180),
('ABC456456456','FA0100050002',  1, 120),
('ABC789789789','FA0100050003',  1, 130),
('ABC987654321','FA0100050004',  1, 140);

/*---清單內容---*/
CREATE TABLE list_cont(
	gl_id char(12) NOT NULL DEFAULT '',
	lc_autonum int(10) NOT NULL AUTO_INCREMENT,
    gid int(10) NOT NULL DEFAULT 0,
	p_name varchar(25) NOT NULL DEFAULT '',
	p_leftqnt double NOT NULL DEFAULT 0,
	p_class varchar(10) NOT NULL DEFAULT '',
	p_place varchar(50) NOT NULL DEFAULT '',
	p_matdate int(5) NOT NULL DEFAULT 0,
	p_destxt varchar(100) NOT NULL DEFAULT '',
	p_imprice double NOT NULL DEFAULT 0,
	p_offprice double NOT NULL DEFAULT 0,
    PRIMARY KEY(gl_id, lc_autonum)
)ENGINE = MyISAM DEFAULT CHARSET = utf8;

INSERT INTO list_cont (gl_id, p_name, gid, p_leftqnt, p_class, p_place, p_matdate, p_destxt, p_imprice, p_offprice)
VALUES
('FA0100050001', 'A1牛排', 1, 30, '食品類', '台灣', '14', '商品介紹文字商品介紹文字商品介紹文字商品介紹文字', 100, 120),
('FA0100050001', 'A2牛排', 2, 30, '食品類', '台灣', '14', '商品介紹文字商品介紹文字商品介紹文字商品介紹文字', 100, 120),
('FA0100050002', 'A3牛排', 3, 30, '食品類', '台灣', '14', '商品介紹文字商品介紹文字商品介紹文字商品介紹文字', 100, 120),
('FA0100050003', 'B1牛排', 4, 30, '食品類', '台灣', '14', '商品介紹文字商品介紹文字商品介紹文字商品介紹文字', 100, 120),
('FA0100050004', 'B1牛排', 4, 30, '食品類', '台灣', '14', '商品介紹文字商品介紹文字商品介紹文字商品介紹文字', 100, 120);

/*---商品---*/
CREATE TABLE goods(
	m_id int(10) NOT NULL DEFAULT 0,
    gid int(10) NOT NULL AUTO_INCREMENT,
	class varchar(10) NOT NULL DEFAULT '',
    gname varchar(25) NOT NULL DEFAULT '',
    ver varchar(20) NOT NULL DEFAULT '',
    matdate int(5) NOT NULL DEFAULT 0,
    themosphere varchar(10) NOT NULL DEFAULT '',
    place varchar(50) NOT NULL DEFAULT '',
    img_path varchar(255) NOT NULL DEFAULT '',
    destxt varchar(100) NOT NULL DEFAULT '',
    stock int(10) NOT NULL DEFAULT 0,
    g_status int(1) NOT NULL DEFAULT 0,
    primary key(gid)
)ENGINE = MyISAM DEFAULT CHARSET = utf8;

INSERT INTO goods 
(m_id, class, gname, ver, matdate, themosphere, place, img_path, destxt, stock, g_status) VALUES
(1, '食品類', 'A1牛排', '', 14, '冷凍', '台灣', '', '商品介紹文字商品介紹文字商品介紹文字商品介紹文字', 30, 1),
(2, '食品類', 'A2牛排', '', 14, '冷凍', '台灣', '', '商品介紹文字商品介紹文字商品介紹文字商品介紹文字', 30, 1),
(1, '食品類', 'A3牛排', '', 14, '冷凍', '台灣', '', '商品介紹文字商品介紹文字商品介紹文字商品介紹文字', 30, 0),
(1, '食品類', 'B1牛排', '', 14, '冷凍', '台灣', '', '商品介紹文字商品介紹文字商品介紹文字商品介紹文字', 30, 1);

/*---廠商階級參考檔---*/
CREATE TABLE goods_tier(
	tid int(5) NOT NULL AUTO_INCREMENT,
    tcode varchar(5) NOT NULL DEFAULT '',
    tname varchar(20) NOT NULL DEFAULT '',
    quantity int(10) NOT NULL DEFAULT 0,
    note varchar(100) NOT NULL DEFAULT '',
    primary key(tid)
)ENGINE = MyISAM DEFAULT CHARSET = utf8;

INSERT INTO goods_tier (tcode, tname, quantity) VALUES
('00', '未分類', 9999),
('01', '食品類', 20),
('02', '生活用品類', 20);

/*---廠商---*/
CREATE TABLE manufacturer(
	m_id int(10) NOT NULL AUTO_INCREMENT,
    tid int(5) NOT NULL DEFAULT 0,
    m_status int(1) NOT NULL DEFAULT 0,
    windows varchar(10) NOT NULL DEFAULT '',
    m_name varchar(20) NOT NULL DEFAULT '',
    phone char(10) NOT NULL DEFAULT '',
    address varchar(50) NOT NULL DEFAULT '',
    b_code char(5) NOT NULL DEFAULT '',
    b_acc varchar(20) NOT NULL DEFAULT '',
    pay_meth varchar(10) NOT NULL DEFAULT '',
    primary key(m_id)
)ENGINE = MyISAM DEFAULT CHARSET = utf8;

INSERT INTO manufacturer (tid, m_status, windows, m_name, phone, address, b_code, b_acc, pay_meth)
VALUES 
(2, 1, '陳小姐', '廠商1', '0900000000', '台北市中山區', '822', '0012345-123456', '付現'),
(2, 1, '林先生', '廠商2', '0900000000', '台北市中山區', '822', '0012345-123456', '付現'),
(2, 0, '馮小姐', '廠商3', '0900000000', '台北市中山區', '822', '0012345-123456', '付現'),
(2, 1, '林先生', '廠商4', '0900000000', '台北市中山區', '822', '0012345-123456', '付現');

/*---廠商階級參考檔---*/
CREATE TABLE manu_tier(
	tid int(5) NOT NULL AUTO_INCREMENT,
    tcode varchar(5) NOT NULL DEFAULT '',
    tname varchar(20) NOT NULL DEFAULT '',
    quantity int(10) NOT NULL DEFAULT 0,
    note varchar(100) NOT NULL DEFAULT '',
    primary key(tid)
)ENGINE = MyISAM DEFAULT CHARSET = utf8;

INSERT INTO manu_tier (tcode, tname, quantity) VALUES
('00', '未分類', 9999),
('01', 'VIP', 20),
('02', 'NORMAL', 20);

/*---團購清單---*/
CREATE TABLE group_list(
	gl_id char(12) NOT NULL DEFAULT '',
	gl_name varchar(25) NOT NULL DEFAULT '',
	succ_way varchar(20) NOT NULL DEFAULT '',
	gl_underqnt int(10) NOT NULL DEFAULT 0,
	gl_transport varchar(10) NOT NULL DEFAULT '',
	gl_stime DATETIME NOT NULL DEFAULT 0,
	gl_etime DATETIME NOT NULL DEFAULT 0,
	gl_dtime varchar(20) NOT NULL DEFAULT '',
	g_status int(1) NOT NULL DEFAULT 0,
    gl_note varchar(100) NOT NULL DEFAULT '',
    primary key(gl_id)
)ENGINE = MyISAM DEFAULT CHARSET = utf8;

INSERT INTO group_list 
VALUES
('FA0100050001', '老神在在瓦甕煨A湯', '滿金額/元', 1000, '冷凍宅配', '2022-12-20 10:00', '2022-12-21 00:00', '下訂後五天出貨', 1, ''),
('FA0100050002', '老神在在瓦甕煨B湯', '滿金額/元', 1000, '冷凍宅配', '2022-12-20 10:00', '2022-12-22 00:00', '下訂後五天出貨', 1, ''),
('FA0100050003', '老神在在瓦甕煨C湯', '滿金額/元', 1000, '冷凍宅配', '2022-12-20 10:00', '2022-12-23 00:00', '下訂後五天出貨', 1, ''),
('FA0100050004', '老神在在瓦甕煨D湯', '滿金額/元', 1000, '冷凍宅配', '2022-12-20 10:00', '2022-12-31 00:00', '下訂後五天出貨', 1, '');

/*---商品許願---*/
CREATE TABLE pro_wish(
	pw_id int(30) NOT NULL AUTO_INCREMENT,
    uid char(25) NOT NULL DEFAULT '',
	pw_destxt varchar(150) NOT NULL DEFAULT '',
	pw_time DATETIME NOT NULL DEFAULT 0,
	pw_picpath varchar(50) NOT NULL DEFAULT '',
    primary key(pw_id)
)ENGINE = MyISAM DEFAULT CHARSET = utf8;

/*---訊息列表---*/
CREATE TABLE message_list(
	ml_class varchar(10) NOT NULL DEFAULT '',
	ml_txt varchar(255) NOT NULL DEFAULT '',
	ml_time DATETIME NOT NULL
)ENGINE = MyISAM DEFAULT CHARSET = utf8;

INSERT INTO message_list VALUES
("新品上架", "1麵食主義者的最愛，牛頭牌乾拌麵系列上架囉！可從查看商品詳細資訊了解商品價格以及商品的成分與介紹。", "2022-01-02 13:06"),
("價格異動", "2麵食主義者的最愛，牛頭牌乾拌麵系列上架囉！可從查看商品詳細資訊了解商品價格以及商品的成分與介紹。", "2022-01-02 13:06"),
("新品上架", "3麵食主義者的最愛，牛頭牌乾拌麵系列上架囉！可從查看商品詳細資訊了解商品價格以及商品的成分與介紹。", "2022-01-02 13:06"),
("款項確認", "4麵食主義者的最愛，牛頭牌乾拌麵系列上架囉！可從查看商品詳細資訊了解商品價格以及商品的成分與介紹。", "2022-01-02 13:06"),
("小販團官方公告", "5麵食主義者的最愛，牛頭牌乾拌麵系列上架囉！可從查看商品詳細資訊了解商品價格以及商品的成分與介紹。", "2022-01-02 13:06"),
("新品上架", "6麵食主義者的最愛，牛頭牌乾拌麵系列上架囉！可從查看商品詳細資訊了解商品價格以及商品的成分與介紹。", "2022-01-02 13:06"),
("價格異動", "7麵食主義者的最愛，牛頭牌乾拌麵系列上架囉！可從查看商品詳細資訊了解商品價格以及商品的成分與介紹。", "2022-01-02 13:06"),
("新品上架", "8麵食主義者的最愛，牛頭牌乾拌麵系列上架囉！可從查看商品詳細資訊了解商品價格以及商品的成分與介紹。", "2022-01-02 13:06"),
("款項確認", "9麵食主義者的最愛，牛頭牌乾拌麵系列上架囉！可從查看商品詳細資訊了解商品價格以及商品的成分與介紹。", "2022-01-02 13:06");



