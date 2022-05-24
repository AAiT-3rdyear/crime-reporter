const passport = require('passport');
const bcrypt = require('bcrypt')
const LocalStrategy = require('passport-local').Strategy
const User = require('../models/user_model');


passport.use (new LocalStrategy (
    (email, password, done) => {
   User.findOne ({email: email}, (err, foundUser) => {
     
     if (err) return done (err);
     if (!foundUser) { return done (null, false, {
         success: false,
         message: 'Invalid Username or password .',
       });}


     if (!(bcrypt.compareSync(password, foundUser.password))) {
       return done (null, false, {
         success :false,
         message: 'Invalid username or Password.',
       });
     }
     return done (null, foundUser);
   });
 }
)
);


passport.serializeUser((user, done) => {
done(null, user.email);});

passport.deserializeUser((email, done)=> {
User.findOne({email:email}, (err, user)=>{done(err, user)});
});