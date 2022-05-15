<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;

class IndexController extends Controller {
    private $daprBaseUrl = 'http://localhost:3500/v1.0/invoke';
    private $localBaseUrl = 'http://localhost:8080';

    public function getTodoList()
    {
        $curl = curl_init();
        $optArray = array(
            CURLOPT_URL => $this->localBaseUrl,
            CURLOPT_RETURNTRANSFER => true
        );

        curl_setopt_array($curl, $optArray);
        $result = curl_exec($curl); 
        curl_close($curl);
        
        return view('welcome')->with('result', json_decode($result));
    }
}