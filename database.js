const mysql = require("mysql");

const dbname = "doctor";
const con = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "",
  database: dbname,
});

con.connect(function (err, connection) {
  if (err) throw err;
  console.log("Connected to the databse " + dbname);
});

module.exports = con;
