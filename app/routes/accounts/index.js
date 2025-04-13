const express = require('express');
const router = express.Router();

const accountsController = require('../../http/controllers/accountsController')

router.get('/', accountsController.showList);
router.post('/add', accountsController.add);
router.put('/update/:id', accountsController.update);
router.delete('/delete/:id', accountsController.delete);

module.exports = router