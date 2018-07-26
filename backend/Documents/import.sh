#! /bin/bash
#Author: Khaled Ahmed
mongoimport --db test --collection albums --type json --file Documents/album.json
mongoimport --db test --collection artists --type json --file Documents/artist.json
mongoimport --db test --collection songs --type json --file Documents/bundesliga.json
mongoimport --db test --collection songs --type json --file Documents/movies.json
mongoimport --db test --collection songs --type json --file Documents/nationalhymne.json
mongoimport --db test --collection artistsongs --type json --file Documents/artistsong.json
mongoimport --db test --collection artistalbums --type json --file Documents/artistalbum.json
