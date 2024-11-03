var express = require ('express');

var app = express();
const config = {
    host: 'db',
    user: 'root',
    password: 'root',
    database: 'nodedb',
    port: 3306,
}
const mysql = require('mysql')
const connection = mysql.createConnection(config)

app.get('/', function (req, res) {
    const sql = `INSERT INTO people(name) values('William')`
    connection.query(sql)
    connection.query('SELECT name FROM people', function (error, results, fields) {
        var mensagem = '<h1>Full Cycle Rocks!!</h1><br/> - Lista de nomes cadastrada no banco de dados<br/><ul>';
        results.forEach(element => {
            mensagem += '<li>' + element.name+"</li>";
        });
        mensagem+="</ul>";
        res.send(mensagem);
    })
});

app.listen(8080, function() {
    console.log('Example app listening on port 8080!');
}); 