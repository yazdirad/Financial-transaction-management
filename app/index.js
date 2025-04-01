const express = require('express');
const path = require('path');
const expressLayouts = require('express-ejs-layouts');

const app = express();

module.exports = class Application {
    constructor() {
        this.configServer();
        this.setConfig();
        this.setRoutes();
    }

    configServer() {
        app.listen('3000', (err) => {
            if (err) console.log(err)
            console.log('server run on port 8000')
        })
    }

    setConfig() {
        app.use(express.static(__dirname + '/public'))
        app.set('view engine', 'ejs');
        app.set('views', path.join(__dirname, 'resource/views'));
        app.use(expressLayouts);
        app.set('layout', 'master');
        app.set('layout extractScripts', true);
        app.set('layout extractStyles', true);
    }

    setRoutes() {
        app.get('/', (req, res) => {
            res.render('index')
        });

        app.get('/add', (req, res) => {
            res.render('add')
        });

        app.get('/list', (req, res) => {
            res.render('list')
        });

        app.get('/report', (req, res) => {
            res.render('report')
        });
    }
}
