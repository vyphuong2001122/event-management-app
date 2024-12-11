const { disconnect } = require('process');
const connection = require('./mysql')

connection.query('SELECT * FROM users', function(error, results, fields) {
    if (error)
        throw error;
    results.forEach(result => {
        console.log(result);
    });
});

const app = require('express')();
const server = require('http').createServer(app);
const options = { /* ... */ };
const io = require('socket.io')(server, options);
const port = 3604;
io.on('connection', client => {
    console.log('connected');
    client.on('disconnect', () => console.log('Client disconnected'))
});

server.listen(port, () => {
    console.log(`Example app listening at http://localhost:${port}`)
})

/*const express = require('express')
const app = express()
const port = 3000

app.get('/', (req, res) => {
    res.send('Hello World các bạn hiền ahihi')
})

app.listen(port, () => {
    console.log(`Example app listening at http://localhost:${port}`)
})*/