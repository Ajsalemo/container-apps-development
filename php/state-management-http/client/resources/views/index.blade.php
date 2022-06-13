@extends('layouts.main')

@section('content')
<div class="mt-8 bg-white dark:bg-gray-800 overflow-hidden shadow sm:rounded-lg">
    <div class="grid">
        <div class="p-6 border-t border-gray-200 dark:border-gray-700">
            <h2>TEST</h2>
            <span>{{ $result }}</span>
        </div>
    </div>
</div>
@endsection