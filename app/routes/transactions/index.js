const express = require('express');
const router = express.Router();

router.get('/', (req, res) => {
    res.render('transactions/list')
});

router.get('/add', (req, res) => {
    res.render('transactions/add')
});

module.exports = router