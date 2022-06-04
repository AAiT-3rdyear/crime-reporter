const req = require('express/lib/request')
const mongoose = require('mongoose')
const Schema = mongoose.Schema


const crime_schema = mongoose.Schema({
    title:{type:String},
    location: {type:String,required:true},
    time: {type:String,required :true},
    description:{type:String,},
    imageURL:{ type:String},
    report_to:{type:String ,default:"kilinto"},
    status:{type:String },
    reporter: {type: Schema.Types.ObjectId, default:req.user, ref: 'User'},
})




crime_schema.methods.currentuser = function (req) {
    return this.reporter >= req.user;
}
const Crime = mongoose.model("Crime",crime_schema)


module.exports = Crime