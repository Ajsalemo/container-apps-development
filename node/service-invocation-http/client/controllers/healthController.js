import { Router } from "express";
import axios from "axios";
const router = Router();

const healthController = router.get("/", async (_, res) => {
  try {
    const { data } = await axios.get("http://localhost:8080/api/return/health");
    console.log(data);
    res.send(data);
  } catch (error) {
    console.log("An error has occurred: ", error);
  }
});

export default healthController;
