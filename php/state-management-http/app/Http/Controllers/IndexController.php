<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;

class GetStateController extends Controller {
    private $daprStateStoreName = getenv('DAPR_STATE_STORE_NAME');
    private $daprBaseUrl = 'http://localhost:3500/v1.0/invoke/state/' . $daprStateStoreName;

    public function getState()
    {
        print($daprBaseUrl);

        $curl = curl_init();
        $optArray = array(
            CURLOPT_URL => $this->daprBaseUrl,
            CURLOPT_RETURNTRANSFER => true
        );

        curl_setopt_array($curl, $optArray);
        $result = curl_exec($curl); 
        curl_close($curl);
        
        return view('welcome')
    }
}