Agenda: 

[/] Authentication
[/] Database
[/] Role base authentication (Admin, Guest)
[/] Simple CRUD (Create, Read, Update, Delete) 

------------------------------------------------------------------------
List of Packages
------------------------------------------------------------------------
1. Laravel Breeze (https://laravel.com/docs/8.x/starter-kits)
2. Laravel Permission (https://spatie.be/index.php/docs/laravel-permission/v5/introduction)

------------------------------------------------------------------------
Preparation
------------------------------------------------------------------------

Installation Laravel

1. Download and Install Composer (https://getcomposer.org/download/)
2. Download and Install Bash (https://git-scm.com/download/win)
3. XAMPP (Turn on Apache and MySQL)

------------------------------------------------------------------------
Installation
------------------------------------------------------------------------
Command to install laravel on windows
"composer global require "laravel/install"

// Create Laravel Project

```php
$: laravel new <folder_name>
```

Example: laravel new simpleCrud


// To run Laravel Project

```php
$: php artisan serve
```

To create Authentication install Laravel Breeze
Laravel Breeze: https://laravel.com/docs/8.x/starter-kits

```php
composer require laravel/breeze --dev
php artisan breeze:install
npm install && npm run dev
```

// To populate the database with authentication

```bash
php artisan migrate
```

*** To create role base authentication 
Laravel Permission: https://spatie.be/index.php/docs/laravel-permission/v5/introduction

```php
composer require spatie/laravel-permission
```

After installation put the "Spatie\Permission\PermissionServiceProvider::class," in "config/app" under "Package Service Providers comments"

```php
php artisan vendor:publish --provider="Spatie\Permission\PermissionServiceProvider"
php artisan optimize:clear
php artisan migrate
```
// Create Seeder for Roles

```php
php artisan make:seeder RoleSeeder
```
// Create Seeder for User

```php
php artisan make:seeder UserSeeder
```

// Assign Role to as user (code) 
code: $variable->assignRole('what role?');
example $user->assignRole('Admin');

// To reflect the seeder you created run this command

```bash
php artisan migrate:fresh --seed
```
// To Create Form with Database, Controller, Resource

m - migration/database
c - controller
r - resources (aka functions)

#: php artisan make:model Form -mcr


```bash
Tanan Code
Form::create([
            'column_name'    => $request->name,
            'column_name'    => $request->gender,
        ]);

$form->update([
            'status'    => $request->status
        ]);

$form->delete();
```
