const express = require("express");
const router = express.Router();
const axios = require("axios");
const { BASE_URL } = require("../config/config")

const postStateController = router.get("/", async (_, res, next) => {
  console.log(BASE_URL)
  try {
    const postOrderArr = [];
    for (i = 0; i < 10; i++) {
      const state = [
        {
          key: i,
          value: `takeout order ${i}`,
        },
      ];
      postOrderArr.push(state);
      const { res } = await axios.post(`${BASE_URL}`, state);
      console.log(res)
    }
    res.json({ "message": postOrderArr })
  } catch (error) {
    console.log("An error has occurred: ", error);
    next(error);
  }
});

module.exports = postStateController;
