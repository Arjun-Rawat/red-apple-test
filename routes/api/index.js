const express = require("express");
const doctorRoutes = require("./doctor.route");

const router = express.Router();

const devRoutes = [
  // routes available only in development mode
  {
    path: "/doctor",
    route: doctorRoutes,
  },
];

devRoutes.forEach((route) => {
  router.use(route.path, route.route);
});

module.exports = router;
