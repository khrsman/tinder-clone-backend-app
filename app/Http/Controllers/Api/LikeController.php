<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreLikeRequest;
use App\Models\Like;
use App\Models\People;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;

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

        Log::info('likes.store.request', ['payload' => $request->all(), 'user_id' => $userId]);

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

        Log::info('likes.store.result', ['id' => $like->id, 'user_id' => $like->user_id, 'people_id' => $like->people_id, 'status' => $like->status]);

        return response()->json($like, 201);
    }

    public function rewind(Request $request)
    {
        $userId = (int) $request->get('user_id', 0);
        if (!$userId && Auth::check()) {
            $userId = Auth::id();
        }
        if (!$userId) {
            return response()->json(['message' => 'user_id required'], 422);
        }
        Log::info('likes.rewind.request', ['payload' => $request->all(), 'raw' => $request->getContent(), 'user_id' => $userId]);

        $last = Like::query()
            ->where('user_id', $userId)
            ->orderByDesc('updated_at')
            ->orderByDesc('id')
            ->first();

        if (!$last) {
            Log::warning('likes.rewind.none', ['user_id' => $userId]);
            return response()->json(['message' => 'no actions to rewind'], 404);
        }

        $payload = [
            'user_id' => $last->user_id,
            'people_id' => $last->people_id,
            'previous_status' => $last->status,
        ];

        $last->delete();

        return response()->json(['rewind' => $payload]);
    }
}
