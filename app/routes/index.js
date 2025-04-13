const express = require('express');
const router = express.Router();

const homeRoutes = require('./home');
const unitsRoutes = require('./units');
const categoriesRoutes = require('./categories');
const accountsRoutes = require('./accounts');
const transactionsRoutes = require('./transactions');
const reportsRoutes = require('./reports');

router.use('/', homeRoutes);
router.use('/units', unitsRoutes);
router.use('/categories', categoriesRoutes);
router.use('/accounts', accountsRoutes);
router.use('/transactions', transactionsRoutes);
router.use('/reports', reportsRoutes);

module.exports = router