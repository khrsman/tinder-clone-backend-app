<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\StorePictureRequest;
use App\Models\Picture;
use App\Models\People;

class PictureController extends Controller
{
    public function index(People $people)
    {
        $pictures = $people->pictures()->orderBy('sort_order')->get();
        return response()->json($pictures);
    }

    public function store(StorePictureRequest $request, People $people)
    {
        $data = $request->validated();
        $data['people_id'] = $people->id;
        $picture = Picture::create($data);
        return response()->json($picture, 201);
    }

    public function destroy(People $people, Picture $picture)
    {
        if ($picture->people_id !== $people->id) {
            return response()->json(['message' => 'Not found'], 404);
        }
        $picture->delete();
        return response()->json(null, 204);
    }
}
