const express = require('express');
const router = express.Router();

const homeRoutes = require('./home');
const unitsRoutes = require('./units');
const categoriesRoutes = require('./categories');
const transactionsRoutes = require('./transactions');
const reportsRoutes = require('./reports');

router.use('/', homeRoutes);
router.use('/units', unitsRoutes);
router.use('/categories', categoriesRoutes);
router.use('/transactions', transactionsRoutes);
router.use('/reports', reportsRoutes);


// connection.connect(function (err) {
//     if (err) {
//         console.error('error connecting: ' + err.stack);
//         return;
//     }

//     console.log('connected as id ' + connection.threadId);
// });

// connection.connect();
// connection.query('SELECT * FROM units', function (error, results, fields) {
//     if (error) throw error;
//     console.log('The solution is: ', results);
// });
// connection.end();

router.get('/report', (req, res) => {
    res.render('report')
});


module.exports = router