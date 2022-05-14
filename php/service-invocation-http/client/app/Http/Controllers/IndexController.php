<?php

use App\Http\Controllers\Controller;

class IndexController extends Controller {
    private $daprBaseUrl = 'http://localhost:3500/v1.0/invoke';

    public function getTodoList()
    {
        $curl = curl_init();
        $optArray = array(
            CURLOPT_URL => $this->daprBaseUrl,
            CURLOPT_RETURNTRANSFER => true
        );

        curl_setopt_array($curl, $optArray);
        $result = curl_exec($curl);
        curl_close($curl);
    }
}