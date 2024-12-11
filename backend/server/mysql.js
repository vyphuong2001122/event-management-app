const mysql = require('mysql');

const connection = mysql.createConnection({
    host: 'localhost',
    database: 'users',
    user: 'root', // username of the mysql connection 
    password: '' // password of the mysql connection
});
connection.connect(function(err) {
    if (err) {
        console.log('Error connecting' + err.stack);
        return;
    } else {
        console.log('Connected as id' + connection.threadId);
    }
});

module.exports = connection;