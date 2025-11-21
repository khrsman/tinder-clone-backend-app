<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\StorePeopleRequest;
use App\Http\Requests\UpdatePeopleRequest;
use App\Models\People;
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

        return response()->json($query->paginate(20));
    }

    public function store(StorePeopleRequest $request)
    {
        $people = People::create($request->validated());
        return response()->json($people, 201);
    }

    public function show(People $people)
    {
        $people->load(['pictures' => function ($q) {
            $q->orderBy('sort_order');
        }]);
        return response()->json($people);
    }

    public function update(UpdatePeopleRequest $request, People $people)
    {
        $people->update($request->validated());
        return response()->json($people);
    }

    public function destroy(People $people)
    {
        $people->delete();
        return response()->json(null, 204);
    }
}
