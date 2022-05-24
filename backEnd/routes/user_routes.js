
const bcrypt = require('bcrypt')
const express = require('express');
const User = require('../models/user_model');
const CrimeSample = require('../models/crimeSample_model');
const { Code } = require('mongodb');
const router = express.Router()
router.use(express.json())
var authenticateUser = require('./authenticationHelper').authenticateUser;
router.use(express.urlencoded({ extended: true }));



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




router.get('/crimeSample',(req,res)=>{
    CrimeSample.find({},
        (err,crimes)=>{
        if(!err) res.json(crimes);
        else res.json(err);
    })
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

module.exports = router;



