const express = require('express');
const router = express.Router();


const unitsController = require('./../../http/controllers/unitsControlles')

router.get('/', unitsController.showList);
router.post('/', unitsController.getList);
router.post('/add', unitsController.addUnit);
router.put('/update/:id', unitsController.updateUnit);
router.delete('/delete/:id', unitsController.deleteCategory);

// router.get('/add', (req, res) => {
//     res.render('units/add')
// });

module.exports = router