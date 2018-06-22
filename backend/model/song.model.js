var mongoose = require('mongoose')
var Schema = mongoose.Schema

var SongSchema = new Schema({
    name: 
    {
        type:String,
        unique : true,
        required : true,
        dropDups: true
    },
    length:String,
    releaseDate: Date,
    lyrics: String,
    urls: [{
        name: String,
        link: String 
    }],
    album: {
        type: Schema.Types.String,
        ref: 'album'
    }
})

module.exports = mongoose.model('song', SongSchema)