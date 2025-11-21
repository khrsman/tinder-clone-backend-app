<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('likes', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('user_id');
            $table->unsignedBigInteger('people_id');
            $table->string('status');
            $table->timestamps();

            $table->unique(['user_id', 'people_id']);

            $table->foreign('people_id')
                ->references('id')->on('people')
                ->cascadeOnDelete();

            $table->index(['user_id', 'status']);
        });

        if (DB::connection()->getDriverName() === 'pgsql') {
            DB::statement("ALTER TABLE likes ADD CONSTRAINT likes_status_check CHECK (status IN ('like','dislike'))");
        }
    }

    public function down(): void
    {
        if (DB::connection()->getDriverName() === 'pgsql') {
            DB::statement('ALTER TABLE likes DROP CONSTRAINT IF EXISTS likes_status_check');
        }
        Schema::dropIfExists('likes');
    }
};
