<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Form;

class DashboardController extends Controller
{
    public function index()
    {
        // Logic
        // Get all the form submitted

        // Get all data
        $forms = Form::all();

        // Select only specific column from the database
        // $forms = Form::select('name')->get();

        // Select only those form that is gender is male
        // $forms = Form::where('gender', 'male')->get();

        // Select only gender is male and status is pending
        // $forms = Form::where('gender', 'male')->get();

        // return to view
        return view('dashboard', compact('forms'));
    }
}
