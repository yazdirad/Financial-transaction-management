const express = require('express');
const router = express.Router();

router.get('/', (req, res) => {
    res.render('units/list')
});

router.get('/add', (req, res) => {
    res.render('units/add')
});

module.exports = router