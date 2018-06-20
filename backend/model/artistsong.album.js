var mongoose = require('mongoose')
var Schema = mongoose.Schema

var ArtistSongSchema = new Schema({
    Song: {
        type: Schema.Types.String,
        ref: 'Song'
    },
    artist: {
        type: Schema.Types.String,
        ref: 'Artist'
    }
})

module.exports = mongoose.model('ArtistSong', ArtistSongSchema)