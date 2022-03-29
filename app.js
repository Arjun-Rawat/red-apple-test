const express = require("express");
const bodyParser = require("body-parser");
const app = express();
const port = 3000;
const routes = require("./routes/api");
require("./database");

app.use(bodyParser.json());
app.use(
  bodyParser.urlencoded({
    extended: true,
  })
);

app.use("/api", routes);

// app.get("/", (request, response) => {
//   response.json({ info: "Node.js, Express, and Postgres API" });
// });

app.listen(port, () => {
  console.log(`App running on port ${port}.`);
});
