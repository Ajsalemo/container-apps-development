import { Router } from "express";
const router = Router();

const homeController = router.get("/", (_, res) => {
  try {
    res.send("ExpressAPI");
  } catch (error) {
    console.log("An error has occurred: ", error);
  }
});

export default homeController;