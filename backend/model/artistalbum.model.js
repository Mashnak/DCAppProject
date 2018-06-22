var mongoose = require('mongoose')
var Schema = mongoose.Schema

var ArtistAlbumSchema = new Schema({
    album: {
        type: Schema.Types.String,
        ref: 'album'
    },
    artist: {
        type: Schema.Types.String,
        ref: 'artist'
    }
})

module.exports = mongoose.model('artistalbum', ArtistAlbumSchema)