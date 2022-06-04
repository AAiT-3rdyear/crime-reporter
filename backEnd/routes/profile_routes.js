
const bcrypt = require('bcrypt')
const express = require('express');
const User = require('../models/user_model');
const router = express.Router()
const multer = require("multer");
router.use(express.json())
var authenticateUser = require('./authenticationHelper').authenticateUser;
router.use(express.urlencoded({ extended: true }));


const storage = multer.diskStorage({
    destination: (req,file,cb)=>{
        cb(null, './uploads');
    },
    filename:(req,file,cb)=>{
         cb(null, file.originalname);
        
        }
})


const upload = multer({
    storage:storage
});

router.post("/update/image",authenticateUser, upload.single('img'),async (req,res)=>{
 await User.findOneAndUpdate({username:req.body.email},
    {$set:{imageURL:req.file.originalname}},
    (err,user)=>{
        if (err) res.json({err:err})
        else res.json({
            gama:'gama',
            user:user})
    }
    ).clone()
})


// router.post("/update",(req,res)=>{

    // const profile = new User({
    //     fullname: fullname.trim(),
    //     phone_no: phone_no.trim(),
    //     email: email.trim(),
    //     role:req.body["role"],
    //     imageURL:req.body['imageURL']
    // });


    // profile.save((err) => {
    //     if (err) res.json(err);
    //     else res.json({
    //         user:{
    //             _id:new_user._id,
    //             fullname:profile.fullname,
    //             email: profile.email,
    //             phone_no:profile.phone_no,
    //             password:profile.password,
    //             imgUrl: profile.imageURL

    //          },
    //         success : true,
    //         fullname: fullname.trim(),
    //      });
    // });



// })

router.patch("/update/profile",async (req,res)=>{
    await User.findOneAndUpdate({username:req.body.email},
        {$set:{
            fullname:req.body.fullname,
            email: req.body.email,
            password:bcrypt.hashSync(req.body.password,6),
            phone_no:req.body.phoneNo,
           
        }},
        {new: true},
        (err,user)=>{
            if (err) res.json({err:err})
            else res.json({
                "name":"gam",
                user:user})
           }
        ).clone()
    })


module.exports = router;



