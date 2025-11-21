<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StorePictureRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'photo_url' => ['required', 'string'],
            'sort_order' => ['nullable', 'integer', 'min:1'],
        ];
    }
}
