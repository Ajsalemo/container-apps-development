<?php

$todos = array(
    "Caulk the bathroom",
    "Go on a bike ride",
    "Fix the back door",
    "Sweep the floor",
    "Unload the dishwasher"
);

$json = json_encode($todos);

//Set the Content-Type header to application/json.
header('Content-Type: application/json');

//Output the JSON string to the browser.
echo $json;