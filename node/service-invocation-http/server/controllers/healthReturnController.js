import { Router } from "express";
const router = Router();

const healthController = router.get("/", (_, res) => {
  try {
    res.send("Health - OK");
  } catch (error) {
    console.log("An error has occurred: ", error);
  }
});

export default healthController;