const mongoose = require('mongoose')
mongoose.connect('mongodb://localhost:27017/crime_reporter',{useNewUrlParser:true});
const express = require('express')
const passport = require("passport")
const local = require('./routes/auth_routh')
const session  = require('express-session');
const store  =  new session.MemoryStore()
const app = express()
const config = require('./models/secret')
const jwt  = require("jsonwebtoken")
var authenticateUser = require('./routes/authenticationHelper').authenticateUser;
app.use("/uploads", express.static("uploads"))


app.use(session({
    secret: 'keyboard cat',resave: true,
    saveUninitialized: false,store
    }))

  
app.use(passport.initialize())
app.use(passport.session())
const user_route = require('./routes/user_routes')
const admin_route = require('./routes/admin_routes')
const police_route = require("./routes/police_routes")
const profile_route = require("./routes/profile_routes")

const bcrypt = require('bcryptjs/dist/bcrypt');
const { json } = require('body-parser');
app.use(express.json())
app.use(express.urlencoded({ extended: true }));


app.use("/uploads",express.static('uploads'))
app.use('/user',user_route)
app.use('/admin',admin_route)
app.use("/police",police_route)
app.use("/profile",profile_route)



app.post('/login', passport.authenticate('local'),
(req, res) =>{

    res.json({

      
        user:{
             token: jwt.sign({email: req.body.email},config.salt_string),
            _id:req.user._id,
            fullname:req.user.fullname,
            email: req.user.email,
            phone_no:req.user.phone_no,
            password:req.user.password,
            imgUrl: req.user.imageURL,
            role: req.user.role

         },
        success : true,
     })
   });    


const server = require('http').createServer(app)
const io = require('socket.io')(server)

var clients = {}
io.on('connection', function (client) {
  console.log('client connect...', client.id);

  client.on('login', function name(id) {
    console.log(id)
    clients[id] = client
  })

  client.on('report', function name(msg) {
      console.log(JSON.stringify(msg));
     if (clients[msg.targetID]){
        clients[msg.targetID].emit("report",JSON.stringify(msg.crime))
       }

  })

 
})


server.listen('3000',()=>{console.log('server starts running on port 3000');})
































