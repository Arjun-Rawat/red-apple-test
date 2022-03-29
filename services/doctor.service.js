const SqlConn = require("../database");

const create_doctor_avil = (data) => {
  return new Promise(function (resolve, reject) {
    let sql = `INSERT INTO doctor_availabilities (doctor_id, start_time, end_time, no_of_patients) VALUES ('${data.doctor_id}', '${data.start_time}', '${data.end_time}', '${data.no_of_patients}')`;
    SqlConn.query(sql, (err, result) => {
      if (err) {
        return reject(err);
      } else {
        resolve(result);
      }
    });
  });
};

const create_doctor_slots = (data) => {
  return new Promise(function (resolve, reject) {
    var sql = "INSERT INTO doctor_time_slots (doctor_id, doctor_availability_id, slot_start_time, slot_end_time) VALUES ?";
    SqlConn.query(sql, [data], (err, result) => {
      if (err) {
        return reject(err);
      } else {
        resolve(result);
      }
    });
  });
};

const getDoctorByID = (id) => {
  return new Promise(function (resolve, reject) {
    let sql = "select doctor_id  from doctor_availabilities  where id  =" + id;
    SqlConn.query(sql, (err, result) => {
      if (err) {
        return reject(err);
      } else {
        resolve(JSON.parse(JSON.stringify(result)));
      }
    });
  });
};

const getPSlotsByID = (id) => {
  return new Promise(function (resolve, reject) {
    let sql = "select *  from patient_booking_slots  where doctor_time_slot_id  =" + id;
    SqlConn.query(sql, (err, result) => {
      if (err) {
        return reject(err);
      } else {
        resolve(JSON.parse(JSON.stringify(result)));
      }
    });
  });
};

const fetchTimeSlots = (slot_id, doctor_id, limit) => {
  return new Promise(function (resolve, reject) {
    let sql = "select *  from doctor_time_slots  where id  >= " + slot_id + " AND doctor_id = " + doctor_id + " limit " + limit;
    SqlConn.query(sql, (err, result) => {
      if (err) {
        return reject(err);
      } else {
        resolve(JSON.parse(JSON.stringify(result)));
      }
    });
  });
};

module.exports = { create_doctor_avil, create_doctor_slots, getDoctorByID, getPSlotsByID, fetchTimeSlots };
