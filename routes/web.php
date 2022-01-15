<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\FormController;
use App\Http\Controllers\DashboardController;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

Route::middleware(['auth'])->group(function () {

    Route::get('/dashboard', [DashboardController::class, 'index'])->name('dashboard');

    // Create a Route(link) for application form
    Route::get('/form', [FormController::class, 'create'])->name('form');

    // Create a Route for application form data processing
    // From view to controller
    Route::post('/form-submit', [FormController::class, 'store'])->name('form-submit');

    // Route for viewing of application form DATA
    Route::get('/form-show/{form}', [FormController::class, 'show'])->name('form-show');

        // Route for updating the application form status
        Route::post('/form-update/{form}', [FormController::class, 'update'])->name('form-update');

        // Route for deleted the application form
        Route::get('/form-delete/{form}', [FormController::class, 'destroy'])->name('form-delete');

});


require __DIR__.'/auth.php';
