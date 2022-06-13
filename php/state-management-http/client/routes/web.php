<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\SaveStateController;
use App\Http\Controllers\GetStateController;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', [GetStateController::class, 'getState']);
Route::get('/api/state/save', [SaveStateController::class, 'saveState']);
