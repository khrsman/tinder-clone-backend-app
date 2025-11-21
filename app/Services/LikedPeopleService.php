<?php

namespace App\Services;

use App\Models\Like;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;

class LikedPeopleService
{
    public function listLiked(int $userId): LengthAwarePaginator
    {
        return Like::query()
            ->where('user_id', $userId)
            ->where('status', 'like')
            ->with(['people' => function ($q) {
                $q->with(['pictures' => function ($qq) { $qq->orderBy('sort_order'); }]);
            }])
            ->orderByDesc('updated_at')
            ->paginate(20);
    }
}

