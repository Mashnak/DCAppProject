var mongoose = require('mongoose')
var Schema = mongoose.Schema

var ArtistSchema = new Schema({
    name: 
    {
        type:String,
        unique : true,
        required : true,
        dropDups: true
    },
    genres:String,
    tags:String
})

module.exports = mongoose.model('Artist', ArtistSchema)