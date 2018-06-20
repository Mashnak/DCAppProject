var mongoose = require('mongoose')
var Schema = mongoose.Schema

var ArtistAlbumSchema = new Schema({
    album: {
        type: Schema.Types.String,
        ref: 'Album'
    },
    artist: {
        type: Schema.Types.String,
        ref: 'Artist'
    }
})

module.exports = mongoose.model('ArtistAlbum', ArtistAlbumSchema)