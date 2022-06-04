const express = require('express')
const bcrypt = require('bcrypt')
const router = express.Router()
const User = require('../models/user_model');


router.use(express.json())
router.use(express.urlencoded({extended:true}))


router.get("/get",(req,res)=>{
    User.find({role:"Police"},(err,users)=>{
        if(!err) res.json(users);
        else res.json(err);
    })
})


router.post("/addPolice",(req,res)=>{
    const email = req.body["email"]
    User.findOne({email:email},(err,police)=>{
        if(err) res.json(err)
        if (police) res.json("user alrealdy exists")
        else{
               const new_station = new User({
                fullname: req.body['fullname'],
                email:req.body['email'],
                password: bcrypt.hashSync(req.body['password'],6),
                phone_no:req.body['phone_no'],
                role:"Police",
                location:req.body['location'],

               })

               new_station.save((err) => {
                if (err) res.json(err);
                else res.json({
                    success : true,
                    station:new_station
                });
            });
        }
  
    })
})


router.put("/update/:username",(req,res)=>{
    User.findOneAndUpdate({username :req.params.username},
        { $set:{
            fullname : req.body['fullname'],
            username : req.body['username'],
            password: bcrypt.hashSync(req.body['password'],6),
            phone_no : req.body['phone_no'],
            email : req.body['email'],
            imgUrl:req.body["imgUrl"],
            role:req.body['role']
            }   
        },
        {new:true},
        (err,user)=>{
            if(err) res.json('something went wrong')
            else res.json({
                param:req.params.username,
                success:true,
                user:user}) }
        )
        })

router.get('/delete/:username',(req,res)=>{
    const username = req.params.username
    User.findOneAndRemove({username:username},(err,user)=>{
        if(!err && user)  res.status(200).json({
            message:"deleted succefully",
            user:user});
        else res.json({
            message:"user not found",
            err:err})

    })
    })
    


router.post("/logout",(req,res)=>{
})

module.exports = router