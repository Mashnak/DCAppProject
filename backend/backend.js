var express = require('express')
var app = express()
var mongoose = require('mongoose')

var PORT = 3000
var HOST = '0.0.0.0'
var dbUrl = 'mongodb://127.0.0.1:27017'

mongoose.Promise = Promise

var Song = mongoose.model('Song', {
    name: String,
    length: String,
    releaseDate: String,
    lyrics: String,
    URLs: String,
    genres: String,
    tags: String,
    publisher: String,
    album: String,
    artists: String,
})

app.use(express.static(__dirname))

app.get('/song', (req, res) => {
    res.send('hi')
})

app.get('/song/:song', (req, res) => {
    var songname = req.params.song
    Song.find({
        name: songname
    }, (err, messages) => {
        res.send(messages)
    })
})

app.get('/init', (req, res) => {
    var song = new Song({
        name: 'name',
        length: 'length',
        releaseDate: 'releaseDate',
        lyrics: 'lyrics',
        url: 'url',
        genre: 'genre',
        tag: 'tag',
        publisher: 'publisher',
        album: 'album',
        artist: 'artist'
    })

    song.save(function (err) {
        if (err) return handleError(err)
    })
    res.send('rest')
})

mongoose.connect(dbUrl, (err) => {
     console.log('mongo db connection', err)
})

var server = app.listen(PORT, HOST, () => {
    console.log('server is listening on port', server.address().port)
})