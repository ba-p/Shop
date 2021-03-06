-- show databases;
-- drop database NLCS;
-- create database NLCS;
-- use NLCS;

create table hang(
	id_hang varchar(50) primary key,
    ten_hang varchar(50) not null,
    img varchar(200) not null
);
create table loai(
	id_loai varchar(50) primary key,
    ten_loai varchar(50) not null,
    id_hang varchar(50) references hang(id_hang)
);
create table san_pham(
	id_sp varchar(50) primary key,
    ten_sp varchar(50) not null,
    id_loai varchar(50) not null references hang(id_loai),
    id_tt varchar(50) references thong_tin(id_tt),
    mo_ta varchar(2000)
);
create table chi_tiet_sp(
	id_chitiet varchar(50) primary key,
	dung_luong varchar(50),
    gia float default 0 check (gia >=0),
    id_sp varchar(50) not null references san_pham(id_sp)
);
create table mau_sac(
	id_mau varchar(50) primary key,
    mau varchar(50) not null,
    anh varchar(200) not null,
    id_sp varchar(50) not null references san_pham(id_sp)
);
create table thong_tin(
	id_tt varchar(50) primary key,
    cn_man varchar(100),
    do_phan_giai varchar(100),
    kich_thuoc varchar(100),
    do_sang varchar(100),
    mat_kinh varchar(100),
    camera_sau varchar(100),
	den_flash varchar(100),
    camera_truoc varchar(100),
    he_dieu_hanh varchar(100),
    CPU varchar(100),
    GPU varchar(100),
    ram varchar(100),
    mang_di_dong varchar(100),
    sim varchar(100),
    wifi varchar(100),
    bluetooth varchar(100),
    cong_sac varchar(100),
    ket_noi_khac varchar(100),
    dung_luong_pin varchar(100),
    loai_pin varchar(100),
    toc_do_sac varchar(100),
    cong_nghe_pin varchar(100)
);
create table Bill(
	id_bill varchar(50) primary key,
    sdt varchar(11) not null,
	ho_ten varchar(50) not null,
    dia_chi varchar(500) not null,
    ngay_lap timestamp default current_timestamp
);
create table chi_tiet_bill(
	id_ctbill int primary key AUTO_INCREMENT,
    id_chitiet varchar(50) references chi_tiet_sp(id_chitiet),
    id_mau varchar(50) not null references mau_sac(id_mau),
    amount numeric(10) default 0 check (amount >=0),
    price float default 0 check (price >=0),
    id_bill varchar(50) not null references bill(id_bill)
);


delimiter //
create procedure addBill(
    id_bill varchar(50),
    sdt varchar(11),
    ho_ten varchar(50),
    dia_chi varchar(500))
begin
	insert into bill(id_bill,sdt,ho_ten,dia_chi) value(id_bill,sdt,ho_ten,dia_chi);
    commit;
end//
delimiter ;

delimiter //
create procedure addCTBill(
    id_sp varchar(50),
    dung_luong varchar(50),
    mau_sac varchar(50),
    amount numeric(10),
	id_bill varchar(50))
begin
	insert into chi_tiet_bill(id_chitiet,id_mau,amount, price,id_bill) 
    value(
    (select c.id_chitiet from  san_pham s join chi_tiet_sp c on s.id_sp = c.id_sp where s.id_sp = id_sp and c.dung_luong = dung_luong),
    (select m.id_mau from  san_pham s join mau_sac m on s.id_sp = m.id_sp where s.id_sp = id_sp and m.mau = mau_sac),
    amount,
    (select c.gia from  san_pham s join chi_tiet_sp c on s.id_sp = c.id_sp where s.id_sp = id_sp and c.dung_luong = dung_luong) * amount,
    id_bill);
    commit;
end//
delimiter ;

-- create table Total_Bill(
-- 	id_total_bill varchar(50) primary key,
--     id_bill varchar(50) references bill(id_bill),   
--     account_customer varchar(50) references customer(account),
--     date date not null,
-- 	total_price float default 0 check (total_price >=0)
-- );
-- create table Customer(
-- 	account varchar(50) primary key,
--     password varchar(50) not null,
--     name_customer varchar(50) not null,
--     gender varchar(6) not null,
--     birthDay date not null,
--     phone numeric(11) not null,
--     address varchar(100) not null,
--     isAdmin numeric(1) not null
-- );

-- insert data
-- insert hang
insert into hang values("apple","Apple","img");
insert into hang values("samsung","Samsung","img");
insert into hang values("oppo","OPPO","img");
insert into hang values("xiaomi","Xiaomi","img");
insert into hang values("vivo","VIVO","img");

-- insert loai
insert into loai values("iphone","Phones","apple");
insert into loai values("ipad","Tablet","apple");
insert into loai values("airpod","Headphone","apple");
insert into loai values("applewatch","Watch","apple");

insert into loai values("ss","Phones","samsung");
insert into loai values("sstab","Tablet","samsung");
insert into loai values("ssbud","Headphone","samsung");
insert into loai values("glxwatch","Watch","samsung");

insert into loai values("opo","Phones","oppo");
insert into loai values("oppobud","Headphone","oppo");
insert into loai values("oppowatch","Watch","oppo");

insert into loai values("mi","Phones","xiaomi");
-- insert into loai values("tablet","Tablet","oppo");
-- insert into loai values("airpod","Headphone","oppo");

insert into loai values("vv","Phones","vivo");
-- insert into loai values("tablet","Tablet","oppo");
-- insert into loai values("airpod","Headphone","oppo");
-- insert thong tin
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("iphone13promax", "OLED", "1284 x 2778 Pixels", "6.7' - T???n s??? qu??t 120 Hz", "1200 nits ", "K??nh c?????ng l???c Ceramic Shield", "3 camera 12 MP",
		"C??", "12MP", "iOS 15", "Apple A15 Bionic 6 nh??n 3.22 GHz", "Apple GPU 5 nh??n", "6GB", "H??? tr??? 5G", "1 Nano SIM & 1 eSIM",
        "Wi-Fi 802.11 a/b/g/n/ac/ax", "v5.0", "Lightning", "NFC", "4352 mAh", "Li-lon", "20 W", "S???c kh??ng d??y MagSafe" );
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("iphonese2022", "IPS LCD", "HD (750 x 1334 Pixels)", "4.7' - T???n s??? qu??t 60 Hz", "625 nits ", "??ang c???p nh???t", "12 MP",
		"C??", "7MP", "iOS 15", "Apple A15 Bionic 6 nh??n", "??ang c???p nh???t", "3GB", "H??? tr??? 5G", "1 Nano SIM & 1 eSIM",
        "Wi-Fi 802.11 a/b/g/n/ac/ax", "v5.0", "Lightning", "NFC", "??ang c???p nh???t", "Li-lon", "20 W", "S???c kh??ng d??y" );
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("iphone13", "OLED", "1170 x 2532 Pixels", "6.1' - T???n s??? qu??t 60 Hz", "1200 nits ", "K??nh c?????ng l???c Ceramic Shield", "2 camera 12 MP",
		"C??", "12MP", "iOS 15", "Apple A15 Bionic 6 nh??n 3.22 GHz", "Apple GPU 4 nh??n", "4GB", "H??? tr??? 5G", "1 Nano SIM & 1 eSIM",
        "Wi-Fi 802.11 a/b/g/n/ac/ax", "v5.0", "Lightning", "NFC", "3240 mAh", "Li-lon", "20 W", "S???c kh??ng d??y MagSafe" );

insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("iphone13mini", "OLED", "1080 x 2340 Pixels", "5.4' - T???n s??? qu??t 60 Hz", "1200 nits ", "K??nh c?????ng l???c Ceramic Shield", "2 camera 12 MP",
		"C??", "12MP", "iOS 15", "Apple A15 Bionic 6 nh??n 3.22 GHz", "Apple GPU 4 nh??n", "4GB", "H??? tr??? 5G", "1 Nano SIM & 1 eSIM",
        "Wi-Fi 802.11 a/b/g/n/ac/ax", "v5.0", "Lightning", "NFC", "2438 mAh", "Li-lon", "20 W", "S???c kh??ng d??y MagSafe" );

insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("iphone12", "OLED", "1170 x 2532 Pixels", "6.1' - T???n s??? qu??t 60 Hz", "1200 nits ", "K??nh c?????ng l???c Ceramic Shield", "2 camera 12 MP",
		"C??", "12MP", "iOS 15", "Apple A14 Bionic 6 nh??n", "Apple GPU 4 nh??n", "4GB", "H??? tr??? 5G", "1 Nano SIM & 1 eSIM",
        "Wi-Fi 802.11 a/b/g/n/ac/ax", "v5.0", "Lightning", "NFC", "2815 mAh", "Li-lon", "20 W", "S???c kh??ng d??y MagSafe" );

insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("iphone13pro", "OLED", "1170 x 2532 Pixels", "6.1' - T???n s??? qu??t 120 Hz", "1200 nits ", "K??nh c?????ng l???c Ceramic Shield", "3 camera 12 MP",
		"C??", "12MP", "iOS 15", "Apple A15 Bionic 6 nh??n 3.22 GHz", "Apple GPU 5 nh??n", "6GB", "H??? tr??? 5G", "1 Nano SIM & 1 eSIM",
        "Wi-Fi 802.11 a/b/g/n/ac/ax", "v5.0", "Lightning", "NFC", "3095 mAh", "Li-lon", "20 W", "S???c kh??ng d??y MagSafe" );
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("iphone11", "IPS LCD", "828 x 1792 Pixels", "6.1' - T???n s??? qu??t 60 Hz", "625 nits ", "K??nh c?????ng l???c Oleophobic (ion c?????ng l???c)", "2 camera 12 MP",
		"3 ????n LED 2 t??ng m??u", "12MP", "iOS 15", "Apple A13 Bionic 6 nh??n", "Apple GPU 4 nh??n", "4GB", "H??? tr??? 4G", "1 Nano SIM & 1 eSIM",
        "Wi-Fi 802.11 a/b/g/n/ac/ax", "v5.0", "Lightning", "NFC, OTG", "3110 mAh", "Li-lon", "18 W", "S???c kh??ng d??y" );

insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("iphonexr", "IPS LCD", "828 x 1792 Pixels", "6.1' - T???n s??? qu??t 60 Hz", "625 nits ", "K??nh c?????ng l???c Oleophobic (ion c?????ng l???c)", "12 MP",
		"4 ????n LED 2 t??ng m??u", "7MP", "iOS 15", "Apple A12 Bionic 6 nh??n", "Apple GPU 4 nh??n", "3GB", "H??? tr??? 4G", "1 Nano SIM & 1 eSIM",
        "Wi-Fi 802.11 a/b/g/n/ac/ax", "v5.0", "Lightning", "NFC", "2942 mAh", "Li-lon", "18 W", "S???c kh??ng d??y" );

insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("zfold3", "Dynamic AMOLED 2X", "Full HD+ (1768 x 2208 Pixels)", "Ch??nh 7.6' & Ph??? 6.2' - T???n s??? qu??t 120 Hz", "Ch??nh 1200 nits & Ph??? 1500 nits", "K??nh c?????ng l???c Corning Gorilla Glass Victus", "3 camera 12 MP",
		"C??", "10 MP & 4 MP", "Android 11", "Snapdragon 888 8 nh??n", "Adreno 660", "12GB", "H??? tr??? 5G", "2 Nano SIM & 1 eSIM",
        "Wi-Fi 802.11 a/b/g/n/ac/ax", "v5.2", "Type-C", "NFC, OTG", "4400 mAh", "Li-lon", "25 W", "S???c kh??ng d??y, s???c ng?????c kh??ng d??y" );

insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("zflip", "Dynamic AMOLED 2X", "Full HD+ (1080 x 2640 Pixels)", "Ch??nh 6.7' & Ph??? 1.9' - T???n s??? qu??t 120 Hz", "Ch??nh 1200 nits", "K??nh si??u m???ng Ultra Thin Glass (UTG)", "2 camera 12 MP",
		"C??", "10 MP & 4 MP", "Android 11", "Snapdragon 888 8 nh??n", "Adreno 660", "8GB", "H??? tr??? 5G", "1 Nano SIM & 1 eSIM",
        "Wi-Fi 802.11 a/b/g/n/ac/ax", "v5.2", "Type-C", "NFC, OTG", "3300 mAh", "Li-lon", "15 W", "S???c kh??ng d??y, s???c ng?????c kh??ng d??y" );

insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("s22ultra", "Dynamic AMOLED 2X", "Quad HD+ (2K+) (1440 x 3088 Pixels)", "6.8' - T???n s??? qu??t 120 Hz", "1750 nits", "K??nh c?????ng l???c Corning Gorilla Glass Victus+", "Ch??nh 108 MP & Ph??? 12 MP, 10 MP, 10 MP",
		"????n LED k??p", "40 MP", "Android 12", "Snapdragon 8 Gen 1 8 nh??n", "Adreno 730", "8GB", "H??? tr??? 5G", "2 Nano SIM ho???c 1 Nano SIM + 1 eSIM",
        "Wi-Fi 802.11 a/b/g/n/ac/ax", "v5.2", "Type-C", "NFC, OTG", "5000 mAh", "Li-lon", "45 W", "S???c kh??ng d??y, s???c ng?????c kh??ng d??y" );
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("s22+", "Dynamic AMOLED 2X", "Full HD+ (1080 x 2340 Pixels)", "6.6' - T???n s??? qu??t 120 Hz", "1750 nits", "K??nh c?????ng l???c Corning Gorilla Glass Victus+", "Ch??nh 50 MP & Ph??? 12 MP, 10 MP",
		"????n LED k??p", "10 MP", "Android 12", "Snapdragon 8 Gen 1 8 nh??n", "Adreno 730", "8GB", "H??? tr??? 5G", "2 Nano SIM ho???c 1 Nano SIM + 1 eSIM",
        "Wi-Fi 802.11 a/b/g/n/ac/ax", "v5.2", "Type-C", "NFC, OTG", "4500 mAh", "Li-lon", "45 W", "S???c kh??ng d??y, s???c ng?????c kh??ng d??y" );
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("s22", "Dynamic AMOLED 2X", "Full HD+ (1080 x 2340 Pixels)", "6.1' - T???n s??? qu??t 120 Hz", "1750 nits", "K??nh c?????ng l???c Corning Gorilla Glass Victus+", "Ch??nh 50 MP & Ph??? 12 MP, 10 MP",
		"????n LED k??p", "10 MP", "Android 12", "Snapdragon 8 Gen 1 8 nh??n", "Adreno 730", "8GB", "H??? tr??? 5G", "2 Nano SIM ho???c 1 Nano SIM + 1 eSIM",
        "Wi-Fi 802.11 a/b/g/n/ac/ax", "v5.2", "Type-C", "NFC, OTG", "3700 mAh", "Li-lon", "25 W", "S???c kh??ng d??y, s???c ng?????c kh??ng d??y" );
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("s21fe", "Dynamic AMOLED 2X", "Full HD+ (1080 x 2340 Pixels)", "6.4' - T???n s??? qu??t 120 Hz", "1200 nits", "K??nh c?????ng l???c Corning Gorilla Glass Victus", "Ch??nh 12 MP & Ph??? 12 MP, 8 MP",
		"C??", "32 MP", "Android 12", "Exynos 2100 8 nh??n", "Mali-G78 MP14", "6GB", "H??? tr??? 5G", "2 Nano SIM",
        "Wi-Fi 802.11 a/b/g/n/ac/ax", "v5.0", "Type-C", "NFC, OTG", "4500 mAh", "Li-lon", "25 W", "S???c kh??ng d??y, s???c ng?????c kh??ng d??y" );

insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("m53", "Super AMOLED Plus", "Full HD+ (1080 x 2400 Pixels)", "6.7' - T???n s??? qu??t 120 Hz", "??ang c???p nh???t", "K??nh c?????ng l???c Corning Gorilla Glass 5", "Ch??nh 108 MP & Ph??? 8 MP, 2 MP, 2 MP",
		"C??", "32 MP", "Android 12", "MediaTek Dimensity 900 5G", "Mali-G68", "8GB", "H??? tr??? 5G", "2 Nano SIM (SIM 2 chung khe th??? nh???)",
        "Wi-Fi 802.11 a/b/g/n/ac", "v5.0", "Type-C", "NFC", "5000 mAh", "Li-lon", "25 W", "S???c pin nhanh" );
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("a73", "Super AMOLED Plus", "Full HD+ (1080 x 2400 Pixels)", "6.7' - T???n s??? qu??t 120 Hz", "800 nits", "K??nh c?????ng l???c Corning Gorilla Glass 5", "Ch??nh 108 MP & Ph??? 12 MP, 5 MP, 5 MP",
		"C??", "32 MP", "Android 12", "Snapdragon 778G 5G 8 nh??n", "Adreno 642L", "8GB", "H??? tr??? 5G", "2 Nano SIM (SIM 2 chung khe th??? nh???)",
        "Wi-Fi 802.11 a/b/g/n/ac", "v5.1", "Type-C", "NFC", "5000 mAh", "Li-lon", "25 W", "S???c pin nhanh" );

insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("a53", "Super AMOLED Plus", "Full HD+ (1080 x 2400 Pixels)", "6.5' - T???n s??? qu??t 120 Hz", "800 nits", "K??nh c?????ng l???c Corning Gorilla Glass 5", "Ch??nh 64 MP & Ph??? 12 MP, 5 MP, 5 MP",
		"C??", "32 MP", "Android 12", "Exynos 1280 8 nh??n", "Mali-G68", "8GB", "H??? tr??? 5G", "2 Nano SIM (SIM 2 chung khe th??? nh???)",
        "Wi-Fi 802.11 a/b/g/n/ac", "v5.1", "Type-C", "NFC", "5000 mAh", "Li-lon", "25 W", "S???c pin nhanh" );
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("a33", "Super AMOLED Plus", "Full HD+ (1080 x 2400 Pixels)", "6.4' - T???n s??? qu??t 90 Hz", "800 nits", "K??nh c?????ng l???c Corning Gorilla Glass 5", "Ch??nh 48 MP & Ph??? 8 MP, 5 MP, 2 MP",
		"C??", "13 MP", "Android 12", "Exynos 1280 8 nh??n", "Mali-G68", "6GB", "H??? tr??? 5G", "2 Nano SIM (SIM 2 chung khe th??? nh???)",
        "Wi-Fi 802.11 a/b/g/n/ac", "v5.1", "Type-C", "NFC", "5000 mAh", "Li-lon", "25 W", "S???c pin nhanh" );
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("findx5pro", "AMOLED", "Quad HD+ (2K+) (1440 x 3216 Pixels)", "6.7' - T???n s??? qu??t 120 Hz", "Ch??a c???p nh???t", "K??nh c?????ng l???c Corning Gorilla Glass Victus", "Ch??nh 50 MP & Ph??? 50 MP, 13 MP",
		"????n LED k??p", "32 MP", "Android 12", "Snapdragon 8 Gen 1 8 nh??n", "Adreno 730", "8GB", "H??? tr??? 5G", "2 Nano SIM ho???c 1 Nano SIM + 1 eSIM",
        "Wi-Fi 802.11 a/b/g/n/ac/ax, Wi-Fi MIMO", "v5.2", "Type-C", "NFC, OTG", "5000 mAh", "Li-lon", "80 W", "S???c kh??ng d??y, s???c si??u nhanh SuperVOOC" );

insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("reno7z", "AMOLED", "Full HD+ (1080 x 2400 Pixels)", "6.43' - T???n s??? qu??t 60 Hz", "600 nits", "K??nh c?????ng l???c Schott Xensation UP", "Ch??nh 64 MP & Ph??? 2 MP, 2 MP",
		"C??", "16 MP", "Android 11", "Snapdragon 695 5G 8 nh??n", "Adreno 619", "8GB", "H??? tr??? 5G", "2 Nano SIM (SIM 2 chung khe th??? nh???)",
        "Wi-Fi 802.11 a/b/g/n/ac", "v5.1", "Type-C", "NFC", "4500 mAh", "Li-lon", "33 W", "S???c si??u nhanh SuperVOOC" );
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("reno7pro", "AMOLED", "Full HD+ (1080 x 2400 Pixels)", "6.5' - T???n s??? qu??t 90 Hz", "920 nits", "K??nh c?????ng l???c Corning Gorilla Glass 5", "Ch??nh 50 MP & Ph??? 8 MP, 2 MP",
		"C??", "32 MP", "Android 11", "MediaTek Dimensity 1200 Max 8 nh??n", "Mali-G77 MC9", "12GB", "H??? tr??? 5G", "2 Nano SIM",
        "Wi-Fi 802.11 a/b/g/n/ac", "v5.2", "Type-C", "NFC", "4500 mAh", "Li-lon", "65 W", "S???c si??u nhanh SuperVOOC 2.0" );
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("reno7", "AMOLED", "Full HD+ (1080 x 2400 Pixels)", "6.4' - T???n s??? qu??t 90 Hz", "1000 nits", "800", "Ch??nh 12 MP & Ph??? 10 MP, TOF 3D LiDAR",
		"C??", "32 MP", "Android 11", "MediaTek Dimensity 900 5G", "Mali-G68 MC4", "8GB", "H??? tr??? 5G", "2 Nano SIM",
        "Wi-Fi 802.11 a/b/g/n/ac", "v5.2", "Type-C", "NFC", "4500 mAh", "Li-lon", "65 W", "S???c si??u nhanh SuperVOOC" );
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("pro12.9", "Liquid Retina XDR mini-LED LCD", "2048 x 2732 Pixels", "12.9' - T???n s??? qu??t 120 Hz", "??ang c???p nh???t", "??ang c???p nh???t", "Ch??nh 12 MP & Ph??? 10 MP, TOF 3D LiDAR",
		"C??", "12 MP", "iPadOS 15", "Apple M1 8 nh??n", "Apple GPU 8 nh??n", "8GB", "H??? tr??? 5G", "1 Nano SIM ho???c 1 eSIM",
        "Wi-Fi 802.11 a/b/g/n/ac", "v5.0", "Type-C", "K???t n???i Apple Pencil 2 & Magic Keyboard, Nam ch??m & s???c cho Apple Pencil", "40.88 Wh (~ 10.835 mAh)", "Li-Po", "20 W", "S???c pin nhanh, ti???t ki???m pin" );
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("pro12.9wifi", "Liquid Retina XDR mini-LED LCD", "2048 x 2732 Pixels", "12.9' - T???n s??? qu??t 120 Hz", "??ang c???p nh???t", "??ang c???p nh???t", "Ch??nh 12 MP & Ph??? 10 MP, TOF 3D LiDAR",
		"C??", "12 MP", "iPadOS 15", "Apple M1 8 nh??n", "Apple GPU 8 nh??n", "8GB", "Kh??ng h??? tr???", "Kh??ng h??? tr???",
        "Wi-Fi 802.11 a/b/g/n/ac", "v5.0", "Type-C", "K???t n???i Apple Pencil 2 & Magic Keyboard, Nam ch??m & s???c cho Apple Pencil", "40.88 Wh (~ 10.835 mAh)", "Li-Po", "20 W", "S???c pin nhanh, ti???t ki???m pin" );
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("pro11", "Liquid Retina", "1668 x 2388 Pixels", "11' - T???n s??? qu??t 120 Hz", "??ang c???p nh???t", "??ang c???p nh???t", "Ch??nh 12 MP & Ph??? 10 MP, TOF 3D LiDAR",
		"C??", "12 MP", "iPadOS 15", "Apple M1 8 nh??n", "Apple GPU 8 nh??n", "8GB", "H??? tr??? 5G", "1 Nano SIM ho???c 1 eSIM",
        "Wi-Fi 802.11 a/b/g/n/ac", "v5.0", "Type-C", "K???t n???i Apple Pencil 2 & Magic Keyboard, Nam ch??m & s???c cho Apple Pencil", "28.65 Wh (~ 7538 mAh)", "Li-Po", "20 W", "S???c pin nhanh, ti???t ki???m pin" );
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("pro11wifi", "Liquid Retina", "1668 x 2388 Pixels", "11' - T???n s??? qu??t 120 Hz", "??ang c???p nh???t", "??ang c???p nh???t", "Ch??nh 12 MP & Ph??? 10 MP, TOF 3D LiDAR",
		"C??", "12 MP", "iPadOS 15", "Apple M1 8 nh??n", "Apple GPU 8 nh??n", "8GB", "Kh??ng h??? tr???", "Kh??ng h??? tr???",
        "Wi-Fi 802.11 a/b/g/n/ac", "v5.0", "Type-C", "K???t n???i Apple Pencil 2 & Magic Keyboard, Nam ch??m & s???c cho Apple Pencil", "28.65 Wh (~ 7538 mAh)", "Li-Po", "20 W", "S???c pin nhanh, ti???t ki???m pin" );

insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("air5", "Liquid IPS LCD", "1640 x 2360 Pixels", "10.9' - T???n s??? qu??t 60 Hz", "??ang c???p nh???t", "??ang c???p nh???t", "12 MP",
		"C??", "12 MP", "iPadOS 15", "Apple M1 8 nh??n", "Apple GPU 8 nh??n", "8GB", "H??? tr??? 5G", "1 Nano SIM ho???c 1 eSIM",
        "Wi-Fi 802.11 a/b/g/n/ac", "v5.0", "Type-C", "K???t n???i Apple Pencil 2 & Magic Keyboard, Nam ch??m & s???c cho Apple Pencil", "28.6 Wh (~ 7587 mAh)", "Li-Po", "20 W", "S???c pin nhanh, ti???t ki???m pin" );
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("air5wifi", "Liquid IPS LCD", "1640 x 2360 Pixels", "10.9' - T???n s??? qu??t 60 Hz", "??ang c???p nh???t", "??ang c???p nh???t", "12 MP",
		"C??", "12 MP", "iPadOS 15", "Apple M1 8 nh??n", "Apple GPU 8 nh??n", "8GB", "Kh??ng h??? tr???", "Kh??ng h??? tr???",
        "Wi-Fi 802.11 a/b/g/n/ac", "v5.0", "Type-C", "K???t n???i Apple Pencil 2 & Magic Keyboard, Nam ch??m & s???c cho Apple Pencil", "28.6 Wh (~ 7587 mAh)", "Li-Po", "20 W", "S???c pin nhanh, ti???t ki???m pin" );
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("mini6", "LED-backlit IPS LCD", "1488 x 2266 Pixels", "8.3' - T???n s??? qu??t 60 Hz", "??ang c???p nh???t", "??ang c???p nh???t", "12 MP",
		"C??", "12 MP", "iPadOS 15", "Apple A15 Bionic 6 nh??n", "Apple GPU 5 nh??n", "4GB", "H??? tr??? 5G", "1 Nano SIM ho???c 1 eSIM",
        "Wi-Fi 802.11 a/b/g/n/ac", "v5.0", "Type-C", "K???t n???i Apple Pencil 2, Nam ch??m & s???c cho Apple Pencil", "19.3 Wh", "Li-Po", "20 W", "S???c pin nhanh, ti???t ki???m pin" );
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("mini6wifi", "LED-backlit IPS LCD", "1488 x 2266 Pixels", "8.3' - T???n s??? qu??t 60 Hz", "??ang c???p nh???t", "??ang c???p nh???t", "12 MP",
		"C??", "12 MP", "iPadOS 15", "Apple A15 Bionic 6 nh??n", "Apple GPU 5 nh??n", "4GB", "Kh??ng h??? tr???", "Kh??ng h??? tr???",
        "Wi-Fi 802.11 a/b/g/n/ac", "v5.0", "Type-C", "K???t n???i Apple Pencil 2, Nam ch??m & s???c cho Apple Pencil", "19.3 Wh", "Li-Po", "20 W", "S???c pin nhanh, ti???t ki???m pin" );
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("tabs8ultra", "Super AMOLED", "1848 x 2960 Pixels", "14' - T???n s??? qu??t 120 Hz", "??ang c???p nh???t", "K??nh c?????ng l???c Corning Gorilla Glass 5", "Ch??nh 13 MP & Ph??? 6 MP",
		"C??", "12 MP", "Android 12", "Snapdragon 8 Gen 1 8 nh??n", "Adreno 730", "8GB", "H??? tr??? 5G", "1 Nano SIM",
        "MIMO, Wi-Fi 802.11 a/b/g/n/ac/ax", "v5.2", "Type-C", "Samsung DeX (Giao di???n t????ng t??? PC)", "11200 mAh", "Li-Po", "45 W", "S???c pin nhanh, ti???t ki???m pin" );

insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("mi12", "AMOLED", "Full HD+ (1080 x 2400 Pixels)", "6.28' - T???n s??? qu??t 120 Hz", "1100", "K??nh c?????ng l???c Corning Gorilla Glass Victus", "Ch??nh 50 MP & Ph??? 13 MP, 5 MP",
		"C??", "32 MP", "Android 12", "Snapdragon 8 Gen 1 8 nh??n", "Adreno 730", "8GB", "H??? tr??? 5G", "2 Nano SIM",
        "Wi-Fi 802.11 a/b/g/n/ac/ax", "v5.2", "Type-C", "NFC, H???ng ngo???i", "4500 mAh", "Li-lon", "67 W", "S???c kh??ng d??y, s???c ng?????c kh??ng d??y");
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("mi12pro", "AMOLED", "2K+ (1440 x 3200 Pixels)", "6.73' - T???n s??? qu??t 120 Hz", "1500", "K??nh c?????ng l???c Corning Gorilla Glass Victus", "3 camera 50 MP",
		"C??", "32 MP", "Android 12", "Snapdragon 8 Gen 1 8 nh??n", "Adreno 730", "12GB", "H??? tr??? 5G", "2 Nano SIM",
        "Wi-Fi 802.11 a/b/g/n/ac/ax", "v5.2", "Type-C", "NFC, H???ng ngo???i", "4600 mAh", "Li-lon", "120 W", "S???c kh??ng d??y, s???c ng?????c kh??ng d??y");
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("vvv23", "AMOLED", "Full HD+ (1080 x 2400 Pixels)", "6.44' - T???n s??? qu??t 90 Hz", "600", "K??nh c?????ng l???c Corning Gorilla Glass", "Ch??nh 64 MP & Ph??? 8 MP, 2 MP",
		"C??", "Ch??nh 50 MP & Ph??? 8 MP", "Android 12", "MediaTek Dimensity 920 5G 8 nh??n", "Mali-G68 MC4", "8GB", "H??? tr??? 5G", "2 Nano SIM",
        "Wi-Fi 802.11 a/b/g/n/ac/ax", "v5.2", "Type-C", "NFC", "4200 mAh", "Li-Po", "44 W", "S???c kh??ng d??y");
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("aw745mm", "OLED", "484 x 396 Pixels", "1.77'", "1000 nits", "Ion-X strengthened glass", "Kh??ng h??? tr???",
		"Kh??ng h??? tr???", "Kh??ng h??? tr???", "watchOS 8.0", "Apple S7", "PowerVR", "??ang c???p nh???t", "H??? tr??? LTE", "H??? tr??? eSIM",
        "C?? h??? tr???", "v5.0", "????? s???c nam ch??m", "GPS", "303.8 mAh", "??ang c???p nh???t", "??ang c???p nh???t", "S???c kh??ng d??y");
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("aw745mmwifi", "OLED", "484 x 396 Pixels", "1.77'", "1000 nits", "Ion-X strengthened glass", "Kh??ng h??? tr???",
		"Kh??ng h??? tr???", "Kh??ng h??? tr???", "watchOS 8.0", "Apple S7", "PowerVR", "??ang c???p nh???t", "Kh??ng h??? tr???", "Kh??ng h??? tr???",
        "C?? h??? tr???", "v5.0", "????? s???c nam ch??m", "GPS", "303.8 mAh", "??ang c???p nh???t", "??ang c???p nh???t", "S???c kh??ng d??y");
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("aw741mm", "OLED", "484 x 396 Pixels", "1.61'", "1000 nits", "Ion-X strengthened glass", "Kh??ng h??? tr???",
		"Kh??ng h??? tr???", "Kh??ng h??? tr???", "watchOS 8.0", "Apple S7", "PowerVR", "??ang c???p nh???t", "H??? tr??? LTE", "H??? tr??? eSIM",
        "C?? h??? tr???", "v5.0", "????? s???c nam ch??m", "GPS", "265.9 mAh", "??ang c???p nh???t", "??ang c???p nh???t", "S???c kh??ng d??y");
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("aw741mmwifi", "OLED", "484 x 396 Pixels", "1.61'", "1000 nits", "Ion-X strengthened glass", "Kh??ng h??? tr???",
		"Kh??ng h??? tr???", "Kh??ng h??? tr???", "watchOS 8.0", "Apple S7", "PowerVR", "??ang c???p nh???t", "Kh??ng h??? tr???", "Kh??ng h??? tr???",
        "C?? h??? tr???", "v5.0", "????? s???c nam ch??m", "GPS", "265.9 mAh", "??ang c???p nh???t", "??ang c???p nh???t", "S???c kh??ng d??y");
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("swactive244mm", "SUPER AMOLED", "360 x 360 Pixels", "1.4'", "??ang c???p nh???t", "K??nh c?????ng l???c Gorrilla Glass Dx+", "Kh??ng h??? tr???",
		"Kh??ng h??? tr???", "Kh??ng h??? tr???", "Tizen OS 5.5", "Exynos 9110 (10 nm)", "Mali-T720", "1.5GB RAM", "H??? tr??? LTE", "H??? tr??? eSIM",
        "C?? h??? tr???", "v5.0", "????? s???c nam ch??m", "GPS, NFC", "340 mAh", "Li-Ion", "??ang c???p nh???t", "S???c kh??ng d??y");

insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("sw4cl46mm", "SUPER AMOLED", "450 x 450 Pixels", "1.36'", "??ang c???p nh???t", "K??nh c?????ng l???c Gorrilla Glass Dx+", "Kh??ng h??? tr???",
		"Kh??ng h??? tr???", "Kh??ng h??? tr???", "Android Wear OS, One UI Watch 3", "Exynos W920 (5 nm)", "Mali-G68", "1.5GB RAM", "H??? tr??? LTE", "H??? tr??? eSIM",
        "C?? h??? tr???", "v5.0", "????? s???c nam ch??m", "GPS, NFC", "340 mAh", "Li-Ion", "??ang c???p nh???t", "S???c kh??ng d??y");
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("sw4cl42mm", "SUPER AMOLED", "396 x 396 Pixels", "1.19'", "??ang c???p nh???t", "K??nh c?????ng l???c Gorrilla Glass Dx+", "Kh??ng h??? tr???",
		"Kh??ng h??? tr???", "Kh??ng h??? tr???", "Android Wear OS, One UI Watch 3", "Exynos W920 (5 nm)", "Mali-G68", "1.5GB RAM", "H??? tr??? LTE", "H??? tr??? eSIM",
        "C?? h??? tr???", "v5.0", "????? s???c nam ch??m", "GPS, NFC", "247 mAh", "Li-Ion", "??ang c???p nh???t", "S???c kh??ng d??y");
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("sw4cl46mmwifi", "SUPER AMOLED", "450 x 450 Pixels", "1.36'", "??ang c???p nh???t", "K??nh c?????ng l???c Gorrilla Glass Dx+", "Kh??ng h??? tr???",
		"Kh??ng h??? tr???", "Kh??ng h??? tr???", "Android Wear OS, One UI Watch 3", "Exynos W920 (5 nm)", "Mali-G68", "1.5GB RAM", "Kh??ng h??? tr???", "Kh??ng h??? tr???",
        "C?? h??? tr???", "v5.0", "????? s???c nam ch??m", "GPS, NFC", "340 mAh", "Li-Ion", "??ang c???p nh???t", "S???c kh??ng d??y");
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("sw4cl42mmwifi", "SUPER AMOLED", "396 x 396 Pixels", "1.19'", "??ang c???p nh???t", "K??nh c?????ng l???c Gorrilla Glass Dx+", "Kh??ng h??? tr???",
		"Kh??ng h??? tr???", "Kh??ng h??? tr???", "Android Wear OS, One UI Watch 3", "Exynos W920 (5 nm)", "Mali-G68", "1.5GB RAM", "Kh??ng h??? tr???", "Kh??ng h??? tr???",
        "C?? h??? tr???", "v5.0", "????? s???c nam ch??m", "GPS, NFC", "247 mAh", "Li-Ion", "??ang c???p nh???t", "S???c kh??ng d??y");
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("ow46mm", "AMOLED", "402 x 476 Pixels", "1.91'", "??ang c???p nh???t", "K??nh c?????ng l???c", "Kh??ng h??? tr???",
		"Kh??ng h??? tr???", "Kh??ng h??? tr???", "Android Wear OS", "Qualcomm Snapdragon 3100", "??ang c???p nh???t", "??ang c???p nh???t", "Kh??ng h??? tr???", "Kh??ng h??? tr???",
        "C?? h??? tr???", "v4.2", "????? s???c nam ch??m", "GPS", "430 mAh", "Li-Ion", "??ang c???p nh???t", "S???c kh??ng d??y");
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("owfree", "AMOLED", "280 x 456 Pixels", "1.64'", "??ang c???p nh???t", "K??nh 2.5D", "Kh??ng h??? tr???",
		"Kh??ng h??? tr???", "Kh??ng h??? tr???", "H??ng kh??ng c??ng b???", "Apollo 3.5", "??ang c???p nh???t", "??ang c???p nh???t", "Kh??ng h??? tr???", "Kh??ng h??? tr???",
        "Kh??ng h??? tr???", "v5.0", "????? s???c nam ch??m", "??ang c???p nh???t", "230 mAh", "Li-Ion", "??ang c???p nh???t", "??ang c???p nh???t");
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("owband", "AMOLED", "126 x 294 Pixels", "1.1'", "??ang c???p nh???t", "K??nh 2.5D", "Kh??ng h??? tr???",
		"Kh??ng h??? tr???", "Kh??ng h??? tr???", "H??ng kh??ng c??ng b???", "H??ng kh??ng c??ng b???", "??ang c???p nh???t", "??ang c???p nh???t", "Kh??ng h??? tr???", "Kh??ng h??? tr???",
        "Kh??ng h??? tr???", "v5.0", "????? s???c nam ch??m", "??ang c???p nh???t", "100 mAh", "Li-Ion", "??ang c???p nh???t", "??ang c???p nh???t");
-- insert san pham

insert into san_pham value ("13promax", "Iphone 13 Pro Max","iphone","iphone13promax","M??n h??nh ProMotion, chip A15 Bionic m???nh m???. L??n Pro th??i.");
insert into san_pham value ("se2022", "Iphone SE (2022)","iphone","iphonese2022","Thi???t k??? nh??? g???n, chip A15 Bionic m???nh m???. Gi?? r??? b???t ng???.");
insert into san_pham value ("13", "Iphone 13","iphone","iphone13","Thi???t k??? c??n ?????i, chip A15 Bionic m???nh m???. Gi?? r??? b???t ng???.");
insert into san_pham value ("13mini", "Iphone 13 Mini","iphone","iphone13mini","Thi???t k??? nh??? g???n, chip A15 Bionic m???nh m???. Gi?? r??? b???t ng???.");
insert into san_pham value ("12", "Iphone 12","iphone","iphone12","Thi???t k??? c??n ?????i, chip A14 Bionic m???nh m???. Gi?? r??? b???t ng???.");
insert into san_pham value ("13pro", "Iphone 13 Pro","iphone","iphone13pro","M??n h??nh ProMotion, chip A15 Bionic m???nh m???. L??n Pro th??i.");
insert into san_pham value ("11", "Iphone 11","iphone","iphone11","Thi???t k??? c??n ?????i, chip A13 Bionic m???nh m???. Gi?? r??? b???t ng???.");
insert into san_pham value ("xr", "Iphone XR","iphone","iphonexr","Thi???t k??? c??n ?????i, chip A12 Bionic m???nh m???. Gi?? r??? b???t ng???.");

insert into san_pham value ("zfold3", "Samsung Galaxy Z Fold 3","ss","zfold3","M??n h??nh g???p hi???n ?????i, h??? tr??? kh??ng n?????c, camera ???n d?????i m??n h??nh.");
insert into san_pham value ("zflip3", "Samsung Galaxy Z Flip 3","ss","zflip3","M??n h??nh g???p hi???n ?????i, h??? tr??? kh??ng n?????c, thi???t k??? si??u nh??? g???n.");
insert into san_pham value ("s22ultra", "Samsung Galaxy S22 Ultra","ss","s22ultra","Thi???t k??? d??ng Note quen thu???c, h??? tr??? b??t spen k??m theo m??y, Camere Zoom 100x.");
insert into san_pham value ("s22+", "Samsung Galaxy S22 Plus","ss","s22+","Di???n m???o tr??? trung v?? n??ng ?????ng, th???i l?????ng s??? d???ng l??u d??i.");
insert into san_pham value ("s22", "Samsung Galaxy S22","ss","s22","Di???n m???o tr??? trung v?? n??ng ?????ng, th???i l?????ng s??? d???ng l??u d??i.");
insert into san_pham value ("s21fe", "Samsung Galaxy S21 FE","ss","s21fe","Di???n m???o tr??? trung v?? n??ng ?????ng, th???i l?????ng s??? d???ng l??u d??i.");
insert into san_pham value ("m53", "Samsung Galaxy M53","ss","m53","Di???n m???o tr??? trung v?? n??ng ?????ng, th???i l?????ng s??? d???ng l??u d??i.");
insert into san_pham value ("a73", "Samsung Galaxy A73","ss","a73","Di???n m???o tr??? trung v?? n??ng ?????ng, th???i l?????ng s??? d???ng l??u d??i.");
insert into san_pham value ("a53", "Samsung Galaxy A53","ss","a53","Di???n m???o tr??? trung v?? n??ng ?????ng, th???i l?????ng s??? d???ng l??u d??i.");
insert into san_pham value ("a33", "Samsung Galaxy A33","ss","a33","Di???n m???o tr??? trung v?? n??ng ?????ng, th???i l?????ng s??? d???ng l??u d??i.");

insert into san_pham value ("findx5pro", "OPPO Find X5 Pro","opo","findx5pro","M??n h??nh ch???t l?????ng cao, camera ?????nh cao, pin l???n, s???c SuperVOOC si??u nhanh.");
insert into san_pham value ("reno7z", "OPPO Reno 7Z","opo","reno7z","Camera ?????nh cao, pin l???n, s???c SuperVOOC si??u nhanh.");
insert into san_pham value ("reno7pro", "OPPO Reno 7 Pro","opo","reno7pro","Camera ?????nh cao, pin l???n, s???c SuperVOOC 2.0 si??u nhanh.");
insert into san_pham value ("reno7", "OPPO Reno 7","opo","reno7","Camera ?????nh cao, pin l???n, s???c SuperVOOC si??u nhanh.");

