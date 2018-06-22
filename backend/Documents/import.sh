#! /bin/bash

mongoimport --db test --collection album --type json --file Documents/album.json
mongoimport --db test --collection artist --type json --file Documents/artist.json
mongoimport --db test --collection song --type json --file Documents/bundesliga.json
mongoimport --db test --collection song --type json --file Documents/movies.json
mongoimport --db test --collection song --type json --file Documents/nationalhymne.json
mongoimport --db test --collection artistsong --type json --file Documents/artistsong.json
mongoimport --db test --collection artistalbum --type json --file Documents/artistalbum.json
