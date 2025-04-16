const express = require('express');
const router = express.Router();

const transactionsController = require('../../http/controllers/transactionsController')

router.get('/', transactionsController.showList);
router.post('/add', transactionsController.add);
router.put('/update/:id', transactionsController.update);
router.delete('/delete/:id', transactionsController.delete);

module.exports = router