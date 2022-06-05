
const express = require('express');
const User = require('../models/user_model');
const CrimeSample = require('../models/crimeSample_model');
const router = express.Router()
router.use(express.json())
var authenticateUser = require('./authenticationHelper').authenticateUser;
router.use(express.urlencoded({ extended: true }));
const multer = require("multer");
const Crime = require('../models/crime_model');
const { json } = require('body-parser');
const { route } = require('./user_routes');

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

router.post("/add/image",upload.single('img'),async (req,res)=>{
 try {
    console.log(req.file.filename)
     res.json({path:req.file.originalname})  
 }
 catch (e){
     res.json({eer:e})
 }
})


router.post("/report",(req,res)=>{

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


router.post('/crimeSample',(req,res)=>{
    const new_sample = CrimeSample({
        imageURL : req.body.imageURL,
        name:req.body.name
    })
      new_sample.save((err)=>{
          if(err) res.json(err)
          else res.json({
              success:true,
              newsample:new_sample})
      })

})


// geting all my reports
router.get("/myreports/:me",(req,res)=>{
    Crime.find({reporter:req.params.me},(err,crimes)=>{
        if(err) res.json(err)
        if(!crimes) res.json("no crimes reported")
        else res.json(crimes)
    }).sort({'_id':-1})
})

router.get('/delete/:id',(req,res)=>{
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



