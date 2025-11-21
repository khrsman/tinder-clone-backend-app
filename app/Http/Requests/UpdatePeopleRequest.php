<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class UpdatePeopleRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'name' => ['sometimes', 'string', 'max:255'],
            'age' => ['sometimes', 'integer', 'min:18', 'max:120'],
            'location' => ['sometimes', 'integer', 'min:0'],
            'bio' => ['sometimes', 'nullable', 'string'],
        ];
    }
}
