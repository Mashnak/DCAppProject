// Author: Khaled Ahmed
var mongoose = require('mongoose')
var Schema = mongoose.Schema

var ArtistSongSchema = new Schema({
    song: {
        type: Schema.Types.String,
        ref: 'song',
        unique: false
    },
    artist: {
        type: Schema.Types.String,
        ref: 'artist',
        unique: false
    }
})

ArtistSongSchema.index({ song: 1, artist: 1 },{ unique: true })

module.exports = mongoose.model('artistsong', ArtistSongSchema)