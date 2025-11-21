<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Like extends Model
{
    use HasFactory;

    protected $table = 'likes';

    protected $fillable = [
        'user_id',
        'people_id',
        'status',
    ];

    public function people()
    {
        return $this->belongsTo(People::class, 'people_id');
    }
}
