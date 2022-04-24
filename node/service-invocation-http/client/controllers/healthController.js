import { Router } from "express";
import axios from "axios";
const router = Router();

const healthController = router.get("/", async (_, res) => {
  const daprBaseUrl = process.env.DAPR_BASE_URL || 'http://localhost:3500/v1.0/invoke'
  const daprAppIdCallee = process.env.DAPR_APP_ID_CALLEE || 'server'
  try {
    const { data } = await axios.get(`${daprBaseUrl}/${daprAppIdCallee}/method/api/return/health`);
    res.send(data);
  } catch (error) {
    console.log("An error has occurred: ", error);
  }
});

export default healthController;
