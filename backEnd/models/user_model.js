
const mongoose = require('mongoose')


const userSchema = new mongoose.Schema({
    fullname : {
        type: String, 
        required:true,},

    imageURL : {
        type:String,
        default:'default.jpg'},

    email: {
        type:String,
        required:true,
        unique:true,},

    phone_no:  {
        type:String,
        required:true},
    password : {
        type:String, 
        required:true,},
        
    role: {
        type:String,
         default:"User"}
    });

const User = mongoose.model('User', userSchema)
module.exports = User;