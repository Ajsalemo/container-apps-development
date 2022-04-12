const express = require("express");
const router = express.Router();
const axios = require("axios").default;
const { BASE_URL } = require("../config/config");

const postStateController = router.get("/", async (_, res, next) => {
  console.log(BASE_URL);
  try {
    // const postOrderArr = [];
    // for (i = 1; i < 10; i++) {
    //   const state = {
    //     key: i,
    //     value: `takeout order ${i}`,
    //   };

    //   postOrderArr.push(state);
    // }
    const state = [{
      key: "1",
      value: "takeout order: 1",
    }]

    const { response: data } = await axios.post(`${BASE_URL}`, state);
    console.log(data);
    res.json({ message: data });
  } catch (error) {
    console.log("An error has occurred: ", error);
    next(error);
  }
});

module.exports = postStateController;
