<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;

class GetOrdersController extends Controller
{
    private $daprStateStoreName;
    private $daprBaseUrl = 'http://localhost:3500/v1.0/state/';

    public function getBulkOrders()
    {
        $this->daprStateStoreName = getenv('DAPR_STATE_STORE_NAME') ?? 'statestore';
        $daprResults = array();

        for ($i = 0; $i < 10; $i++) {
            $curl = curl_init();
            $optArray = array(
                CURLOPT_URL => $this->daprBaseUrl . $this->daprStateStoreName . '/order_' . $i,
                CURLOPT_RETURNTRANSFER => true,
                CURLOPT_HTTPHEADER => array('Content-Type:application/json')
            );

            curl_setopt_array($curl, $optArray);
            $result = curl_exec($curl);
            curl_close($curl);
        }

        array_push($daprResults, $result);
        print_r($daprResults);
        return view('index', ['result' => $daprResults]);
    }
}
