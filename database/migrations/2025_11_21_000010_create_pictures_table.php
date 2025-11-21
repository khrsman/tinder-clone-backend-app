<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('pictures', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('people_id');
            $table->text('photo_url');
            $table->integer('sort_order')->default(1);
            $table->timestamps();

            $table->foreign('people_id')
                ->references('id')->on('people')
                ->cascadeOnDelete();

            $table->index(['people_id', 'sort_order']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('pictures');
    }
};
