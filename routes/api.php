<?php
use Illuminate\Support\Facades\Route;

use App\Http\Controllers\Api\PeopleController;
use App\Http\Controllers\Api\LikeController;

Route::prefix('people')->group(function () {
    Route::get('/', [PeopleController::class, 'index']);
});

Route::prefix('likes')->group(function () {
    Route::get('/', [LikeController::class, 'index']);
    Route::post('/', [LikeController::class, 'store']);
    Route::post('/rewind', [LikeController::class, 'rewind']);
});
