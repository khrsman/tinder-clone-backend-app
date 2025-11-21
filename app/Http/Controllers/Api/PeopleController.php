<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\People;
use App\Http\Resources\PeopleResource;
use Illuminate\Http\Request;

class PeopleController extends Controller
{
    public function index(Request $request)
    {
        $query = People::query()->with(['pictures' => function ($q) {
            $q->orderBy('sort_order');
        }]);

        if ($request->filled('min_age')) {
            $query->where('age', '>=', (int) $request->get('min_age'));
        }
        if ($request->filled('max_age')) {
            $query->where('age', '<=', (int) $request->get('max_age'));
        }
        if ($request->filled('max_distance')) {
            $query->where('location', '<=', (int) $request->get('max_distance'));
        }

        $perPage = (int) $request->get('per_page', 20);
        $perPage = $perPage > 0 && $perPage <= 100 ? $perPage : 20;
        $paginator = $query->paginate($perPage);
        $paginator->getCollection()->transform(fn ($item) => new PeopleResource($item));
        return response()->json($paginator);
    }

    // removed unused store/show/update/destroy methods
}
