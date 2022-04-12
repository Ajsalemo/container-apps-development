const express = require("express");
const axios = require("axios").default;
const router = express.Router();

const getStateController = router.get("/", async (_, res, next) => {
  try {
    const getOrderArr = [];
    for (i = 0; i < 10; i++) {
      const { res } = await axios.get(`${DAPR_HOST}:${DAPR_HTTP_PORT}/v1.0/state/${DAPR_STATE_STORE}/${i}`);
      console.log(res)
      getOrderArr.push(res)
    }
    res.json({ "message": postOrderArr })
  } catch (error) {
    console.log("An error has occurred: ", error);
    next(error);
  }
});

module.exports = getStateController;
