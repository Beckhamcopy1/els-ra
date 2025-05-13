# 11. gyakorlat - feladatok

## Előkészületek


### Cassandra
+ Regisztráljunk a DataStax oldalán (https://www.datastax.com/dev), majd hozzunk létre egy saját (ingyenes ) adatbázist!



## Cassandra feladatok

1. Kattintston a https://www.datastax.com/try-it-out linkre, majd jelentkezzen be a DataStax Astra-ba!

a. Hozzon létre új adatbázist Proba néven, a keyspace name legyen Movies

b. A Provider legyen a Google Cloud, a régió pedig tetszőlegesen választott az ingyenesek közül

Az adatbázis létrehozása néhány percet igénybe vehet



2. A  DataStax Astra-ban

a. Kattintsunk az adatbázisunk nevére, majd válasszuk a Load Data lehetőséget!

b. Töltsük be a Movies and TV Shows dataset-et: 
    - a partition key legyen: type, release_year
    - a clustering columns legyen: title
    - az adatokat a Movies keyspace-be töltsük be



3. A DataStax Astra-ban nyissunk egy CQL konzolt (az adatbázisra kattintva, majd CQL Console)!

a.Kérdezzük le a rendszer verzióját (show version;), és az eredménysort adjuk meg a válaszhoz!

```js

```

4. A DataStax Astra CQL konzolon kérdezzük le, hogy a movies keyspace movies_and_tv táblájának hány sora van!

a. A lekérdező utasítást adjuk meg válaszként!

```js
select count(*)
from movies_and_tv;
```


5. A DataStax CQL konzolon kérdezzük le, hogy mi azoknak a filmeknek a címe, amelyek típusa Movie, és 2018-ban jelentek meg (release_year)!

a. A szükséges csak az első 3 találatot jelenítse meg

b. A lekérdezést adjuk meg válaszként!

```js
select title
where type = 'Movie' AND release_year = 2018
limit 3;
```

6. A DataStax Astra CQL konzolon kérdezzük le, hogy a movies_and_tv táblában típusonként, azon belül évenként hány rekord van!

a. A lekérdezést adjuk meg válaszként!

```js
select type, release_year, count(*)
from movies_and_tv
group by type, release_year; 
```

7. Telepítsük fel saját gépünkre a Cassandra-t, majd a CQL Shell-ben hozzunk létre új keyspace-t kps néven!

a. A replikációs stratégia legyen SimpleStrategy

b. A replikációs faktor legyen 3!

c. A szükséges utasítást adjuk meg válaszként!

Ha nincs lehetőségünk telepíteni, akkor hozzuk létre az új keyspace-t a DataStax Astra grafikus felületén!

```js

```

8. A Cassandra CQL Shell-ben tegye aktuálissá az előzőleg létrehozott kps keyspace-t!

a. Hozzon létre egy új táblát Szemely néven, amelynek mezői: 
     nev - szöveg, szulev - egész, foglalkozas - szöveg

b. A partition key legyen: (nev, szulev), a clustered key pedig foglalkozas

c. A táblát létrehozó parancsot adjuk meg válaszként!

```js
create table szemely
       ... (
       ... nev TEXT,
       ... szulev INT,
       ... foglalkozas TEXT,
       ... PRIMARY KEY ((nev, szulev), foglalkozas)
       ... );
```

9. A Cassandra CQL Shell-ben az előző feladatban létrehozott Szemely táblába rögzítsen 3 új rekordot:

 nev        szulev        foglalkozas
Kiss Bela    2000       lakatos
Nagy Ivo     1999       diak
Toth Otto     1980       pincer

a. A rögzítés után listázza a Szemely tábla tartalmát, az utasításokat adja meg válaszként!

```js
insert into szemely (nev, szulev, foglalkozas) values ('Kiss Béla', 2000, 'lakatos');
insert into szemely (nev, szulev, foglalkozas) values ('Nagy Ivo', 1999, 'diak');
insert into szemely (nev, szulev, foglalkozas) values ('Toth Otto', 2000, 'pincer');
select *
from szemely;
```

10. A Cassandra CQL Shell-ben készítsen indexet a Szemely táblához a foglalkozas oszlop alapján!

a. Az index neve legyen i_foglalkozas

b. A szükséges parancsot adja meg válaszként!

```js
create index i_foglalkozas
ON szemely(foglalkozas);
```

11. A Cassandra CQL Shell-ben kérdezze le azokat a személyeket, akiknek foglalkozása pincer vagy lakatos!

a. Csak a személyek neve jelenjen meg!

b. A szükséges lekérdezést adja meg válaszként!
   (szükség esetén a lekérdezés végén használja az ALLOW FILTERING záradékot)

c. A lekérdezést adja meg válaszként!

```js
select nev
from szemely
where foglalkozas IN ('pincer', 'lakatos');
```

12. A Cassandra CQL Shell-ben bővítse a Személy táblát egy új mezővel

a. A mező neve legyen Vegzettseg, típusa LIST<TEXT>

b. Kiss Bela végzettsegei legyenek 'gepesz' és 'muszeresz'
   (az UPDATE utasítás WHERE feltételében minden kulcsmezőt meg kell adni!)

c Az új mezőt létrehozó, és a végzettségeket megadó parancsokat (2 db) adja meg válaszként!

```js
alter table szemely
       ... add vegzettseg LIST<TEXT>;
token@cqlsh:kps> update szemely
       ... set vegzettseg = vegzettseg + ['gépész', 'műszerész']
       ... where nev = 'Kiss Béla' AND szulev = 2000 AND foglalkozas = 'lakatos';
```

13. A Cassandra CQL Shell-ben bővítsük a Szemely táblát egy új mezővel!

a. A mező neve legyen Nyelvtudas, típusa pedig SET<TEXT>

b. Nagy Ivo nyelvtudása legyen: 'angol' és 'francia'

c. A szükséges parancsokat (2 db) adjuk meg válaszként!

```js

```

14. A Cassandra CQL Shell-ben adjon hozzá még egy új oszlopot a Szemely táblához!

a. Az oszlop neve legyen Autok, típusa MAP<TEXT, TEXT>

b. Rögzítsük, hogy Kiss Bela esetén az Autok mező értéke: {'Skoda Fabia': 'abc-111', 'Audi A4': 'xyz-222' }

c. A szükséges utasításokat (2 db) adjuk meg válaszként!

```js

```

15. A Cassandra CQL Shell-ben módosítsuk a Szemely tábla következő adatait:

a. Nagy Ivó megtanult németül is, vegyük fel ezt is a nyelvtudásai közé

b Toth Otto elvégezte a bármixer szakot, vegyük fel ezt a végzettségei közé

c. A szükséges 2 utasítást adjuk meg válaszként!


```js

```
















