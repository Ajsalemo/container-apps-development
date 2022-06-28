<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;

class GetOrdersController extends Controller {
    private $daprStateStoreName;
    private $daprBaseUrl = 'http://localhost:3500/v1.0/state/';

    public function getBulkOrders()
    {
        $this->daprStateStoreName = getenv('DAPR_STATE_STORE_NAME') ?? 'statestore';
        $daprKeyArr = array();

        for ($i = 0; $i < 10; $i++) { 
            array_push($daprKeyArr, $i);
        }

        $curl = curl_init();
        $optArray = array(
            CURLOPT_URL => $this->daprBaseUrl . $this->daprStateStoreName . '/bulk',
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_POSTFIELDS => $daprKeyArr
        );

        curl_setopt_array($curl, $optArray);
        $result = curl_exec($curl); 
        echo($result);
        curl_close($curl);
        
        return view('index', ['result' => $result]);
    }
}


