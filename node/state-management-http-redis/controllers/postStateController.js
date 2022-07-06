const express = require("express");
const router = express.Router();
const axios = require("axios").default;
const { BASE_URL } = require("../config/config");

const postStateController = router.get("/", async (_, res, next) => {
  console.log(BASE_URL);
  try {
    const postOrderArr = [];
    for (let i = 1; i < 10; i++) {
      const state = [{
        key: `${i}`.toString(),
        value: `takeout order ${i}`,
      }];

      postOrderArr.push(state);
      await axios.post(`${BASE_URL}`, state);
    }

    res.json({ message: postOrderArr });
  } catch (error) {
    console.log("An error has occurred: ", error);
    next(error);
  }
});

module.exports = postStateController;
