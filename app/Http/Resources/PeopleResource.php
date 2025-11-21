<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class PeopleResource extends JsonResource
{
    public function toArray($request): array
    {
        return [
            'id' => $this->id,
            'name' => $this->name,
            'age' => $this->age,
            'bio' => $this->bio,
            'distance' => $this->location,
            'photos' => $this->whenLoaded('pictures', function () {
                return $this->pictures->sortBy('sort_order')->pluck('photo_url')->values();
            }, []),
        ];
    }
}

