/*1. Készítsünk nézetet VSZOBA néven, amely megjeleníti a szobák adatai mellett a megfelelő szálláshely nevét, helyét és a csillagok számát is!

Az oszlopoknak nem szükséges külön nevet adni!
Teszteljük is a nézetet, pl: SELECT * FROM VSZOBA
*/
CREATE VIEW VSZOBA
AS
SELECT szh.szallas_nev,
       szh.Szallashely,
       sz.csillagok_szama
FROM Szoba sz JOIN Szallashely szh ON sz.SZALLAS_FK = szh.SZALLAS_ID
/*
2 Készítsen tárolt eljárást SPUgyfelFoglalasok, amely a paraméterként megkapott ügyfél azonosítóhoz tartozó foglalások adatait listázza!
Teszteljük a tárolt eljárás működését, pl: EXEC SPUgyfelFoglalasok 'laszlo2'
*/
CREATE PROCEDURE SPUgyfelFoglalasok @ugyfelazon nvarchar(20)
AS
BEGIN
SELECT *
FROM Foglalas
WHERE UGYFEL_FK = @ugyfelazon
END
/*
3. Készítsen skalár értékű függvényt UDFFerohely néven, amely visszaadja, hogy a paraméterként megkapott foglalás azonosítóhoz hány férőhelyes szoba tartozik!
a. Teszteljük a függvény működését!
*/
CREATE FUNCTION UDFFerohely (@fogalasAzonosito INT)
RETURNS INT
AS
    BEGIN
    DECLARE @ferohely INT
    SELECT @ferohely = sz.FEROHELY
    FROM Foglalas F JOIN Szoba sz ON f.SZOBA_FK = sz.SZOBA_ID
    WHERE @fogalasAzonosito = f.FOGLALAS_PK
    RETURN @fogalasAzonosito
END

/*
4. Készítsünk tárolt eljárást SPRangsor néven, amely rangsorolja a szálláshelyeket a foglalások száma alapján (a legtöbb foglalás legyen a rangsorban az első). 
A listában a szállás azonosítója, neve és a rangsor szerinti helyezés jelenjen meg - holtverseny esetén ugrással (ne sűrűn)! 
a. Teszteljük a tárolt eljárást, pl: EXEC SPRangsor
*/
CREATE PROCEDURE SPRangsor
AS
BEGIN
SELECT szh.SZALLAS_FK,
       szh.szallas_nev,
       RANK() OVER(ORDER BY COUNT(*) DESC) AS 'Helyezes'
FROM Foglalas f JOIN Szoba sz ON f.SZOBA_FK = sz.SZOBA_ID
                JOIN Szallashely szh ON szh.SZALLAS_ID = sz.SZALLAS_FK
GROUP BY szh.SZALLAS_FK,
         szh.szallas_nev,
END
/*
5. Készítsünk nézetet VFoglalasreszletek néven, amely a következő adatokat jeleníti meg: foglalás azonosítója, az ügyfél neve, 
a szálláshely neve és helye, a foglalás kezdete és vége, és a szoba száma. 

a. Az oszlopokat nevezzük el értelemszerűen! 
b. Teszteljük a nézet működését, pl: SELECT * FROM VFoglalasreszletek
*/
CREATE VIEW VFoglalasreszletek ([Foglalási azonosító], [Ügyfél neve], [Szálláshely neve], Hely, [Foglalás kezdete],
[Foglalás vége], [Szoba száma])
AS
SELECT f.FOGLALAS_PK,
       V.USERNEV,
       szh.szallas_nev,
       szh.Szallashely,
       f.METTOL,
       f.MEDDIG,
       sz.SZOBA_SZAMA
FROM Foglalas f JOIN Vendeg v ON f.UGYFEL_FK = v.USERNEV
                JOIN Szoba sz ON f.SZOBA_FK = sz.SZOBA_ID
				JOIN Szallashely szh ON sz.SZALLAS_FK = szh.SZALLAS_ID

/*
6.
Készítsen tábla értékű függvényt NEPTUNKÓD_UDFFoglalasnelkuliek néven, 
amely azon ügyfelek adatait listázza, akik még nem foglaltak egyszer sem az adott évben adott hónapjában! 
A függvény paraméterként kapja meg a foglalás évét és hónapját! (Itt is a METTOL dátummal dolgozzunk) 
a. Teszteljük is a függvény működését, pl: SELECT * FROM dbo.UJAENB_UDFFoglalasnelkuliek(2016, 10)
*/
CREATE FUNCTION NEPTUNKÓD_UDFFoglalasnelkuliek (@ev INT, @honap INT)
RETURNS TABLE
AS
RETURN
    SELECT *
    FROM Vendeg v
    WHERE v.USERNEV NOT IN(
        SELECT f.UGYFEL_FK
        FROM Foglalas f
        WHERE (YEAR)f.METTOL = @ev AND
              (MONTH)f.METTOL = @honap
    )


ZH minta
mongodb
1.
db.users.find(
  { email: { $regex: ".com" } },  // Csak azok az emailek, amelyek tartalmazzák a ".com"-ot
  { _id: 0, name: 1, email: 1 }   // Csak a name és email mezők jelennek meg
)


2.
db.movie.find(
  { 
    genres: { $eq: "Short" },   // Az első műfajnak "Short"-nak kell lennie
    year: { $gte: 1945, $lte: 1970 }  // Az évnek 1945 és 1970 között kell lennie (beleértve a határokat)
  },
  { _id: 0, title: 1, year: 1 }   // Csak a cím és az év jelenjen meg
).sort({ year: 1, title: 1 })  // Év szerint, majd cím szerint növekvő sorrend


3.
db.movie.aggregate([
  {
    $match: { runtime: { $gte: 50, $lte: 100 } }  // Szűrés: runtime 50 és 100 között
  },
  {
    $group: {
      _id: "$year",  // Csoportosítás az év szerint
      avgComments: { $avg: "$num_mflix_comments" }  // Átlag számítás az `num_mflix_comments` mezőn
    }
  },
  {
    $project: {
      year: "$_id",  // Az `_id`-t évként jelenítjük meg
      avgComments: 1  // Megjelenítjük az átlagos hozzászólások számát
    }
  }
])


neo4j
4.
MATCH (a:Actor)-[:ACTED_IN]->(m:Movie)  
WHERE m.year > 1960  
RETURN a.name AS SzereplőNeve, 
       m.title AS FilmCím, 
       m.year AS MegjelenésiÉv  
ORDER BY m.year DESC


5.
MATCH (a:Actor)-[:ACTED_IN]->(m:Movie)
WHERE m.year > 1970 OR m.title CONTAINS "Love"
RETURN a.name AS SzereplőNeve, 
       m.title AS FilmCím
ORDER BY m.title DESC


6.
MATCH (a:Actor)-[:ACTED_IN]->(m:Movie)
RETURN m.title AS FilmCím, COUNT(a) AS SzereplőkSzáma
ORDER BY SzereplőkSzáma DESC
LIMIT 1
