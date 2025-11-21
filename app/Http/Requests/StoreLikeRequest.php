<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StoreLikeRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'people_id' => ['required', 'integer', 'exists:people,id'],
            'status' => ['required', 'string', 'in:like,dislike'],
        ];
    }
}

