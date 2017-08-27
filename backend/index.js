
// Import libraries
var Web3        = require('web3'),
    contract    = require("truffle-contract"),
    path        = require('path')
    ProvenFood    = require(path.join(__dirname, 'build/contracts/ProvenFood.json'));
    const express = require('express');
    const app = express();

    
var provider    = new Web3.providers.HttpProvider("http://localhost:8545"),    
    filePath    = path.join(__dirname, 'build/contracts/ProvenFood.json');
 
var bodyParser = require('body-parser');
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

var ProvenFoodContract = contract(ProvenFood);
ProvenFoodContract.setProvider(provider);

app.get('/getHistory', function (req, res) {
    
    console.log("getting history for " + req.query.uniqueId);


    ProvenFoodContract.deployed().then(function(deployed){

        deployed.getHistory(req.query.uniqueId).then(function(value){
            res.send(JSON.stringify(value));
        })
    })
    
  })

app.post('/signFood', function (req,res){

    console.log("signing food for "+req.body.uniqueId);

    ProvenFoodContract.deployed().then(function(deployed){
        
        deployed.signFood(req.body.uniqueId);
    })
})

app.post('/newFood', function (req,res){

    ProvenFoodContract.deployed().then(function(deployed){
        deployed.newFood(parseInt(req.body.weight),req.body.amount,req.body.name,req.body.uniqueId);
    })
})
  
app.listen(3000, function () {
console.log('Example app listening on port 3000!')
})



/* ProvenFoodContract.deployed().then(function(instance) {

    return instance.getBalance.call('0x13a0674c16f6a5789bff26188c63422a764d9a39', {from: '0x13a0674c16f6a5789bff26188c63422a764d9a39'})
    
}).then(function(result) {
    console.log(result);
    
}, function(error) {
    console.log(error);
}); 
     */
