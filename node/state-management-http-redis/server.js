const express = require("express");
const app = express();
const port = process.env.PORT || 3000;

// Controllers
const homeController = require("./controllers/homeController");
const catchAllController = require("./controllers/catchAllController");
const postStateController = require("./controllers/postStateController");
const getStateController = require("./controllers/getStateController");

app.use(express.json());
app.use(
  express.urlencoded({
    extended: true,
  })
);

app.use(homeController);
app.use("/api/post/order", postStateController);
app.use("/api/get/order", getStateController);
app.use(catchAllController);

app.listen(port, () => console.log(`Server listening on: ${port}`));
