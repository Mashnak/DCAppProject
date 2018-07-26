// Author: Khaled Ahmed
var mongoose = require('mongoose')
var Schema = mongoose.Schema

var SongSchema = new Schema({
    name: 
    {
        type: String,
        unique : true,
        required : true,
        dropDups: true
    },
    length: String,
    releaseDate: String,
    link: [{
        name: String,
        url: String 
    }],
    img: String,
    tag: [String],
    genre: [String],
    lyrics: String,
    album: {
        type: Schema.Types.String,
        ref: 'album'
    }
})

module.exports = mongoose.model('song', SongSchema)