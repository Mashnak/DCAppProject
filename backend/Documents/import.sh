#! /bin/bash

mongoimport --db test --collection Genre --type json --file Documents/genre.json
mongoimport --db test --collection Tag --type json --file Documents/tags.json
mongoimport --db test --collection Album --type json --file Documents/album.json
mongoimport --db test --collection Artist --type json --file Documents/artist.json
mongoimport --db test --collection Song --type json --file Documents/bundesliga.json
mongoimport --db test --collection Song --type json --file Documents/movies.json
mongoimport --db test --collection Song --type json --file Documents/nationalhymne.json