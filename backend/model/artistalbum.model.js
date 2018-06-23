var mongoose = require('mongoose')
var Schema = mongoose.Schema

var ArtistAlbumSchema = new Schema({
    album: {
        type: Schema.Types.String,
        ref: 'album',
        unique: false
    },
    artist: {
        type: Schema.Types.String,
        ref: 'artist',
        unique: false
    }
})

ArtistAlbumSchema.index({ album: 1, album: 1 },{ unique: true })

module.exports = mongoose.model('artistalbum', ArtistAlbumSchema)