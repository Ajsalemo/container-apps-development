<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\SaveOrdersController;
use App\Http\Controllers\GetOrdersController;
use App\Http\Controllers\DeleteOrdersController;

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

Route::get('/', [GetOrdersController::class, 'getBulkOrders']);
Route::get('/api/save/orders', [SaveOrdersController::class, 'saveOrders'])->name('saveOrders');
Route::get('/api/delete/orders', [DeleteOrdersController::class, 'deleteOrders'])->name('deleteOrders');
Route::get('/api/get/orders/bulk', [GetOrdersController::class, 'getBulkOrders'])->name('getBulkOrders');


