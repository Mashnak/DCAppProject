// Author: Khaled Ahmed
var mongoose = require('mongoose')
var Schema = mongoose.Schema

var AlbumSchema = new Schema({
    name: 
    {
        type: String,
        unique : true, 
        required : true, 
        dropDups: true
    },
    releaseDate: String,
    img: String,
    genre: [String],
    tag: [String] 
})

module.exports = mongoose.model('album', AlbumSchema)