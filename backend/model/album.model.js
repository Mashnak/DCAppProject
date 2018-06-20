var mongoose = require('mongoose')
var Schema = mongoose.Schema

var AlbumSchema = new Schema({
    name: 
    {
        type:String,
        unique : true, 
        required : true, 
        dropDups: true
    },
    releaseDate: Date,
    img:String,
    genres: String,
    tags: String,
})

module.exports = mongoose.model('Album', AlbumSchema)