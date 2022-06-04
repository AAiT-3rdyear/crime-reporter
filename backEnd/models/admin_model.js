

const mongoose = require('mongoose')
const bcrypt = require('bcrypt')
const admin_schema = new mongoose.Schema({
    fullname : {type: String, required:true,},
    username : {type:String, required:true},
    imageURL : {type:String,default:'default.jpg'},
    email: {type:String,required:true,unique:true,},
    phone_no:  {type:String,required:true, unique:true},
    password : { type:String, required:true,},    
})


const Admin = mongoose.model('Admin' , admin_schema)

const admin = new Admin({
    fullname:'demse legesse',
    username: "Admin",
    email: "dem@gmail.com",
    phone_no:"0980787890",
    password: bcrypt.hashSync("admin",6)
})

//  admin.save()
module.exports = Admin


