# 8. gyakorlat

## Előkészületek

### MongoDB
+ Regisztráljunk a MongoDB Atlas oldalán (https://www.mongodb.com/cloud/atlas/register)
+ Telepítsük fel a MongoDB Compass programot (csak saját magunknak)

+ Opcionálisan: A VS CODE-ban adjuk hozzá a MongoDB for VS Code bővítményt

A megoldásokat - ahol kódot kell írni - másoljuk be a ```js és a ``` közötti részbe


## Feladatok


1.	Lépjen be a MongoPlayground oldalára, majd a melléklet 1. pontjában szereplő gyűjteményt másolja be a Configuration részbe!
a Készítsen lekérdezést, amely csak az user_id, firstName és lastname oszlopokat jeleníti meg!

```js

```


2.	A MongoPlayground-on az előző feladatban létrehozott gyűjteményből kérdezze le a Grace keresztnevű felhasználó email-címét és jelszavát (csak ez a két mező jelenjen meg)!

```js

```


3. Lépjen be a MongoDB Atlas-ba, majd értelemszerűen hozzon létre új szervezetet, projektet és cluster-t! Válasszuk a **Free** lehetőséget!
   
a. A Load sample Dataset lehetőség legyen bejelölve    (A dataset betöltése több percet is igénybe vehet)
b. Kattintson a Browse Collections gombra!
c. Ha nem jelenik meg a sample_training adatbázis, akkor a MongoDB Compass-ban hozzuk létre, és importáljuk a grades.json és a trips.json gyűjteményeket!

OPCIONÁLISAN: a feladat a MongoDB Compass-ból vagy a VS Code-ból kiidulva is megoldható

4.  A sample_training adatbázis grades gyűjteményből kérdezze le a 339-es azonosítójú osztály eredményeit!

a. A listában csak azok a dokumentumok jelenjenek meg, ahol a tanuló azonosítója 100 alatt van!

   
```js

```

OPCIONÁLISAN: a feladat a MongoDB Compass-ban, a VS Code-ban vagy a MongoDB Shell-ben is megoldható

5. A MongoDB Atlas-ban a + Create Database gomb lenyomásával  hozzunk létre új adatbázist Gyak8 néven, azon belül pedig egy új gyűjteményt szemelyek néven! A létrehozás után tegye aktuálissá a Gyak8.szemelyek gyűjteményt!
   
a. Az Insert Document gomb lenyomása után szúrjunk be új dokumentumot a szemelyek gyűjteménybe a következő tartalommal (értéknek mindenhova a saját adatait adja meg):  neptunkod, nev,  evfolyam
b. A neptunkod legyen string típusú
c. A név két mezőből álljon: vezeteknev és keresztnev (Object típus)
d. Az evfolyam egész szám legyen (Int32)

OPCIONÁLISAN: a feladat a MongoDB Compass-ban, a VS Code-ban vagy a MongoDB Shell-ben is megoldható


6. Indítsa el a MongoDB Compass alkalmazást, majd csatlakozzon a MongoDB cluster-hez! 


Ha korábban sikerült a kapcsolódás, akkor baloldalt a Recent részben kiválaszthatja a kapcsolatot
Sikertelen kapcsolat esetén a baloldalon lévő Network Access részben adja hozzá az aktuális IP-címét a tűzfal kivételekhez!
a. Hozzon létre új adatbázist Gyak_compass néven, azon belül egy új gyújteményt receptek néven!
b. A receptek gyűjteménybe importálja be a 2. melléklet tartalmát (Add data / Import File, majd Select File, végül Import)!

OPCIONÁLISAN: a feladat a VS Code-ban is megoldható


7. A MongoDB Compass segítségével kérdezze le az előző feladatban létrehozott receptek gyűjtemény azon dokumentumait, amelyre teljesül:

a. A lájkok száma több, mint 2!
b.  A lista legyen sorbarendezve a főzési idő szerint csökkenő sorrendben! (A rendezés funkció az Options gomb lenyomása után érhető el)
c. A listában ne jelenjenek meg az ingredients és a rating mezők (Project szakasznál kell beállítani)!

```js
db.receptek.find({"likes_count": {$gt: 2}}).sort({"cook_time": -1})

```

OPCIONÁLISAN: a feladat a VS Code-ban vagy a MongoDB Shell-ben is megoldható

8. Az előző feladatban létrehozott lekérdezésre hajtsa végre az Explain Plan funkciót!

```js

```

OPCIONÁLISAN: a feladat a VS Code-ban vagy a MongoDB Shell-ben is megoldható

1. A MongoDB Compass-ban készítsen új indexet a 7. feladatban importált receptek gyűjteményhez az Indexes rész Create Index funkciójának segítségével!


a. Az index neve legyen i_title, és a title mező szerint csökkenő legyen
b. Az index  egyedi (unique) legyen (Options rész)!

OPCIONÁLISAN: a feladat a VS Code-ban vagy a MongoDB Shell-ben is megoldható

10. A MongoDB Compass-ban nyissunk egy parancssort (MongoDB shell)!
a. Adjuk ki a show dbs parancsot!
b. Csatlakozzunk a gyak_compass adatbázishoz!

```js

```

11. A mongo shellben kérdezzük le, hogy a receptek gyűjteményben mely dokumentumoknál szerepel a recept nevében (title) a Tacos szó!

a. A megjelenés kellően szép (json-szerű) legyen!


```js
db.receptek.find({"likes_count": {$gt: 2}}).sort({"cook_time": -1}).pretty()

```
OPCIONÁLISAN: a feladat a MongoDB Compass-ban, vagy a VS Code-ban is megoldható

12. A mongo shell-ben kérdezzük le, hogy recept  típusonként (type) mennyi a főzési idők (cook_time) összege!

```js
db.receptek.aggregate(
[
  {
$group: {"_id": "$type",
total: {$sum: "$sum": "$cook_time"}}
}
]
)
```
OPCIONÁLISAN: a feladat a MongoDB Compass-ban, vagy a VS Code-ban is megoldható


13. A mongo shell-ben kérdezzük le, hogy a receptek gyűjteményben hány olyan dokumentum van, ahol:

a. A recept 4 főre szól (servings) ÉS
b. A tag-ek között szerepel a "quick" vagy az "easy" (legalább az egyik)


```js

```

OPCIONÁLISAN: a feladat a MongoDB Compass-ban, vagy a VS Code-ban is megoldható

14. A mongo shell-ben a receptek gyűjteményben a ObjectId("5e878f5220a4f574c0aa56db") azonosítójú dokumentum esetén módosítsuk a főzési időt (cook_time) 33 percre!

```js

```

OPCIONÁLISAN: a feladat a MongoDB Compass-ban, vagy a VS Code-ban is megoldható

15. A mongo shell-ben adjunk hozzá a ObjectId("5e5e9c470d33e9e8e3891b35") azonosítójú dokumentum likes tömbjéhez még egy értéket, mégpedig a 200-at!


```js

```

OPCIONÁLISAN: a feladat a MongoDB Compass-ban, vagy a VS Code-ban is megoldható