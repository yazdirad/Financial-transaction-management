const express = require('express');
const router = express.Router();

router.get('/balance', (req, res) => {
    res.render('reports/balance')
});

module.exports = router