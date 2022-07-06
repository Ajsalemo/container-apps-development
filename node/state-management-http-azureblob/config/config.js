const DAPR_HOST = process.env.DAPR_HOST || "http://localhost";
const DAPR_HTTP_PORT = process.env.DAPR_HTTP_PORT || "3500";
const DAPR_STATE_STORE = "statestore";
const DAPR_COMPONENT_URI = "v1.0/state";

const BASE_URL = `${DAPR_HOST}:${DAPR_HTTP_PORT}/${DAPR_COMPONENT_URI}/${DAPR_STATE_STORE}`;

module.exports = {
    BASE_URL: BASE_URL
};
