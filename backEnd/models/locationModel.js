const mongoose = require('mongoose')
const Schema = mongoose.Schema

const locationSchema = Schema({
    city:{type:String},
    subcity:{type:String},
    street:{type:String},

   
})


const Location = mongoose.model("Location",locationSchema)
module.exports = Location