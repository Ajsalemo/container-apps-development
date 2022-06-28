@extends('layouts.main')

@section('content')
<div class="mt-8 bg-white dark:bg-gray-800 overflow-hidden shadow sm:rounded-lg">
    <div class="grid text-center">
        <div class="p-6 border-t border-gray-200 dark:border-gray-700">
            <h2 class="text-white">Current orders</h2>
            {{-- @if (!$result || count($result) < 0)
                <a href="{{ route('saveOrders') }}">Click to push orders</a>
            @else
                <span>{{ $result }}</span>
            @endif --}}
            <span>{{ $result }}</span>
            <div class="flex flex-column">
                <a href="{{ route('getBulkOrders') }}">Click to get all orders</a>
                <a href="{{ route('saveOrders') }}">Click to push orders</a>
                <a href="{{ route('deleteOrders') }}">Click to delete all orders</a>
            </div>
        </div>
    </div>
</div>
@endsection
