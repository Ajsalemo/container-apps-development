<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;

class SaveStateController extends Controller
{
    private $daprStateStoreName;
    private $daprBaseUrl = 'http://localhost:3500/v1.0/invoke/state/';

    public function saveState()
    {
        $this->daprStateStoreName = getenv('DAPR_STATE_STORE_NAME') ?? 'statestore';

        print($this->daprBaseUrl . $this->daprStateStoreName);

        $stateStoreValues = array('key' => 'order_1', 'value' => '250');

        $curl = curl_init();
        $optArray = array(
            CURLOPT_URL => $this->daprBaseUrl . $this->daprStateStoreName,
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_POSTFIELDS => $stateStoreValues
        );

        curl_setopt_array($curl, $optArray);
        $result = curl_exec($curl);
        print($result);
        curl_close($curl);

        return view('welcome');
    }
}
