
var authenticateUser = require('./authenticationHelper').authenticateUser;
const CrimeSample = require('../models/crimeSample_model');
const User = require('../models/user_model');
const Crime = require('../models/crime_model');
const { json } = require('body-parser');
const multer = require("multer");
const bcrypt = require('bcrypt')
const express = require('express');
const { Code } = require('mongodb');
const router = express.Router()
router.use(express.urlencoded({ extended: true }));
router.use(express.json())



// sign up request
router.post('/signup', (req, res) => {
    var fullname = req.body['fullname'];
    var password = req.body['password'];
    var phone_no = req.body['phone_no'];
    var email = req.body['email'];

        User.findOne({email: email.trim()}, (err, user) => {
            if (err) res.json({name: 'name',err});
            else if (user) res.json({status:'email exists'});
            else {     
                const new_user = new User({
                    fullname: fullname.trim(),
                    phone_no: phone_no.trim(),
                    password: bcrypt.hashSync(password,6),
                    email: email.trim(),
                    role:req.body["role"],
                    imageURL:req.body['imageURL']
                });
                new_user.save((err) => {
                    if (err) res.json(err);
                    else res.json({
                        user:{
                            _id:new_user._id,
                            fullname:new_user.fullname,
                            email: new_user.email,
                            phone_no:new_user.phone_no,
                            password:new_user.password,
                            imgUrl: new_user.imageURL

                         },
                        success : true,
                        fullname: fullname.trim(),
                 });
             });
        }
    });
});


// requesting crime samples 
router.get('/crimeSample',(req,res)=>{
    CrimeSample.find({},
        (err,crimes)=>{
        if(!err) res.json(crimes);
        else res.json(err);
    })
  })

const storage = multer.diskStorage({
       destination: (req,file,cb)=>{
        cb(null, './uploads');
         },
       filename:(req,file,cb)=>{
         cb(null, file.originalname);
         }
  })
const upload = multer({ storage:storage });

// uploading image 
router.post("/add/image",authenticateUser, upload.single('img'),async (req,res)=>{
        try {
            res.json({path:req.file.originalname})  
           }
        catch (e){
            res.json({eror :e})
           }
        })


// creating new report of crime
router.post("/crime/report",authenticateUser, (req,res)=>{
        const new_crime = new Crime({
            title:req.body.name,
            description:req.body.description,
            location:req.body.location,
            time: req.body.time,
            imageURL: req.body.imageURL,
            report_to : req.body.report_to,
            status:req.body.status,
            reporter:JSON.parse(req.body.reporter)
        });

        new_crime.save((err) => {
            if (err) res.json(err);
            else res.json({
                crime:{
                title:req.body.name,
                description:req.body.description,
                location:req.body.location,
                time: req.body.time,
                imageURL: req.body.imageURL,
                report_to : req.body.report_to,
                status:req.body.status,
                reporter:JSON.parse(req.body.reporter)
                    },
                success : true,
                });
        });
   })

// getting all user posts 
router.get("/myreports/:me",(req,res)=>{
    Crime.find({reporter:req.params.me},(err,crimes)=>{
        if(err) res.json(err)
        if(!crimes) res.json("no crimes reported")
        else res.json(crimes)
    }).sort({'_id':-1})
})


// deleting crime report
router.get('/delete/crime/:id',(req,res)=>{
    const id = req.params.id
    Crime.findOneAndRemove({_id:id},(err,crime)=>{
        if(!err && crime)  res.status(200).json({
            message:"deleted succefully",
            deleted:crime});
        else res.json({
            message:"crime not found",
            err:err})

      })
    })

module.exports = router;



