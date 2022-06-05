const express = require("express")
const Crime = require("../models/crime_model")
const User = require("../models/user_model")
const router = express.Router()


router.get("/reportedCrimes/:user/:status",(req,res)=>{
    Crime.find({report_to : req.params.user, status:req.params.status},(err,crimes)=>{
        if(err) res.json(err)
        if(!crimes) res.json("no crimes reported")
        else res.json(crimes)
    })
})


// finding reported crimes 
router.get("/get",(req,res)=>{
    User.find({role:"Police"},(err,station)=>{
        if(err) res.json(err)
        if(!station) res.json("no crimes reported")
        else res.json(station)
    })
})

// deleting reported crime 
router.get('/crime/delete/:id',(req,res)=>{
    const id = req.params.id

    User.findOneAndRemove({_id:id},(err,crime)=>{
        if(!err && crime)  res.status(200).json({
            message:"deleted succefully",
            deleted:crime});
        else res.json({
            message:"crime not found",
            err:err})

    })
    })

// move to ongoing crimes
router.patch('/ongoing/:id', (req, res) => {
     Crime.findByIdAndUpdate(req.params.id,
        { $set:{ status:"ongoing", }},

        {new: true}).then((crime) => {
        if (!crime) {
            return res.json.status(404);
           }
        res.json({"moved":crime})
    }).catch((error) => {
        res.status(500).send(error);
    })
})

// move to solved  crimes
router.patch('/solved/:id', (req, res) => {
    Crime.findByIdAndUpdate(req.params.id,
         { $set:{ status:"solved", }},

         {new: true}).then((crime) => {
        if (!crime) {
            return res.json.status(404);
        }
        res.json({"moved":crime});
    }).catch((error) => {
        res.status(500).send(error);
    })
})



module.exports = router