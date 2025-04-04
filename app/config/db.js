const mysql = require('mysql2/promise');

const pool = mysql.createPool({
    host: 'services.irn1.chabokan.net',
    port: 3070,
    user: 'sakhteman994_susan',
    password: 'hb4azo6aHtcZ',
    database: 'sakhteman994_susan',
    waitForConnections: true,
    connectionLimit: 10, // تعداد کانکشن‌های همزمان
    queueLimit: 0
});

module.exports = pool;