insert into san_pham value ("pro12.9", "iPad Pro M1 12.9 inch Celluler","ipad","pro12.9","Chip Apple M1 v?????t tr???i, k???t n???i v???i Apple Pen 2 v?? Magic Keyboard, m??n h??nh 12.9 inch, h??? th???ng loa n???i.");
insert into san_pham value ("pro12.9wifi", "iPad Pro M1 12.9 inch Wifi","ipad","pro12.9wifi","Chip Apple M1 v?????t tr???i, k???t n???i v???i Apple Pen 2 v?? Magic Keyboard, m??n h??nh 12.9 inch, h??? th???ng loa n???i.");

insert into san_pham value ("pro11", "iPad Pro M1 11 inch Celluler","ipad","pro11","Chip Apple M1 v?????t tr???i, k???t n???i v???i Apple Pen 2 v?? Magic Keyboard, m??n h??nh 11 inch, h??? th???ng loa n???i.");
insert into san_pham value ("pro11wifi", "iPad Pro M1 11 inch Wifi","ipad","pro11wifi","Chip Apple M1 v?????t tr???i, k???t n???i v???i Apple Pen 2 v?? Magic Keyboard, m??n h??nh 11 inch, h??? th???ng loa n???i.");

insert into san_pham value ("air5", "iPad Air 5 M1 Celluler","ipad","air5","Chip Apple M1 v?????t tr???i, k???t n???i v???i Apple Pen 2 v?? Magic Keyboard.");
insert into san_pham value ("air5wifi", "iPad Air 5 M1 Wifi","ipad","air5wifi","Chip Apple M1 v?????t tr???i, k???t n???i v???i Apple Pen 2 v?? Magic Keyboard.");

insert into san_pham value ("mini6", "iPad Mini 6 Celluler","ipad","air5","Chip Apple M1 v?????t tr???i, k???t n???i v???i Apple Pen 2 v?? Magic Keyboard.");
insert into san_pham value ("mini6wifi", "iPad Mini 6 Wifi","ipad","air5wifi","Chip Apple M1 v?????t tr???i, k???t n???i v???i Apple Pen 2.");

insert into san_pham value ("tabs8ultra", "Samsung Galaxy Tab S8 Ultra","sstab","tabs8ultra","M??n h??nh l???n, ??a nhi???m ??a t??c v???, b??t S Pen ???????c n??ng c???p to??n di???n h??n.");

insert into san_pham value ("mi12", "Xiaomi Mi 12","mi","mi12","Thi???t k??? nh??? g???n, tr??n vi???n hi???n ?????i, c???u h??nh m???nh m??? v???i chip Snapdragon 8 Gen 1 8 nh??n.");
insert into san_pham value ("mi12pro", "Xiaomi Mi 12 Pro","mi","mi12","Thi???t k??? tr??n vi???n hi???n ?????i, ch???p ???nh s???c n??t v???i 3 camera 50 MP, c???u h??nh m???nh m??? v???i chip Snapdragon 8 Gen 1 8 nh??n.");

insert into san_pham value ("vvv23", "Vivo V23","vv","vvv23","Thi???t k??? sang x???n, Selfie Phone ch???t l?????ng h??ng ?????u trong ph??n kh??c.");

insert into san_pham value ("aw745mm", "Apple Watch Series 7 Celluler 45mm Vi???n Th??p","applewatch","aw745mm","Ki???u d??ng hi???n ?????i & th???i th?????ng, m??n OLED ????? s??ng cao v?? s???c n??t, h??? tr??? eSIM.");
insert into san_pham value ("aw745mmwifi", "Apple Watch Series 7 45mm Vi???n Nh??m","applewatch","aw745mmwifi","Ki???u d??ng hi???n ?????i & th???i th?????ng, m??n OLED ????? s??ng cao v?? s???c n??t.");
insert into san_pham value ("aw741mm", "Apple Watch Series 7 Celluler 41mm Vi???n Th??p","applewatch","aw741mm","Ki???u d??ng hi???n ?????i & th???i th?????ng, m??n OLED ????? s??ng cao v?? s???c n??t, h??? tr??? eSIM.");
insert into san_pham value ("aw741mmwifi", "Apple Watch Series 7 41mm Vi???n Nh??m","applewatch","aw741mmwifi","Ki???u d??ng hi???n ?????i & th???i th?????ng, m??n OLED ????? s??ng cao v?? s???c n??t.");

insert into san_pham value ("aw741mmnike", "Apple Watch Series Nike 7 Celluler 41mm","applewatch","aw741mm","Ki???u d??ng hi???n ?????i & th???i th?????ng, m??n OLED ????? s??ng cao v?? s???c n??t, h??? tr??? eSIM.");
insert into san_pham value ("aw741mmwifinike", "Apple Watch Series Nike 7 41mm","applewatch","aw741mmwifi","Ki???u d??ng hi???n ?????i & th???i th?????ng, m??n OLED ????? s??ng cao v?? s???c n??t.");

insert into san_pham value ("swactive244mm", "Samsung Watch Active 2 44mm","glxwatch","swactive244mm","Nhi???u t??nh n??ng ch??m s??c s???c kh???e, nh???n cu???c g???i tr???c ti???p.");

insert into san_pham value ("sw4cl46mm", "Samsung Watch 4 LTE Classic 46mm ","glxwatch","sw4cl46mm","Nhi???u t??nh n??ng ch??m s??c s???c kh???e, nh???n cu???c g???i tr???c ti???p.");
insert into san_pham value ("sw4cl46mmwifi", "Samsung Watch 4 Classic 46mm ","glxwatch","sw4cl46mmwifi","Nhi???u t??nh n??ng ch??m s??c s???c kh???e, nh???n cu???c g???i tr???c ti???p.");

insert into san_pham value ("sw444mm", "Samsung Watch 4 LTE 44mm ","glxwatch","sw4cl46mm","Nhi???u t??nh n??ng ch??m s??c s???c kh???e, nh???n cu???c g???i tr???c ti???p.");
insert into san_pham value ("sw444mmwifi", "Samsung Watch 4 44mm ","glxwatch","sw4cl46mmwifi","Nhi???u t??nh n??ng ch??m s??c s???c kh???e, nh???n cu???c g???i tr???c ti???p.");

insert into san_pham value ("sw4cl42mm", "Samsung Watch 4 LTE Classic 42mm ","glxwatch","sw4cl42mm","Nhi???u t??nh n??ng ch??m s??c s???c kh???e, nh???n cu???c g???i tr???c ti???p.");
insert into san_pham value ("sw4cl42mmwifi", "Samsung Watch 4 Classic 42mm ","glxwatch","sw4cl42mmwifi","Nhi???u t??nh n??ng ch??m s??c s???c kh???e, nh???n cu???c g???i tr???c ti???p.");

insert into san_pham value ("sw440mm", "Samsung Watch 4 LTE 40mm ","glxwatch","sw4cl42mm","Nhi???u t??nh n??ng ch??m s??c s???c kh???e, nh???n cu???c g???i tr???c ti???p.");
insert into san_pham value ("sw440mmwifi", "Samsung Watch 4 40mm ","glxwatch","sw4cl42mmwifi","Nhi???u t??nh n??ng ch??m s??c s???c kh???e, nh???n cu???c g???i tr???c ti???p.");

insert into san_pham value ("ow46mm", "Oppo Watch 46mm ","oppowatch","ow46mm","Thi???t k??? sang tr???ng tinh t???, m???t ?????ng h??? phong ph?? tha h??? l???a ch???n.");
insert into san_pham value ("owfree", "Oppo Watch Free ","oppowatch","owfree","Thi???t k??? sang tr???ng tinh t???, m???t ?????ng h??? phong ph?? tha h??? l???a ch???n.");
insert into san_pham value ("owband", "Oppo Band ","oppowatch","owband","Thi???t k??? sang tr???ng tinh t???, m???t ?????ng h??? phong ph?? tha h??? l???a ch???n.");

insert into san_pham(id_sp, ten_sp,id_loai, mo_ta) value ("airpod3", "AirPods 3", "airpod","T??nh n??ng ??m thanh kh??ng gian v???i t??nh n??ng theo d??i chuy???n ?????ng, ch???ng m??? h??i, ch???ng n?????c.");
insert into san_pham(id_sp, ten_sp,id_loai, mo_ta) value ("airpodpro", "AirPods Pro", "airpod","Ch??? ?????ng kh??? ti???ng ???n v???i ch??? ????? xuy??n ??m, ch???ng m??? h??i, ch???ng n?????c.");
insert into san_pham(id_sp, ten_sp,id_loai, mo_ta) value ("airpodmax", "AirPods Max", "airpod","Ch??? ?????ng kh??? ti???ng ???n v???i ch??? ????? xuy??n ??m, ch??? ????? ??m thanh kh??ng gian v???i t??nh n??ng theo d??i chuy???n ?????ng.");
insert into san_pham(id_sp, ten_sp,id_loai, mo_ta) value ("earpod", "EarPods", "airpod","Thi???t k??? theo h??nh d???ng c???a tai, t???i ??a h??a ?????u ra ??m thanh v?? gi???m thi???u vi???c m???t ??m thanh");

insert into san_pham(id_sp, ten_sp,id_loai, mo_ta) value ("ia500", "Tai nghe nh??t tai C?? D??y Samsung IA500", "ssbud","Thi???t k??? c?? d??y truy???n th???ng, ?????m tai ??m ??i, tr???i nghi???m nghe phong ph??, ch???t ??m r?? n??t v???i h??? th???ng loa 2 chi???u.");
insert into san_pham(id_sp, ten_sp,id_loai, mo_ta) value ("eg920", "Tai nghe C?? D??y Samsung EG920", "ssbud","Ch??? ?????ng kh??? ti???ng ???n v???i ch??? ????? xuy??n ??m, ch???ng m??? h??i, ch???ng n?????c.");
insert into san_pham(id_sp, ten_sp,id_loai, mo_ta) value ("ig935", "Tai nghe C?? D??y Samsung IG935", "ssbud","Ch??? ?????ng kh??? ti???ng ???n v???i ch??? ????? xuy??n ??m, ch??? ????? ??m thanh kh??ng gian v???i t??nh n??ng theo d??i chuy???n ?????ng.");
insert into san_pham(id_sp, ten_sp,id_loai, mo_ta) value ("budspro", "Tai nghe Bluetooth True Wireless Galaxy Buds Pro", "ssbud","Thi???t k??? sang tr???ng, th???i th?????ng c??ng h???p s???c ?????ng nh???t m??u s???c ??i k??m, nghe r?? b???t k??? ????u c??ng c??ng ngh??? ch???ng ???n ch??? ?????ng (ANC).");
insert into san_pham(id_sp, ten_sp,id_loai, mo_ta) value ("budslive", "Tai nghe Bluetooth True Wireless Galaxy Buds Live", "ssbud","Ngo???i h??nh ho??n to??n m???i, ?????c ????o ri??ng bi???t, nghe r?? b???t k??? ????u c??ng c??ng ngh??? ch???ng ???n ch??? ?????ng (ANC).");
insert into san_pham(id_sp, ten_sp,id_loai, mo_ta) value ("buds2", "Tai nghe Bluetooth True Wireless Galaxy Buds 2", "ssbud","Thi???t k??? sang tr???ng, th???i th?????ng c??ng h???p s???c ?????ng nh???t m??u s???c ??i k??m, nghe r?? b???t k??? ????u c??ng c??ng ngh??? ch???ng ???n ch??? ?????ng (ANC).");
insert into san_pham(id_sp, ten_sp,id_loai, mo_ta) value ("bn920c", "Tai nghe Bluetooth Samsung Level U Pro BN920C", "ssbud","Thi???t k??? sang tr???ng, hai ?????u tai nghe h??t nam ch??m, c??ng ngh??? l???c ti???ng ???n th??ng minh.");

