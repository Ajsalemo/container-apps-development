<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;

class GetStateController extends Controller {
    private $daprStateStoreName;
    private $daprBaseUrl = 'http://localhost:3500/v1.0/state/';

    public function getState()
    {
        $this->daprStateStoreName = getenv('DAPR_STATE_STORE_NAME') ?? 'statestore';
        echo($this->daprBaseUrl . $this->daprStateStoreName . '/order_1');
        $curl = curl_init();
        $optArray = array(
            CURLOPT_URL => $this->daprBaseUrl . $this->daprStateStoreName . '/order_1',
            CURLOPT_RETURNTRANSFER => true
        );

        curl_setopt_array($curl, $optArray);
        $result = curl_exec($curl); 
        echo($result);
        curl_close($curl);
        
        return view('index', ['result' => $result]);
    }
}


