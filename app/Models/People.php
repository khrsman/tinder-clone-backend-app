<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class People extends Model
{
    use HasFactory;

    protected $table = 'people';

    protected $fillable = [
        'name',
        'age',
        'location',
    ];

    public function pictures()
    {
        return $this->hasMany(Picture::class, 'people_id');
    }

    public function likes()
    {
        return $this->hasMany(Like::class, 'people_id');
    }
}