insert into san_pham(id_sp, ten_sp,id_loai, mo_ta) value ("encoair2", "Tai nghe Bluetooth True Wireless OPPO ENCO Air 2 ETE11", "oppobud","Thi???t k??? sang tr???ng, c??ng ngh??? l???c ti???ng ???n th??ng minh.");
insert into san_pham(id_sp, ten_sp,id_loai, mo_ta) value ("encobuds", "Tai nghe Bluetooth True Wireless OPPO ENCO Buds ETI81", "oppobud","Thi???t k??? sang tr???ng, c??ng ngh??? l???c ti???ng ???n th??ng minh.");
insert into san_pham(id_sp, ten_sp,id_loai, mo_ta) value ("mh135-3", "Tai nghe C?? D??y EP Type C OPPO MH135-3", "oppobud","Tai nghe c?? d??y thi???t k??? s??nh ??i???u, d??y d??i 1.2 m");
insert into san_pham(id_sp, ten_sp,id_loai, mo_ta) value ("mh151", "Tai nghe C?? D??y EP OPPO MH151", "oppobud","Tai nghe c?? d??y thi???t k??? s??nh ??i???u, d??y d??i 1.2 m.");
-- insert chi tiet san pham
insert into chi_tiet_sp value ("1", "128GB",29190000,"13promax");
insert into chi_tiet_sp value ("2", "256GB",32890000,"13promax");
insert into chi_tiet_sp value ("3", "512GB",39290000,"13promax");
insert into chi_tiet_sp value ("4", "1TB",45790000,"13promax");

insert into chi_tiet_sp value ("5", "64GB",12990000,"se2022");
insert into chi_tiet_sp value ("6", "128GB",13990000,"se2022");
insert into chi_tiet_sp value ("7", "256GB",17000000,"se2022");

insert into chi_tiet_sp value ("8", "256GB",36990000,"zfold3");
insert into chi_tiet_sp value ("9", "512GB",39990000,"zfold3");

insert into chi_tiet_sp value ("10","0", 4590000,"airpod3");
insert into chi_tiet_sp value ("11","0", 4990000,"airpodpro");
insert into chi_tiet_sp value ("12","0", 12490000,"airpodmax");
insert into chi_tiet_sp value ("13","0", 549000,"earpod");

insert into chi_tiet_sp value ("14", "128GB",21290000,"13");
insert into chi_tiet_sp value ("15", "256GB",23690000,"13");
insert into chi_tiet_sp value ("16", "512GB",30290000,"13");

insert into chi_tiet_sp value ("17", "64GB",17790000,"12");
insert into chi_tiet_sp value ("18", "128GB",18890000,"12");
insert into chi_tiet_sp value ("19", "256GB",21590000,"12");

insert into chi_tiet_sp value ("20", "128GB",27490000,"13pro");
insert into chi_tiet_sp value ("21", "256GB",30290000,"13pro");
insert into chi_tiet_sp value ("22", "512GB",36790000,"13pro");
insert into chi_tiet_sp value ("23", "1TB",44690000,"13pro");

insert into chi_tiet_sp value ("25", "128GB",18490000,"13mini");
insert into chi_tiet_sp value ("26", "256GB",21990000,"13mini");
insert into chi_tiet_sp value ("27", "512GB",25490000,"13mini");

insert into chi_tiet_sp value ("28", "64GB",12090000,"11");
insert into chi_tiet_sp value ("29", "128GB",14490000,"11");
insert into chi_tiet_sp value ("30", "256GB",18990000,"11");

insert into chi_tiet_sp value ("31", "8/128GB",30990000,"s22ultra");
insert into chi_tiet_sp value ("32", "12/256GB",33990000,"s22ultra");
insert into chi_tiet_sp value ("33", "12/512GB",36990000,"s22ultra");

insert into chi_tiet_sp value ("34", "128GB",19990000,"zflip3");
insert into chi_tiet_sp value ("35", "256GB",20990000,"zflip3");

insert into chi_tiet_sp value ("36", "128GB",25990000,"s22+");
insert into chi_tiet_sp value ("37", "256GB",27990000,"s22+");

insert into chi_tiet_sp value ("38", "128GB",21990000,"s22");
insert into chi_tiet_sp value ("39", "256GB",23490000,"s22");

insert into chi_tiet_sp value ("40", "6/128GB",12490000,"s21fe");
insert into chi_tiet_sp value ("41", "8/128GB",13490000,"s21fe");
insert into chi_tiet_sp value ("42", "8/256GB",15490000,"s21fe");

insert into chi_tiet_sp value ("43", "256GB",12290000,"m53");
insert into chi_tiet_sp value ("44", "128GB",11990000,"a73");
insert into chi_tiet_sp value ("45", "128GB",9690000,"m53");
insert into chi_tiet_sp value ("46", "128GB",8190000,"a33");

insert into chi_tiet_sp value ("47", "256GB",30990000,"findx5pro");
insert into chi_tiet_sp value ("48", "128GB",10490000,"reno7z");
insert into chi_tiet_sp value ("49", "256GB",18990000,"reno7pro");
insert into chi_tiet_sp value ("50", "256GB",12990000,"reno7");

insert into chi_tiet_sp value ("51", "128GB",29290000,"pro12.9");
insert into chi_tiet_sp value ("52", "256GB",33390000,"pro12.9");
insert into chi_tiet_sp value ("53", "512GB",40190000,"pro12.9");
insert into chi_tiet_sp value ("54", "1TB",53990000,"pro12.9");
insert into chi_tiet_sp value ("55", "2TB",63990000,"pro12.9");

insert into chi_tiet_sp value ("56", "128GB",25490000,"pro12.9wifi");
insert into chi_tiet_sp value ("57", "256GB",27990000,"pro12.9wifi");
insert into chi_tiet_sp value ("58", "512GB",32690000,"pro12.9wifi");
insert into chi_tiet_sp value ("59", "1TB",49990000,"pro12.9wifi");
insert into chi_tiet_sp value ("60", "2TB",59990000,"pro12.9wifi");

insert into chi_tiet_sp value ("61", "128GB",24490000,"pro11");
insert into chi_tiet_sp value ("62", "256GB",29990000,"pro11");
insert into chi_tiet_sp value ("63", "512GB",35990000,"pro11");
insert into chi_tiet_sp value ("64", "1TB",49990000,"pro11");
insert into chi_tiet_sp value ("65", "2TB",55990000,"pro11");

insert into chi_tiet_sp value ("66", "128GB",19990000,"pro11wifi");
insert into chi_tiet_sp value ("67", "256GB",25990000,"pro11wifi");
insert into chi_tiet_sp value ("68", "512GB",31990000,"pro11wifi");
insert into chi_tiet_sp value ("69", "1TB",42990000,"pro11wifi");
insert into chi_tiet_sp value ("70", "2TB",51990000,"pro11wifi");

insert into chi_tiet_sp value ("71", "64GB",19490000,"air5");
insert into chi_tiet_sp value ("72", "256GB",24990000,"air5");

insert into chi_tiet_sp value ("73", "64GB",14590000,"air5wifi");
insert into chi_tiet_sp value ("74", "256GB",17990000,"air5wifi");

insert into chi_tiet_sp value ("75", "64GB",17190000,"mini6");
insert into chi_tiet_sp value ("76", "256GB",23990000,"mini6");

insert into chi_tiet_sp value ("77", "64GB",14990000,"mini6wifi");
insert into chi_tiet_sp value ("78", "256GB",19990000,"mini6wifi");

insert into chi_tiet_sp value ("79", "128GB",28490000,"tabs8ultra");

insert into chi_tiet_sp value ("80","0", 300000,"ia500");
insert into chi_tiet_sp value ("81","0", 280000,"eg920");
insert into chi_tiet_sp value ("82","0", 300000,"ig935");
insert into chi_tiet_sp value ("83","0", 2490000,"budspro");
insert into chi_tiet_sp value ("84","0", 1990000,"budslive");
insert into chi_tiet_sp value ("85","0", 2990000,"buds2");
insert into chi_tiet_sp value ("86","0", 1450000,"bn920c");

insert into chi_tiet_sp value ("87", "256GB",27990000,"mi12pro");
insert into chi_tiet_sp value ("88", "256GB",19990000,"mi12");

insert into chi_tiet_sp value ("89", "120GB",12990000,"vvv23");

insert into chi_tiet_sp value ("90", "32GB",21990000,"aw745mm");
insert into chi_tiet_sp value ("91", "32GB",11990000,"aw745mmwifi");
insert into chi_tiet_sp value ("92", "32GB",19590000,"aw741mm");
insert into chi_tiet_sp value ("93", "32GB",10590000,"aw741mmwifi");

insert into chi_tiet_sp value ("94", "32GB",13990000,"aw741mmnike");
insert into chi_tiet_sp value ("95", "32GB",10990000,"aw741mmwifinike");

insert into chi_tiet_sp value ("96", "4GB",9990000,"swactive244mm");

insert into chi_tiet_sp value ("97", "16GB",8991000,"sw4cl46mm");
insert into chi_tiet_sp value ("98", "16GB",8091000,"sw4cl46mmwifi");

insert into chi_tiet_sp value ("99", "16GB",8541000,"sw4cl42mm");
insert into chi_tiet_sp value ("100", "16GB",7641000,"sw4cl42mmwifi");

insert into chi_tiet_sp value ("101", "16GB",7191000,"sw444mm");
insert into chi_tiet_sp value ("102", "16GB",6291000,"sw444mmwifi");

insert into chi_tiet_sp value ("103", "16GB",6741000,"sw440mm");
insert into chi_tiet_sp value ("104", "16GB",5841000,"sw440mmwifi");

insert into chi_tiet_sp value ("105", "128GB",13490000,"xr");

insert into chi_tiet_sp value ("106", "8GB",5193000,"ow46mm");
insert into chi_tiet_sp value ("107", "128MB",1790000,"owfree");
insert into chi_tiet_sp value ("108", "16MB",790000,"owband");

