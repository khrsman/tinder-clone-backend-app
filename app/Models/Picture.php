<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Picture extends Model
{
    use HasFactory;

    protected $table = 'pictures';

    protected $fillable = [
        'people_id',
        'photo_url',
        'sort_order',
    ];

    public function people()
    {
        return $this->belongsTo(People::class, 'people_id');
    }
}
