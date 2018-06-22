var mongoose = require('mongoose')
var Schema = mongoose.Schema

var ArtistSongSchema = new Schema({
    song: {
        type: Schema.Types.String,
        ref: 'song'
    },
    artist: {
        type: Schema.Types.String,
        ref: 'artist'
    }
})

module.exports = mongoose.model('artistsong', ArtistSongSchema)