<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;

class DeleteOrdersController extends Controller
{
    private $daprStateStoreName;
    private $daprBaseUrl = 'http://localhost:3500/v1.0/state/';

    public function deleteOrders()
    {
        $this->daprStateStoreName = getenv('DAPR_STATE_STORE_NAME') ?? 'statestore';
        $headers = array(
            "Accept: application/json",
        );

        for ($i =  0; $i < 10; $i++) {
            $curl = curl_init();
            $stateStoreValues = 'order_' . $i;

            $optArray = array(
                CURLOPT_URL => $this->daprBaseUrl . $this->daprStateStoreName . '/' . $stateStoreValues,
                CURLOPT_CUSTOMREQUEST => "DELETE",
                CURLOPT_HTTPHEADER => $headers
            );

            curl_setopt_array($curl, $optArray);
            $result = curl_exec($curl);
            print($result);
            curl_close($curl);
        }
        # Delete orders and redirect back to root
        return redirect('/');
    }
}
