var jwt = require('jsonwebtoken');
var salt_string = require('../models/secret').salt_string;
var User = require('../models/user_model');


module.exports = {
        authenticateUser: function (req, res, next) { 
        var token = req.headers['token'];
        jwt.verify(token, salt_string, (err, decoded) => {
            if (err) res.json(err);
            else {
                const email = decoded.email;
                User.findOne({email: email}, (err, user) => {
                    if (err) res.json(err);
                    // else if (!user) res.json('user does not exist ');
                    
                    else {
                        req.decoded = decoded;
                        next();
                    }
                });
            }
        });
        
       
    },
  
}