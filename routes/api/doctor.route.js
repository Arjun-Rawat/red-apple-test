const express = require("express");
const router = express.Router();

const { doctorController } = require("../../controllers/index");

// router.get("", (req, res) => {
//   res.send("hellow ro");
// });
router.get("/:date/:doctor_id/:slot_id/:patientscount", doctorController.fetchSlots);
router.post("/", doctorController.create);

module.exports = router;
