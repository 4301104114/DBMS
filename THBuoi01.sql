create database QLDDH_NGUYENPHUONGNGAN 
on primary (
   name =	QLDDH_PRIMARY,
   filename = 'D:\DBMS\THBuoi01_NGUYENPHUONGNGAN_43.01.CNTT.A\QLDDH_PRIMARY.mdf',
   size = 3MB,
   maxsize = 10MB,
   filegrowth = 10%
)
log on (
   name =  QLDDH_LOG,
   filename = 'D:\DBMS\THBuoi01_NGUYENPHUONGNGAN_43.01.CNTT.A\QLDDH_LOG.ldf',
   size = 1MB,
   maxsize = 5MB,
   filegrowth = 10%
)
go

use QLDDH_NGUYENPHUONGNGAN
go

-- tao bang hang hoa
create table HangHoa (
   MaHH char(2),
   TenHH nvarchar(20),
   DVT nvarchar(10),
   SLCon smallint,
   DonGiaHH int,
   constraint pk_HH primary key(MaHH)
)
go

--tao bang KhachHang
create table KhachHang (
   MaKH char(10),
   TenKH nvarchar(30),
   DiaChi nvarchar(50),
   DienThoai char(12),
   constraint pk_KhachHang primary key(MaKH)
)
go

--tao bang DonDatHang
create table DonDatHang(
   MaDat char(4),
   NgayDat smalldatetime,
   MaKH char(10),
   TinhTrang bit,
   constraint pk_DonDatHang primary key(MaDat),
   constraint fk_DonDatHang_KH foreign key(MaKH) references KhachHang(MaKH)
)
go

--tao bang ChiTietDatHang
create table ChiTietDatHang(
   MaDat char(4),
   MaHH char(2),
   SLDat smallint,
   constraint pk_CTDH primary key(MaDat, MaHH)
)
go

--T?o  khóa  ngo?i  gi?a  ca?c  ba?ng  ChiTietDatHang  v?i DonDatHang và HangHoa
alter table ChiTietDatHang 
add constraint fk_CTDDH_MaDat foreign key(MaDat) references DonDatHang(MaDat)

alter table ChiTietDatHang
add constraint fk_CTDDH_MaHH foreign key(MaHH) references HangHoa(MaHH)


alter table HangHoa
add constraint uni_TenHH unique(TenHH)

alter table HangHoa
add constraint chk_SLC check(SLCon>=0)
--tao bang PhieuGiaoHang
create table PhieuGiaoHang (
   MaGiao char(4),
   NgayGiao smalldatetime,
   MaDat char(4),
   constraint pk_PhieuGiaoHang primary key(MaGiao),
   constraint fK_PhieuGiaoHang_MaDat foreign key(MaDat) references DonDatHang(MaDat)
)
go
--tao bang ChiTietGiaoHang
create table ChiTietGiaoHang (
   MaGiao char(4),
   MaHH char(2),
   SLGiao smallint,
   DonGiaGiao smallint,
   constraint pk_ChiTietGiaoHang primary key(MaGiao,MaHH),
   constraint chk_SLGiao check(SLGiao>=0),
   constraint chk_DonGiaGiao check(DonGiaGiao>=0)
)
go

--tao khoa ngoai cho ChiTietGiaoHang
alter table ChiTietGiaoHang
add constraint fk_ChiTietGiaoHang_MaGiao foreign key(MaGiao) references PhieuGiaoHang(MaGiao)
alter table ChiTietGiaoHang
add constraint fk_ChiTietGiaoHang_MaHH foreign key(MaHH) references HangHoa(MaHH)

--tao bang LichSuGiao
create table LichSuGiao(
   MaHH char(4),
   NgayHL smalldatetime 
)


