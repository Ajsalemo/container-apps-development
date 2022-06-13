<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;

class SaveStateController extends Controller
{
    private $daprStateStoreName;
    private $daprBaseUrl = 'http://localhost:3500/v1.0/state/';

    public function saveState()
    {
        $this->daprStateStoreName = getenv('DAPR_STATE_STORE_NAME') ?? 'statestore';
        $stateStoreValues = array(array('key' => 'order_1', 'value' => '250'));

        $curl = curl_init();
        $optArray = array(
            CURLOPT_URL => $this->daprBaseUrl . $this->daprStateStoreName,
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_POSTFIELDS => json_encode($stateStoreValues)
        );

        curl_setopt_array($curl, $optArray);
        $result = curl_exec($curl);
        print($result);
        curl_close($curl);

        return view('savestate');
    }
}

