<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;

class SaveOrdersController extends Controller
{
    private $daprStateStoreName;
    private $daprBaseUrl = 'http://localhost:3500/v1.0/state/';

    public function saveOrders()
    {
        $this->daprStateStoreName = getenv('DAPR_STATE_STORE_NAME') ?? 'statestore';

        for ($i =  0; $i < 10; $i++) {
            $curl = curl_init();
            $stateStoreValues = array(array('key' => 'order_' . $i, 'value' => 'new_order_' . $i));

            $optArray = array(
                CURLOPT_URL => $this->daprBaseUrl . $this->daprStateStoreName,
                CURLOPT_RETURNTRANSFER => true,
                CURLOPT_POSTFIELDS => json_encode($stateStoreValues)
            );

            curl_setopt_array($curl, $optArray);
            $result = curl_exec($curl);
            print($result);
            curl_close($curl);
        }
        # Save orders and redirect back to root
        return redirect('/');
    }
}
