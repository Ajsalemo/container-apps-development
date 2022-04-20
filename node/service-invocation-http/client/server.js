import express, { json, urlencoded } from "express";
// Controllers
import homeController from "./controllers/homeController.js";
import healthController from "./controllers/healthController.js";
const port = process.env.PORT || 3000;

const app = express();


// Other middleware
// This replaced using bodyParser which was added in express v4.16.0 and higher
// https://stackoverflow.com/questions/24330014/bodyparser-is-deprecated-express-4
app.use(json());
app.use(
  urlencoded({
    extended: true,
  })
);

// Standard controllers
app.use(homeController);
// Github API controllers
app.use("/api/health", healthController);

app.listen(port, () => console.log(`Server listening on port: ${port}`));
