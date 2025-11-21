<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Resources\PeopleResource;
use App\Services\LikedPeopleService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class LikedPeopleController extends Controller
{
    public function __construct(private LikedPeopleService $service)
    {
    }

    public function index(Request $request)
    {
        $userId = (int) $request->get('user_id', 0);
        if (!$userId && Auth::check()) {
            $userId = Auth::id();
        }
        if (!$userId) {
            return response()->json(['message' => 'user_id required'], 422);
        }

        $paginator = $this->service->listLiked($userId);
        $collection = $paginator->getCollection()->map(function ($like) {
            return new PeopleResource($like->people);
        });
        $paginator->setCollection($collection);
        return response()->json($paginator);
    }
}

