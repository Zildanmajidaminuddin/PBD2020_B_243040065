USE KampusDB;

--subquery 
-- menampilkan dosen yang mengajar matakuliah basis data 
SELECT NamaDosen
FROM Dosen
WHERE DosenID = (
	SELECT DosenID 
	FROM MataKuliah
	WHERE NamaMK='Basis Data'
	)

SELECT NamaDosen
FROM Dosen
WHERE DosenID = 1

-- mneampilkan mahasiswa yang nilainya a
SELECT NamaMahasiswa
FROM Mahasiswa
WHERE MahasiswaID IN (
	SELECT MahasiswaID
	FROM Nilai
	WHERE NilaiAkhir = 'A'
)

--Menampilkan Daftar prodi yang mahasiswanya lebih dari 2
SELECT Prodi, TotalMhs
FROM (
	SELECT Prodi, COUNT (*) AS TotalMhs
	FROM Mahasiswa
	GROUP BY Prodi
)AS HitungMhs
WHERE TotalMhs >2;


--Menampilkan matakuiah yang diajar oleh dosen informatika 
SELECT NamaMK
FROM MataKuliah
WHERE DosenID IN(
	SELECT DosenID
	FROM Dosen
	WHERE Prodi = 'Informatika'
)

--CITE 
--CTE untuk daftar mahasiswa dari informatika
WITH MhsIF AS (
	SELECT *
	FROM Mahasiswa
	WHERE Prodi = 'Informatika'
)
SELECT NamaMahasiswa, Angkatan 
FROM MhsIF

--SET Operators
-- UNION; Menggabungkan daftar nama dosen dan nama mahsiswa
SELECT NamaDosen AS Nama
FROM Dosen	
UNION 
SELECT NamaMahasiswa
FROM Mahasiswa

--UNION ALL : MENGGAMBUNGKAN ruangan yang kapsitasnya >40 Dan <40
SELECT KodeRuangan, Kapasitas
FROM Ruangan
WHERE Kapasitas >40
UNION ALL
SELECT KodeRuangan, Kapasitas
FROM Ruangan
WHERE Kapasitas <40

-- INTERSECT Mahasiswayang ada ditabel KRS dan di tabel NIlai
SELECT MahasiswaID
FROM KRS

SELECT MahasiswaID 
FROM KRS 

SELECT MahasiswaID
FROM KRS
INTERSECT
SELECT MahasiswaID
FROM Nilai

--EXCEPT ;; MAHasiswa yang terdapat di krs tetepi tidak memiliki nilai
SELECT MahasiswaID
FROM KRS
EXCEPT 
SELECT MahasiswaID 
FROM Nilai

--ROLLUP: 
-- ROLLUP Jumlah mahasiswa per prodi dan total keseluruhanya
SELECT Prodi, COUNT (*) AS TotalMahasiswa
FROM Mahasiswa
GROUP BY ROLLUP(Prodi)

SELECT Prodi, COUNT (*) AS TotalMahasiswa
FROM Mahasiswa
GROUP BY ROLLUP(Prodi)

--CUBE
--CUBE jumlah mahasiswa berdasarkan prodi dan angkatan
SELECT Prodi, Angkatan, COUNT(*) AS TotalMahasiswa
FROM Mahasiswa
GROUP BY CUBE (Prodi, Angkatan)

--GROUPING SETS 
-- Total Mahasiswa berdasarkan prodi angkatan dan total keseluruhan
SELECT Prodi, Angkatan, COUNT(*) AS TotalMahasiswa
FROM Mahasiswa
GROUP BY GROUPING SETS (
	(Prodi), --Subtotal per prodi
	(Angkatan),-- subtotal per angkatan
	() -- Total keseluruhan
)

-- WINDOWS FUNCATION
--Menampilkan nama mahasiswa dan total mahsiswa di prodi yang sama
SELECT NamaMahasiswa,Prodi, COUNT (*)
FROM Mahasiswa
GROUP BY NamaMahasiswa, Prodi

SELECT
		NamaMahasiswa	
		prodi,
		COUNT(*) OVER(PARTITION BY Prodi) AS TotalMahasiswaPerProdi
FROM Mahasiswa;