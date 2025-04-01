const express = require('express');
const path = require('path');
const expressLayouts = require('express-ejs-layouts');
const mySql = require('mysql');

const app = express();

module.exports = class Application {
    constructor() {
        this.configServer();
        this.configDatabase();
        this.setConfig();
        this.setRoutes();
    }

    configServer() {
        app.listen('3000', (err) => {
            if (err) console.log(err)
            console.log('server run on port 3000')
        })
    }

    configDatabase() {
        const connection = mySql.createConnection({
            host: 'services.irn1.chabokan.net',
            port: 3070,
            user: 'sakhteman994_susan',
            password: 'hb4azo6aHtcZ',
            database: 'sakhteman994_susan'
        });
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
        app.use(require('./routes'))
    }
}
