const SqlConn = require("../database");
const { doctorServices } = require("../services");
const moment = require("moment");

//+++++++++++++++++++++++Genetate time slots++++++++++++++++++++++++++++++++++++
function getTimeSlots(start, end, no_of_patients) {
  let startTime = moment(start, "HH:mm");
  let endTime = moment(end, "HH:mm");
  //   get the time diffrence
  let duration = moment.duration(endTime.diff(startTime));
  //   calculate the diff in min
  let minutes = duration.asMinutes();
  //   get the avrage time slot
  let avgMin = minutes / no_of_patients;
  //   console.log(avgMin);

  if (endTime.isBefore(startTime)) {
    endTime.add(1, "day");
  }

  let timeStops = [];

  while (startTime <= endTime) {
    timeStops.push(new moment(startTime).format("HH:mm"));
    startTime.add(avgMin, "minutes");
  }
  return timeStops;
}
//+++++++++++++++++++++++++Generae Time Slots+++++++++++++++++++++++++++++++++++

const create = (req, response) => {
  let data = req.body;
  // for now we assume that the key are the same as the databse columns

  doctorServices
    .create_doctor_avil(req.body)
    .then((result) => {
      let doctorId;
      doctorServices
        .getDoctorByID(result.insertId)
        .then((res) => {
          doctorId = res[0].doctor_id;
          let slots = getTimeSlots(data.start_time, data.end_time, data.no_of_patients);
          const doctorTimeSlots = [];
          slots.forEach((time, i) => {
            //   return if no time slots remaing
            if (slots[i + 1] == undefined) {
              return;
            }
            let dataObj = [doctorId, result.insertId, slots[i], slots[i + 1]];

            doctorTimeSlots.push(dataObj);
          });
          //   create timeslots
          doctorServices
            .create_doctor_slots(doctorTimeSlots)
            .then((res) => {
              response.send({ status: 201, message: "created successfuly" });
            })
            .catch((err) => {
              //   console.log(err);
            });
        })
        .catch((err) => {
          response.send({ status: 500, error: err.message });
        });
    })
    .catch((err) => {
      if (err.code == "ER_DUP_ENTRY") {
        response.send({ status: 502, message: "Doctor Id already exists" });
      } else {
        response.send({ status: 500, message: "an error occured..." });
      }
    });
};

const fetchSlots = (req, res) => {
  // console.log(req.params)
  let app_date = req.params.date;
  let doctor_id = req.params.doctor_id;
  let slot_id = req.params.slot_id;
  let patientscount = req.params.patientscount;

  doctorServices.getPSlotsByID(slot_id).then((data, err) => {
    if (err) {
      console.log(err);
    } else {
      if (data.length > 0) {
        res.send({ status: 200, message: "slots not available" });
      } else {
        doctorServices.fetchTimeSlots(slot_id, doctor_id, patientscount).then((data, err) => {
          if (err) {
            // console.log(err);
          } else {
            res.send({ status: 200, message: "available slots", data: data });
          }
        });
      }
    }
  });
};

module.exports = { create, fetchSlots };
