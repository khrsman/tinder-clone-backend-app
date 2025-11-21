<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreLikeRequest;
use App\Models\Like;
use App\Models\People;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class LikeController extends Controller
{
    public function index(Request $request)
    {
        $userId = (int) $request->get('user_id');
        $query = Like::query()->with('people');
        if ($userId) {
            $query->where('user_id', $userId);
        }
        if ($request->filled('status')) {
            $query->where('status', $request->get('status'));
        }
        return response()->json($query->paginate(20));
    }

    public function store(StoreLikeRequest $request)
    {
        $data = $request->validated();
        $userId = (int) $request->get('user_id', 0);
        if (!$userId && Auth::check()) {
            $userId = Auth::id();
        }
        if (!$userId) {
            return response()->json(['message' => 'user_id required'], 422);
        }

        $data['user_id'] = $userId;
        $like = Like::firstOrCreate([
            'user_id' => $data['user_id'],
            'people_id' => $data['people_id'],
        ], [
            'status' => $data['status'],
        ]);

        if ($like->wasRecentlyCreated === false) {
            $like->update(['status' => $data['status']]);
        }

        return response()->json($like, 201);
    }
}
