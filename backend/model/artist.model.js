var mongoose = require('mongoose')
var Schema = mongoose.Schema

var ArtistSchema = new Schema({
    name: 
    {
        type: String,
        unique : true,
        required : true,
        dropDups: true
    },
    img: String,
    genre: [String],
    tag: [String]
})

module.exports = mongoose.model('artist', ArtistSchema)