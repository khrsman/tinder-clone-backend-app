<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\File;

class DumpImportSeeder extends Seeder
{
    public function run(): void
    {
        $path = base_path('database/sql/dump-tinder-clone.sql');
        if (File::exists($path)) {
            $sql = File::get($path);
            DB::statement("SET session_replication_role = 'replica'");
            preg_match_all('/INSERT INTO[\s\S]*?;/', $sql, $matches);
            foreach ($matches[0] as $stmt) {
                $table = null;
                if (preg_match('/INSERT INTO\s+([^\s]+)/i', $stmt, $m)) {
                    $table = strtolower(trim($m[1], '"'));
                }
                if ($table && !in_array($table, ['people','public.people','pictures','public.pictures','likes','public.likes'])) {
                    continue;
                }
                DB::unprepared($stmt);
            }
            DB::statement("SET session_replication_role = 'origin'");
        }
    }
}
