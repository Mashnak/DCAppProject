var express = require('express')
var app = express()
var mongoose = require('mongoose')

var PORT = 8080
var HOST = '0.0.0.0'

app.use(express.static(__dirname))

app.get('/song', (req, res) => {
    res.send('hi')
})

mongoose.Promise = Promise

var dbUrl = 'mongodb://user:user@127.0.0.1:27017/test'

var Song = mongoose.model('Song', {
    id: String,
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

app.get('/song/:song', (req, res) => {
    var songname = req.params.song
    Message.find({name: songname}, (err, messages) => {
        res.send(messages)
    })
})

mongoose.connect(dbUrl, (err) => {
    console.log('mongo db connection', err)
})

var server = app.listen(PORT, HOST, () => {
    console.log('server is listening on port', server.address().port)
})