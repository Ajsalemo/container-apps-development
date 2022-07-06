const express = require("express");
const router = express.Router();

const homeController = router.get("/", (_, res, error) => {
  try {
    res.send("state-management-http-redis");
  } catch (err) {
    console.log("An error has occurred: ", err);
    next(error);
  }
});

module.exports = homeController;