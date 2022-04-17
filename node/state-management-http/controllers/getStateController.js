const express = require("express");
const axios = require("axios").default;
const router = express.Router();
const { BASE_URL } = require("../config/config");

const getStateController = router.get("/", async (_, res, next) => {
  try {
    const getOrderArr = [];
    for (let i = 0; i < 10; i++) {
      const stateIndex = `${i}`.toString()
      const { data } = await axios.get(`${BASE_URL}/${stateIndex}`);
      console.log(data)
      getOrderArr.push(data)
    }
    res.json({ "message": getOrderArr })
  } catch (error) {
    console.log("An error has occurred: ", error);
    next(error);
  }
});

module.exports = getStateController;
