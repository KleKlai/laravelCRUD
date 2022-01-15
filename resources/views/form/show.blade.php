<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Application Form') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 bg-white border-b border-gray-200">


                    <x-auth-validation-errors class="mb-4" :errors="$errors" />

                    <form method="POST" action="{{ route('form-update', $form) }}">
                        @csrf

                        <!-- Name -->
                        <div>
                            <x-label for="email" :value="__('Name')" />

                            <x-input id="text" class="block mt-1 w-full" type="text" name="name" :value="$form->name" readonly autofocus />
                        </div>

                        <!-- Gender -->
                        <div class="mt-4">
                            <x-label for="email" :value="__('Gender')" />

                            <x-input id="text" class="block mt-1 w-full" type="text" name="gender" :value="$form->gender" autofocus />
                        </div>

                        <div class="mt-4">
                            <x-label for="email" :value="__('Status')" />

                            <select name="status">
                                <option value="accepted" {{ ($form->status == 'accepted') ? 'selected' : '' ; }}>Accepted</option>
                                <option value="declined" {{ ($form->status == 'declined') ? 'selected' : '' ; }}>Declined</option>
                                <option value="pending" {{ ($form->status == 'pending') ? 'selected' : '' ; }}>Pending</option>
                            </select>
                        </div>

                        <div class="flex items-center justify-end mt-4">

                            <a class="underline text-sm text-gray-600 hover:text-gray-900" href="{{ route('form-delete', $form) }}">
                                {{ __('Delete') }}
                            </a>

                            <x-button class="ml-3">
                                {{ __('Submit') }}
                            </x-button>
                        </div>
                    </form>

                </div>
            </div>
        </div>
    </div>
</x-app-layout>
