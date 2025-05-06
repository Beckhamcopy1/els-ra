# 10. gyakorlat - feladatok



## Redis feladatok


1\.	Regisztráljunk a Redis Cloud oldalán, majd hozzunk létre egy saját (ingyenes) adatbázist!



2.\ Csatlakozzon a Redis Cloud adatbázisához a Redis Insight segítségével, majd töltsük be a minta adatokat!



3.\ A redis-cli-ben (A Redis Insight-ban lévő cli is használható) hozzon létre három új kulcs-érték párt: ev 2021, honap 4, nap 26

a. A kulcsok lejárati ideje 10 másodperc legyen
b. A kulcsok létrehozásához szükséges utasításokat adja meg válaszként!

```js
set ev 2021 ex 10
set honap 4 ex 10
set nap 26 ex 10
```



4.\ A redis-cli-ben hozzon létre egy új hash kulcsot auto néven, amelynek értéke a következő rekordnak megfelelő legyen:

rendszam    tipus                  evjarat  ertek
xxx-111        Skoda Fabia     2012     1500000

a A létrehozáshoz szükséges utasítást adja meg válaszként!

```js
hset auto rendszam xxx-111 tipus "Skoda Fabia" evjarat 2012 ertek 1500000
```

5.\ A redis-cli-ben hozzon létre új lista típusú kulcsot tantargyak néven, amelyek értékei a következők legyenek: programozas alapjai, matematika, adatbaziskezeles

a. A lista végére szúrjon be még egy tantárgyat: operacios rendszerek
b. A listát létrehozó és a lista végére beszúró parancsokat (két parancs) adja meg válaszként!

```js
rpush tantargyak "programozas alapjai" matematika "adatbazis kezeles" //nincs kész
```


6.\ A redis-cli-ben hozzunk létre új két új halmaz típusú kulcsot:

numbers1: 10, 20, 30, 40, 50, 60 és numbers2: 15, 30, 45, 60

a. Képezzük a halmazok metszetét!
b. A halmazokat létrehozó, és a metszetüket lekérdező utasításokat (3 utasítás) adja meg a válaszhoz!

```js
sadd numbers1 10 20 30 40 50 60
sadd numbers2 15 30 45 60
SINTER numbers1 numbers2
```


7.\ A redis-cli-ben hozzunk létre új sorted set-et szemelyek néven, ahol az egyes pontszámok az életkorok legyenek: Andras 15 éves, Peter 20 éves, Juli 18 éves

a. Kérdezzük le a 16-18 pontszámok közötti személyek számát!
b. A sorted set-et létrehozó és a lekérdező utasításokat (két utasítás) adjuk meg válaszként!

```js
zadd szemely 15 Andras 20 Peter 18 Juli
zcount szemelyek 16 18
zrange szemelyek 0 -1
```


8.\ A redis-cli-ben kérdezzük le az adatbázisban lévő azon kulcsokat, amelyek nevében van a betű!

a. A parancsot adja meg válaszként!

```js
scan 0 match "*a*" count 200
```

9.\ A redis-cli-ben rendezzuk a korabban letrehozott sorted set-et pontszam szerint fordított sorrendbe!

a. A szükséges utasítást adja meg válaszként!

```js

```

10.\ A redis-cli-ben a korábban létrehozott szemelyek sorted set-ben növeljük Juli életkorát 10 évvel, majd ismét listázzuk a szemelyek sorted set elemeit!

a. A szükséges utasításokat (két utasítás) adjuk meg válaszként!

```js

```

11.\ A redis-cli-ben hajtsuk végre a következő adatmódosításokat:

a. Nevezzük át a numbers1 kulcsot numbers01-re
b. Töröljük az auto kulcsot
c. A szükséges 2 utasítást adjuk meg válaszként!

```js

```

12.\ Hozza létre mezőnként és soronként külön kulcsok segítségével a dolgozo tábla következő rekordjait:

nev           munkakor                kod
Nagy Eva   titkarno                  1
Kiss Ilona   konyvelo                2

a. A szükséges utasításokat tartalmazó képernyőrészt adja meg válaszként kép formájában!

```js

```

13.\ A redis-cli-ben hozzuk létre a projekt táblának megfelelő adatszerkezetet soronként és mezőnként külön kulcsokkal! A kulcsok megadásánál ügyeljünk a projekt és a dolgozo tábla közötti kapcsolatra!

projektkod    projektnev     dolgozokod
1                   EURO-33       1
3                   TRANS-22      2

a. A szükséges utasításokat adjuk meg válaszként kép formájában!

```js

```

14.\ A redis-cli-ben hozzuk létre a dolgozo tábla (ld. 12-es feladat) nev oszlopának megfelelő adatszerkezetet dolgozo_nev néven!

a. A szükséges utasítást adja meg válaszként!

```js

```

15.\ A redis-cli-ben listázza a létező kulcsok számát a dbsize utasítás segítségével!

a. Az utasítást másolja be a válaszhoz!

```js

```