insert into chi_tiet_sp value ("109","0", 1431000,"encoair2");
insert into chi_tiet_sp value ("110","0", 790000,"encobuds");
insert into chi_tiet_sp value ("111","0", 590000,"mh151");
insert into chi_tiet_sp value ("112","0", 260000,"mh135-3");
-- insert mau sac

insert into mau_sac value ("1","V??ng ?????ng","iphone-13-pro-max-gold-650x650.png","13promax");
insert into mau_sac value ("2","B???c","iphone-13-pro-max-silver-650x650.png","13promax");
insert into mau_sac value ("3","Xanh D????ng","iphone-13-pro-max-blue-2-650x650.png","13promax");
insert into mau_sac value ("4","X??m","iphone-13-pro-max-grey-650x650.png","13promax");
insert into mau_sac value ("5","Xanh L??","iphone-13-pro-max-green-650x650.png","13promax");

insert into mau_sac value ("6","??en","iphone-se-black-650x650.png","se2022");
insert into mau_sac value ("7","?????","iphone-se-red-650x650.png","se2022");
insert into mau_sac value ("8","Tr???ng","iphone-se-white-650x650.png","se2022");

insert into mau_sac value ("9","Xanh R??u","samsung-galaxy-z-fold-3-green.jpg","zfold3");
insert into mau_sac value ("10","??en","samsung-galaxy-z-fold-3-black.jpg","zfold3");
insert into mau_sac value ("11","B???c","samsung-galaxy-z-fold-3-silver.jpg","zfold3");

insert into mau_sac value ("12","?????","iphone-13-red-650x650.png","13");
insert into mau_sac value ("13","H???ng","iphone-13-pink-650x650.png","13");
insert into mau_sac value ("14","Xanh D????ng","iphone-13-blue-650x650.png","13");
insert into mau_sac value ("15","??en","iphone-13-black-650x650.png","13");
insert into mau_sac value ("16","Tr???ng","iphone-13-white-650x650.png","13");
insert into mau_sac value ("17","Xanh L??","iphone-13-green-650x650.png","13");

insert into mau_sac value ("18","?????","iphone-12-red-1-650x650.png","12");
insert into mau_sac value ("19","T??m","iphone-12-purple-1-650x650.png","12");
insert into mau_sac value ("20","Xanh D????ng","iphone-12-blue-1-650x650.png","12");
insert into mau_sac value ("21","??en","iphone-12-black-1-650x650.png","12");
insert into mau_sac value ("22","Tr???ng","iphone-12-white-1-650x650.png","12");
insert into mau_sac value ("23","Xanh L??","iphone-12-green-1-1-650x650.png","12");

insert into mau_sac value ("24","Tr???ng","airpods-3-thumb-650x650.png","airpod3");
insert into mau_sac value ("25","Tr???ng","airpods-pro-thumb-650x650.png","airpodpro");
insert into mau_sac value ("26","Tr???ng","airpods-max-select-bac-thumb-650x650.png","airpodmax");
insert into mau_sac value ("27","Tr???ng","earpod-lightning-trang-thumb-1-650x650.png","earpod");

insert into mau_sac value ("28","V??ng ?????ng","iphone-13-pro-gold-650x650.png","13pro");
insert into mau_sac value ("29","B???c","iphone-13-pro-silver-650x650.png","13pro");
insert into mau_sac value ("30","Xanh D????ng","iphone-13-pro-blue-650x650.png","13pro");
insert into mau_sac value ("31","X??m","iphone-13-pro-grey-650x650.png","13pro");
insert into mau_sac value ("32","Xanh L??","iphone-13-pro-thumbtz-650x650.png","13pro");

insert into mau_sac value ("33","?????","iphone-13-mini-red-650x650.png","13mini");
insert into mau_sac value ("34","H???ng","iphone-13-mini-pink-650x650.png","13mini");
insert into mau_sac value ("35","Xanh D????ng","iphone-13-mini-blue-650x650.png","13mini");
insert into mau_sac value ("36","??en","iphone-13-mini-black-650x650.png","13mini");
insert into mau_sac value ("37","Tr???ng","iphone-13-mini-white-650x650.png","13mini");
insert into mau_sac value ("38","Xanh L??","iphone-13-mini-green-thumbtz-650x650.png","13mini");

insert into mau_sac value ("39","?????","iphone-11-red-1-650x650.png","11");
insert into mau_sac value ("40","V??ng","iphone-11-yellow-1-650x650.png","11");
insert into mau_sac value ("41","T??m","iphone-11-purple-1-650x650.png","11");
insert into mau_sac value ("42","??en","iphone-11-black-1-650x650.png","11");
insert into mau_sac value ("43","Tr???ng","iphone-11-white-1-650x650.png","11");
insert into mau_sac value ("44","Xanh L??","iphone-11-green-1-650x650.png","11");

insert into mau_sac value ("45","?????","samsung-galaxy-s22-ultra-1-1.jpg","s22ultra");
insert into mau_sac value ("46","Tr???ng","galaxy-s22-ultra-white-8.jpg","s22ultra");
insert into mau_sac value ("47","??en","galaxy-s22-ultra-black-8.jpg","s22ultra");
insert into mau_sac value ("48","Xanh L??","samsung-galaxy-s22-ultra-1.jpg","s22ultra");

insert into mau_sac value ("49","T??m","samsung-galaxy-z-flip-3-1-1.jpg","zflip3");
insert into mau_sac value ("50","Kem","samsung-galaxy-z-flip-3-kem-1-org.jpg","zflip3");
insert into mau_sac value ("51","Xanh R??u","samsung-galaxy-z-flip-3-1-2.jpg","zflip3");
insert into mau_sac value ("52","??en","samsung-galaxy-z-flip-3-1.jpg","zflip3");

insert into mau_sac value ("53","H???ng","samsung-galaxy-s22-plus-256gb-1.jpg","s22+");
insert into mau_sac value ("54","??en","samsung-galaxy-s22-plus-den-1.jpg","s22+");
insert into mau_sac value ("55","Tr???ng","samsung-galaxy-s22-plus-trang-1.jpg","s22+");
insert into mau_sac value ("56","Xanh L??","samsung-galaxy-s22-plus-xanh-1.jpg","s22+");

insert into mau_sac value ("57","H???ng","samsung-galaxy-s22-pink.jpg","s22");
insert into mau_sac value ("58","??en","samsung-galaxy-s22-256gb-1.jpg","s22");
insert into mau_sac value ("59","Tr???ng","samsung-galaxy-s22-white.jpg","s22");
insert into mau_sac value ("60","Xanh L??","samsung-galaxy-s22-green.jpg","s22");

insert into mau_sac value ("61","T??m","samsung-galaxy-s21-fe-1-1.jpg","s21fe");
insert into mau_sac value ("62","Xanh L??","samsung-galaxy-s21-fe-xanh-1.jpg","s21fe");
insert into mau_sac value ("63","X??m","samsung-galaxy-s21-fe-1.jpg","s21fe");
insert into mau_sac value ("64","Tr???ng","samsung-galaxy-s21-fe-trang-1-1.jpg","s21fe");

insert into mau_sac value ("65","N??u","samsung-galaxy-m53-nau-1-1.jpg","m53");
insert into mau_sac value ("66","Xanh D????ng","samsung-galaxy-m53-xanhduong-1.jpg","m53");
insert into mau_sac value ("67","Xanh L??","samsung-galaxy-m53-xanhla-1.jpg","m53");

insert into mau_sac value ("68","Xanh L??","samsung-galaxy-a73-5g-xanh-1.jpg","a73");
insert into mau_sac value ("69","X??m","samsung-galaxy-a73-1-1.jpg","a73");
insert into mau_sac value ("70","Tr???ng","samsung-galaxy-a73-5g-1.jpg","a73");

insert into mau_sac value ("71","Xanh D????ng","samsung-galaxy-a53-1-1.jpg","a53");
insert into mau_sac value ("72","??en","samsung-galaxy-a53-den-1.jpg","a53");
insert into mau_sac value ("73","Cam","samsung-galaxy-a53-cam-1.jpg","a53");
insert into mau_sac value ("74","Tr???ng","samsung-galaxy-a53-trang-1.jpg","a53");

insert into mau_sac value ("75","Xanh D????ng","samsung-galaxy-a33-5g-xanh-1.jpg","a33");
insert into mau_sac value ("76","??en","samsung-galaxy-a33-5g-den-1-1.jpg","a33");
insert into mau_sac value ("77","Cam","samsung-galaxy-a33-1.jpg","a33");
insert into mau_sac value ("78","Tr???ng","samsung-galaxy-a33-1-1.jpg","a33");

insert into mau_sac value ("79","??en","oppo-find-x5-pro-1-1.jpg","findx5pro");
insert into mau_sac value ("80","Tr???ng","oppo-find-x5-pro-1-2.jpg","findx5pro");

insert into mau_sac value ("81","B???c","oppo-reno7-z-1-1.jpg","reno7z");
insert into mau_sac value ("82","??en","oppo-reno7-z-1-2.jpg","reno7z");

insert into mau_sac value ("83","Xanh D????ng Nh???t","oppo-reno7-pro-1-1.jpg","reno7pro");
insert into mau_sac value ("84","??en","oppo-reno7-pro-1-2.jpg","reno7pro");

insert into mau_sac value ("85","Xanh D????ng","oppo-reno7-1-1.jpg","reno7");
insert into mau_sac value ("86","??en","oppo-reno7-1.jpg","reno7");

insert into mau_sac value ("87","X??m","ipad-pro-m1-129-inch-wifi-cellular-gray-650x650.png","pro12.9");
insert into mau_sac value ("88","B???c","ipad-pro-m1-129-inch-wifi-cellular-silver-650x650.png","pro12.9");

insert into mau_sac value ("89","X??m","ipad-pro-m1-129-inch-wifi-cellular-gray-650x650.png","pro12.9wifi");
insert into mau_sac value ("90","B???c","ipad-pro-m1-129-inch-wifi-cellular-silver-650x650.png","pro12.9wifi");


insert into mau_sac value ("91","B???c","ipad-pro-m1-11-inch-cellular-wifi-silver-650x650.png","pro11");
insert into mau_sac value ("92","B???c","ipad-pro-m1-11-inch-cellular-wifi-silver-650x650.png","pro11wifi");

insert into mau_sac value ("97","X??m","ipad-pro-m1-11-inch-cellular-wifi-gray-650x650.png","pro11");
insert into mau_sac value ("98","X??m","ipad-pro-m1-11-inch-cellular-wifi-gray-650x650.png","pro11wifi");

insert into mau_sac value ("93","T??m","ipad-air-5-5G-purple-650x650.png","air5");
insert into mau_sac value ("94","Xanh D????ng","air-5-m1-wifi-cellular-xanh-thumb-650x650.png","air5");
insert into mau_sac value ("95","Tr???ng","air-5-m1-wifi-cellular-trang-thumb-650x650.png","air5");
insert into mau_sac value ("96","X??m","ipad-air-5-m1-wifi-cellular-gray-thumb-650x650.png","air5");

