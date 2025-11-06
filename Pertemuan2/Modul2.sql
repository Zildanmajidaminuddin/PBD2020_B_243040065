--Buat Database TokoRetaoLDb

CREATE DATABASE TokoRetaiLDB

--Gunakan DB TokoRetaiLDB
USE TokoRetaiLDB;

--Membuat tabel kategoriproduk
CREATE TABLE KatagoriProduk(
	KatagoriID INT IDENTITY(1,1) PRIMARY KEY,
	NamaKategori VARCHAR(100) NOT NULL UNIQUE
);

--Membaut Tabel Produk
CREATE TABLE Produk(
	ProdukID  INT IDENTITY(1000,1) PRIMARY KEY,
	SKU VARCHAR (20) NOT NULL UNIQUE,
	NamaProduk VARCHAR (150) NOT NULL,
	Harga DECIMAL (10,2) NOT NULL,
	Stok INT NOT NULL,
	KategoriID INT NULL,

	--HARGANYA GABOLE NEGATIF

	CONSTRAINT CHK_HargaPositif CHECK(Harga  >=0),
	
	--OCKNYA GABOLE NEGATIF
	CONSTRAINT CHK_StockPositif CHECK(Stok >=0),

	--RELASIKAN DENGAN TABEL KATEGORI PRODUK MELALUI KATEGORI ID

	CONSTRAINT FK_Produk_Katagori
	FOREIGN KEY (KategoriID)
	REFERENCES KatagoriProduk(KatagoriID)

);

--MEMASUKAN DATA KE TABEL Katagori Produk
INSERT INTO KatagoriProduk (NamaKategori)
VALUES 
('Elektronik');

INSERT INTO KatagoriProduk (NamaKategori)
VALUES 
('Pakaian'),
('Buku');

--MENAMPILKAN TABEL KatagoriProduk
SELECT *
FROM KatagoriProduk

--MENAMPILKAN TABEL NamaKatagori
SELECT NamaKategori
FROM KatagoriProduk;

--Menambahkan Data Ke TabelProduk
INSERT INTO Produk(SKU,NamaProduk,Harga,Stok,KategoriID)
VALUES 
('ELEC-001', 'Laptop Gaming',15000000.00,50,2)


INSERT INTO Produk(SKU,NamaProduk,Harga,Stok,KategoriID)
VALUES 
('ELEC-002', 'Hp Gaming',20000000.00,50,1);

--MENAMPILKAN DATA PRODUK
SELECT *
FROM Produk

--MWNGUBAH DATA STOK LAPTOP MENJADI 30
UPDATE Produk 
SET Stok= 30
WHERE ProdukID= 1000

--MENGAHPUS DATA HP GAMING
BEGIN TRANSACTION;

DELETE FROM Produk
WHERE ProdukID =1002;

COMMIT TRANSACTION;

--Menambahkan Data Ke TabelProduk
INSERT INTO Produk(SKU,NamaProduk,Harga,Stok,KategoriID)
VALUES 
('BAJU-001','KaosPutih',500000.00,30,2);

INSERT INTO Produk(SKU,NamaProduk,Harga,Stok,KategoriID)
VALUES 
('BAJU-002','KaosHitam',4000000.00,30,2);

SELECT*FROM Produk

--MEGHAPUS KAOS PUTIH
BEGIN TRAN;

DELETE FROM Produk
WHERE ProdukID =1004

--MEMBALIKAN PRODUK YANG DIHAPUS
ROLLBACK TRANSACTION;
