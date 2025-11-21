<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StorePeopleRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'name' => ['required', 'string', 'max:255'],
            'age' => ['required', 'integer', 'min:18', 'max:120'],
            'location' => ['required', 'integer', 'min:0'],
            'bio' => ['nullable', 'string'],
        ];
    }
}