insert into mau_sac value ("99","T??m","ipad-air-5-5G-purple-650x650.png","air5wifi");
insert into mau_sac value ("100","Xanh D????ng","air-5-m1-wifi-cellular-xanh-thumb-650x650.png","air5wifi");
insert into mau_sac value ("101","Tr???ng","air-5-m1-wifi-cellular-trang-thumb-650x650.png","air5wifi");
insert into mau_sac value ("102","X??m","ipad-air-5-m1-wifi-cellular-gray-thumb-650x650.png","air5wifi");

insert into mau_sac value ("103","H???ng","ipad-mini-6-5g-pink-650x650.png","mini6");
insert into mau_sac value ("104","T??m","ipa-mini-6-5g-purple-650x650.png","mini6");
insert into mau_sac value ("105","Tr???ng","ipad-mini-6-5g-startlight-650x650.png","mini6");
insert into mau_sac value ("106","X??m","ipad-mini-6-5g-gray-650x650.png","mini6");

insert into mau_sac value ("107","H???ng","ipad-mini-6-5g-pink-650x650.png","mini6wifi");
insert into mau_sac value ("108","T??m","ipa-mini-6-5g-purple-650x650.png","mini6wifi");
insert into mau_sac value ("109","Tr???ng","ipad-mini-6-5g-startlight-650x650.png","mini6wifi");
insert into mau_sac value ("110","X??m","ipad-mini-6-5g-gray-650x650.png","mini6wifi");

insert into mau_sac value ("111","X??m","public_images_b08df22d_4b5e_46a8_87c5_fc303e133f8a_1500x1500.jpg","tabs8ultra");

insert into mau_sac value ("112","??en","nhet-tai-samsung-ia500-den-041221-063201-600x600.jpg","ia500");
insert into mau_sac value ("113","?????","tai-nghe-nhet-tai-samsung-eg920b-avatar-600x600.jpg","eg920");
insert into mau_sac value ("118","??en","tai-nghe-15.jpg","eg920");
insert into mau_sac value ("114","??en","tai-nghe-nhet-tai-samsung-ig935b-avatar-1-600x600.jpg","ig935");
insert into mau_sac value ("117","Tr???ng","tai-nghe-nhet-trong-samsung-ig935b-trang-1-2-org.jpg","ig935");
insert into mau_sac value ("115","B???c","bluetooth-true-wireless-galaxy-buds-pro-bac-thumb-600x600.jpeg","budspro");
insert into mau_sac value ("116","??en","tai-nghe-bluetooth-true-wireless-galaxy-buds-pro-ava-1-600x600.jpg","budspro");
insert into mau_sac value ("119","?????ng","ai-nghe-bluetooth-true-wireless-samsung-galaxy-buds-live-r180-gold-thumb-600x600.jpeg","budslive");
insert into mau_sac value ("120","Tr???ng","samsung-galaxy-buds-2-r177n-trang-thumb-3-600x600.jpeg","buds2");
insert into mau_sac value ("121","??en","samsung-galaxy-buds-2-r177n-600x600.jpg","buds2");
insert into mau_sac value ("122","?????ng","tai-nghe-bluetooth-samsung-level-u-pro-bn920c-avatar-1-1-600x600.jpg","bn920c");
insert into mau_sac value ("123","??en","tai-nghe-bluetooth-samsung-level-u-pro-bn920c-den-3-org.jpg","bn920c");

insert into mau_sac value ("124","X??m","xiaomi-12-1.jpg","mi12");
insert into mau_sac value ("125","Xanh D????ng","xiaomi-12-1-1.jpg","mi12");
insert into mau_sac value ("126","T??m","xiaomi-mi-12-1.jpg","mi12");

insert into mau_sac value ("127","T??m","xiaomi-12-pro-1-1.jpg","mi12pro");
insert into mau_sac value ("128","X??m","xiaomi-12-pro-1-2.jpg","mi12pro");
insert into mau_sac value ("129","Xanh D????ng","xiaomi-12-pro-1-3.jpg","mi12pro");

insert into mau_sac value ("130","V??ng","vivo-v23-5g-vang-1.jpg","vvv23");
insert into mau_sac value ("131","Xanh ??en","vivo-v23-5g-xanh-1.jpg","vvv23");

insert into mau_sac value ("132","Xanh D????ng","apple-watch-s7-lte-45mm-xanh-duong-2-650x650.png","aw745mm");
insert into mau_sac value ("133","T??m","apple-watch-s7-lte-45mm-tim-650x650.png","aw745mm");
insert into mau_sac value ("134","V??ng","apple-watch-s7-lte-45mm-vang-nhat-2-650x650.png","aw745mm");

insert into mau_sac value ("135","Xanh D????ng","apple-watch-s7-lte-45mm-xanh-duong-2-650x650.png","aw741mm");
insert into mau_sac value ("136","T??m","apple-watch-s7-lte-45mm-tim-650x650.png","aw741mm");
insert into mau_sac value ("137","V??ng","apple-watch-s7-lte-45mm-vang-nhat-2-650x650.png","aw741mm");

insert into mau_sac value ("138","V??ng","apple-watch-s7-gps-45mm-vang-nhat-650x650.png","aw745mmwifi");
insert into mau_sac value ("139","??en","apple-watch-s7-gps-45mm-den-650x650.png","aw745mmwifi");
insert into mau_sac value ("140","Xanh L??","apple-watch-s7-gps-45mm-xanh-la-650x650.png","aw745mmwifi");
insert into mau_sac value ("141","Xanh D????ng","apple-watch-s7-gps-45mm-xanh-duong-650x650.png","aw745mmwifi");
insert into mau_sac value ("142","?????","apple-watch-s7-gps-45mm-do-650x650.png","aw745mmwifi");

insert into mau_sac value ("143","V??ng","apple-watch-s7-gps-45mm-vang-nhat-650x650.png","aw741mmwifi");
insert into mau_sac value ("144","??en","apple-watch-s7-gps-45mm-den-650x650.png","aw741mmwifi");
insert into mau_sac value ("145","Xanh L??","apple-watch-s7-gps-45mm-xanh-la-650x650.png","aw741mmwifi");
insert into mau_sac value ("146","Xanh D????ng","apple-watch-s7-gps-45mm-xanh-duong-650x650.png","aw741mmwifi");
insert into mau_sac value ("147","?????","apple-watch-s7-gps-45mm-do-650x650.png","aw741mmwifi");

insert into mau_sac value ("148","??en","apple-watch-nike-series-7-gps-cellular-41mm-650x650.png","aw741mmnike");
insert into mau_sac value ("149","Tr???ng","apple-watch-series-7-nike-lte-41mm-650x650.png","aw741mmnike");
insert into mau_sac value ("150","??en","apple-watch-series-7-gps-41mm-den-650x650.png","aw741mmwifinike");

insert into mau_sac value ("151","??en","samsung-galaxy-watch-4-lte-classic-42mm-den-thumb-1-600x600.jpg","sw4cl46mm");
insert into mau_sac value ("152","??en","samsung-galaxy-watch-4-lte-classic-42mm-den-thumb-1-600x600.jpg","sw4cl42mm");

insert into mau_sac value ("153","??en","samsung-galaxy-watch-4-classic-46mm-den-thumb-1-600x600.jpeg","sw4cl46mmwifi");
insert into mau_sac value ("154","B???c","samsung-galaxy-watch-4-classic-46mm-bac-thumb-01-1-600x600.jpg","sw4cl46mmwifi");

insert into mau_sac value ("155","??en","samsung-galaxy-watch-4-classic-42mm-den-thumb-600x600.jpg","sw4cl42mmwifi");
insert into mau_sac value ("156","Tr???ng","samsung-galaxy-watch-4-classic-42mm-trang-thumb-1-2-3-600x600.jpg","sw4cl42mmwifi");

insert into mau_sac value ("157","Xanh L??","samsung-galaxy-watch-4-44mm-xanh-thumb-600x600.jpg","sw444mmwifi");
insert into mau_sac value ("158","??en","samsung-galaxy-watch-4-44mm-den-thumb-600x600.jpg","sw444mmwifi");
insert into mau_sac value ("159","B???c","samsung-galaxy-watch-4-44mm-thumb-02-600x600.jpg","sw444mmwifi");

insert into mau_sac value ("160","??en","samsung-galaxy-watch-4-40mm-den-thumb-600x600.jpg","sw440mmwifi");
insert into mau_sac value ("161","Tr???ng","samsung-galaxy-watch-4-40mm-trang-thumbnew-1-600x600.jpg","sw440mmwifi");
insert into mau_sac value ("162","V??ng H???ng","samsung-galaxy-watch-4-40mm-vang-hong-thumb-1-2-3-4-600x600.jpg","sw440mmwifi");

insert into mau_sac value ("163","??en","samsung-galaxy-watch-active-2-44-mm-day-da-thumb-1-1-600x600.jpg","swactive244mm");

insert into mau_sac value ("164","??en","samsung-galaxy-watch-4-lte-44mm-den-thumb-600x600.jpg","sw444mm");
insert into mau_sac value ("165","??en","samsung-galaxy-watch-4-lte-40mm-thumb-den-1-1-600x600.jpg","sw440mm");

insert into mau_sac value ("166","Tr???ng","iphone-xr-white-650x650.png","xr");

insert into mau_sac value ("167","V??ng ?????ng","oppo-watch-46mm-day-silicone-hong-thumb-1-1-600x600.jpg","ow46mm");
insert into mau_sac value ("168","??en","oppo-watch-free-den-thumb-mau-600x600.jpg","owfree");
insert into mau_sac value ("169","V??ng","oppo-watch-free-vani-1.jpg","owfree");
insert into mau_sac value ("170","T??m","oppo-band-tim-thumb-600x600.jpg","owband");
insert into mau_sac value ("171","??en","oppo-band-1-org-1.jpg","owband");

insert into mau_sac value ("172","Xanh D????ng","bluetooth-true-wireless-oppo-enco-air-2-ete11-1-600x600.jpg","encoair2");
insert into mau_sac value ("173","Tr???ng","bluetooth-true-wireless-oppo-enco-air-2-ete11-2.jpg","encoair2");

insert into mau_sac value ("174","Tr???ng","bluetooth-tws-oppo-enco-buds-eti81-600x600.jpg","encobuds");
insert into mau_sac value ("175","Xanh D????ng","bluetooth-tws-oppo-enco-buds-eti81-2-2.jpg","encobuds");

insert into mau_sac value ("176","??en","co-day-ep-oppo-mh151-10-600x600.jpg","mh151");
insert into mau_sac value ("177","Tr???ng","co-day-ep-oppo-mh151-bac-1-1-org.jpg","mh151");

insert into mau_sac value ("178","Tr???ng","co-day-ep-type-c-oppo-mh135-600x600.jpg","mh135-3");