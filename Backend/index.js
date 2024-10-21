const express = require('express')
const {Web3} = require('web3');

const app = express()

app.use(express.json())


const web3 = new Web3('http://127.0.0.1:7545')


// <-------------------------------------------------------------------- Functions ----------------------------------------------------------------->

//GetBalance Function
const getBalance = async (privateKey) => {
    // Get the account from the private key
    const account = web3.eth.accounts.privateKeyToAccount(privateKey);
    const balance = await web3.eth.getBalance(account.address);
    return web3.utils.fromWei(balance, 'ether');
};

// <-------------------------------------------------------------------- API's ----------------------------------------------------------------->

// Endpoint to get balance
app.get('/balance/:privateKey', async (req, res) => {
    try {
        const {privateKey} = req.params;
        const balance = await getBalance(privateKey);
        res.send(balance);
    } catch (error) {
        console.error(error);
        res.status(500).send('Error getting balance');
    }
});

app.listen(3000,() => {
    console.log("Server Running at ",3000)
})