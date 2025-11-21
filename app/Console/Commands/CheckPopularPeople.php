<?php

namespace App\Console\Commands;

use App\Models\Like;
use App\Models\People;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\Mail;

class CheckPopularPeople extends Command
{
    // use a disposable email to avoid spam
    protected $signature = 'popular:check {--threshold=50} {--notify=khrsman@yopmail.com}';
    protected $description = 'Send email if any person liked count exceeds threshold';

    public function handle(): int
    {
        $threshold = (int) $this->option('threshold');
        $notify = (string) $this->option('notify');

        $popularIds = Like::query()
            ->selectRaw('people_id, COUNT(*) as cnt')
            ->where('status', 'like')
            ->groupBy('people_id')
            ->havingRaw('COUNT(*) >= ?', [$threshold])
            ->pluck('people_id');

        if ($popularIds->isEmpty()) {
            $this->info('No popular people above threshold');
            return Command::SUCCESS;
        }

        $people = People::query()->whereIn('id', $popularIds)->get();
        $lines = $people->map(function ($p) {
            return sprintf('#%d %s (age %d)', $p->id, $p->name, $p->age);
        })->implode("\n");

        Mail::raw("Popular people reached threshold:\n\n".$lines, function ($message) use ($notify) {
            $message->to($notify)->subject('Popular People Alert');
        });

        $this->info('Notification email sent to '.$notify);
        return Command::SUCCESS;
    }
}
