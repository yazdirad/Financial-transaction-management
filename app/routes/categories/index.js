const express = require('express');
const router = express.Router();

const categoriesController = require('./../../http/controllers/categoriesController')

router.get('/', categoriesController.showList);
router.post('/add', categoriesController.addCategory);
router.put('/update/:id', categoriesController.updateCategory);
router.delete('/delete/:id', categoriesController.deleteCategory);

module.exports = router