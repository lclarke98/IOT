const mysql = require('mysql');
const pool = mysql.createPool({
    connectionLimit : 1,
    socketPath: '/cloudsql/iot-cw:europe-west2:iot',
    user: 'root',
    password: 'root',
    database: 'climateSensor'
});
exports.handler = function handler(req, res) {
    const data = JSON.parse(Buffer.from(req.data, 'base64').toString());
   try{
    pool.query("INSERT INTO data(humidity, tempC) VALUES (?,?)", [data.humidity, data.temperature])
   }catch(error){
       console.log(error)
   }
};