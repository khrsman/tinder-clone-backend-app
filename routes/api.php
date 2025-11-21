<?php
use Illuminate\Support\Facades\Route;

use App\Http\Controllers\Api\PeopleController;
use App\Http\Controllers\Api\PictureController;
use App\Http\Controllers\Api\LikeController;

Route::prefix('people')->group(function () {
    Route::get('/', [PeopleController::class, 'index']);
    Route::post('/', [PeopleController::class, 'store']);
    Route::get('{people}', [PeopleController::class, 'show']);
    Route::put('{people}', [PeopleController::class, 'update']);
    Route::delete('{people}', [PeopleController::class, 'destroy']);

    Route::get('{people}/pictures', [PictureController::class, 'index']);
    Route::post('{people}/pictures', [PictureController::class, 'store']);
    Route::delete('{people}/pictures/{picture}', [PictureController::class, 'destroy']);
});

Route::prefix('likes')->group(function () {
    Route::get('/', [LikeController::class, 'index']);
    Route::post('/', [LikeController::class, 'store']);
    Route::post('/rewind', [LikeController::class, 'rewind']);
});
