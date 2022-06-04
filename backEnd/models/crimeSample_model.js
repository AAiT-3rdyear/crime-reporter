const mongoose = require('mongoose')
const Schema = mongoose.Schema

const crimeSampleSchema = Schema({
    name:{type:String},
    imageURL:{type:String},
   
})


const CrimeSample = mongoose.model("CrimeSample",crimeSampleSchema)
module.exports = CrimeSample