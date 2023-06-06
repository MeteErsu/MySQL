/*======================== HAVING CLAUSE =======================
    HAVING, AGGREGATE FUNCTION'lar ile birlikte kullanilan 
FILTRELEME komutudur.
    Aggregate fonksiyonlar ile ilgili bir kosul koymak 
icin GROUP BY'dan sonra HAVING cumlecigi kullanilir.    
===============================================================*/


CREATE TABLE isciler
(
id int,
isim varchar(50),
sehir varchar(50),
maas int,
sirket varchar(20)
);
INSERT INTO isciler VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');
INSERT INTO isciler VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');
INSERT INTO isciler VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500,'Honda');
INSERT INTO isciler VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');
INSERT INTO isciler VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');
INSERT INTO isciler VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford');
INSERT INTO isciler VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');
SELECT * FROM isciler;

-- Sirketlere gore toplam isci sayisini listeleyiniz

select sirket, count(isim)isci_sayisi
from isciler
group by sirket;

-- 1) Sirketlere gore isci_sayisini 1'den buyukse yazdiriniz

select sirket, count(isim)isci_sayisi
from isciler
group by sirket
having isci_sayisi > 1;

-- 2) Toplam geliri 8000 liradan fazla olan isimleri gosteren sorgu yaziniz

select isim,sum(maas)maas_toplam
from isciler
group by isim
having maas_toplam>8000;

-- 3) Her sirketin MIN maaslarini eger 4000'den buyukse goster.

select sirket,min(maas)min_maas
from isciler
group by sirket
having min_maas>4000;


-- Yeni create ettigimiz bir field uzerinden filtreleme yaptigimiz icin
-- WHERE cumlecigini kullanamayiz, WHERE cumlecigi sadece tablomuzda var olan
-- field'lar icin bir filtreleme yapar.

-- 4) Eger bir sehirde alinan MAX maas 5000'den dusukse sehir ismini 
-- ve MAX maasi veren sorgu yaziniz

SELECT sehir,MAX(maas)max_maas
FROM isciler
GROUP BY sehir
HAVING max_maas<5000;


-- 5) Eger bir sehirde alinan MAX maas 5000'den buyukse sehir ismini
-- ve MAX maasi, sehir isim sirali veren sorgu yaziniz

SELECT sehir,MAX(maas)max_maas
FROM isciler
GROUP BY sehir
HAVING max_maas>5000
order by sehir;


-- 6) Eger bir sehirde alinan MAX maas 5000'den buyukse ve sehir ismi
-- 'I' harfi ile basliyorsa o sehirleri ve MAX maasi, maas
-- sirali veren sorgu yaziniz

SELECT sehir,max(maas)max_maas
FROM isciler
WHERE sehir LIKE 'I%'
GROUP BY sehir
HAVING max_maas>5000
ORDER BY maas;


/*============================ LIMIT ===========================
>Tablodaki verilerin belli bir kismini listelemek icin LIMIT
 komutunu kullaniriz.
>LIMIT komutundan sonra kullandigimiz sayi kadar kaydi bize getirir.
>Eger belirli bir aralikta calismak istiyorsak bu durumda 
iki sayi gireriz, ancak bu sayilardan ilki baslangic noktamizi 
ifade ederken ikincisi kac kayit getirecegimizi belirtir. Baslangic 
noktasi dahil edilmez!
===============================================================*/

-- 1) Isciler tablosundan ilk 5 kaydi getiriniz.

select *
from isciler
limit 5;

-- 2) Isim sirali tablodan ilk 3 kaydi listeleyin.
 
select *
from isciler
order by isim
limit 3;

-- 3) Maas sirali tablodan 4. kayittan 6. kayda kadar olan
-- kayitlarin isim ve sehir bilgilerini listeleyin.

select isim, sehir
from isciler
order by isim
limit 3 , 3;

-- 4) Maasi en yuksek 3 kisinin bilgilerini listeleyen sorguyu yaziniz.

select *
from isciler
order by max(maas)
limit 3;

-- 5) Maasi en dusuk 3 kisinin sadece isimlerini listeleyen sorguyu yaziniz.

select isim, maas, sehir
from isciler
order by maas
limit 3;

-- 6) Maasi en dusuk 3 kisinin sadece isimlerini, isim sirali listeleyen sorguyu yaziniz.

select isim  
from isciler
order by maas, isim
limit 3;

-- 7) Maas'i 4000'den buyuk olan 3 kisinin sehrini listeleyin.

select sehir
from isciler
where maas>4000
order by maas
limit 3;

/*============================ DISTINCT ===========================
    DISTINCT cumlecigi bir Sorgu ifadesinde benzer olan kayitlari
    filtrelemek icin kullanilir. Dolayisiyla secilen sutun veya 
    sutunlar icin benzersiz veri iceren satirlar olusturmaya yarar.
    
    Syntax :
    --------
    SELECT DISTINCT field_name1, field_name2,...
    FROM table_name
    
===============================================================*/

-- 1) Iscileri yasadiklari sehirler ile tekrarsiz listeleyin

SELECT DISTINCT sehir,isim
FROM isciler;

-- Group By'da bir fielda gore gruplama yapip, Aggregate Function'lar 
-- yardimiyla baska bir field'da islem yapip bize islem yaptigi field'i 
-- yeni bir field olarak donduruyor.DISTINCT cumlecigi bir Sorgu ifadesinde
-- benzer olan kayitlari filtrelemek icin kullanilir. DISTINCT komutu bize
-- bir field'daki kayitlarin tek bir ornegini dondurur.

-- 2) Manav tablosundan satilan farkli meyve turlerini listeleyen bir query yaziniz

select * from manav;

select distinct urun_adi
from manav;

-- 3) Satilan farkli meyve turlerinden NULL olmayanlari listeleyen
-- bir query yaziniz

select distinct urun_adi
from manav
where urun_adi is not null;

-- 4) Satilan farkli meyve turlerinden NULL olmayanlari meyve isim sirali
--  listeleyen bir query yaziniz

select distinct urun_adi
from manav
where urun_adi is not null
order by urun_adi;

-- 5) Satilan meyve ve satin alan kisi isimlerinden farkli olan ikilileri
-- listeleyen query yaziniz

select distinct isim, urun_adi
from manav;










