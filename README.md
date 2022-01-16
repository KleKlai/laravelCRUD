Agenda: 

[/] Authentication
[/] Database
[/] Role base authentication (Admin, Guest)
[/] Simple CRUD (Create, Read, Update, Delete) 

------------------------------------------------------------------------
# List of Packages

1. Laravel Breeze (https://laravel.com/docs/8.x/starter-kits)
2. Laravel Permission (https://spatie.be/index.php/docs/laravel-permission/v5/introduction)

------------------------------------------------------------------------
# Preparation

### Installation Laravel

1. Download and Install Composer (https://getcomposer.org/download/)
2. Download and Install Bash (https://git-scm.com/download/win)
3. XAMPP (Turn on Apache and MySQL)
4. Git Terminal (https://github.com/git-for-windows/git/releases/download/v2.34.1.windows.1/Git-2.34.1-64-bit.exe)

------------------------------------------------------------------------
# Installation

Command to install laravel on windows

```bash
composer global require laravel/installer
```

### To create Laravel Project

Open git terminal and input the following commands
Example: 

```php
laravel new <folder_name>

// Example
laravel new simpleCRUD
```

Open newly created laravel app

```bash
cd <folder_name>
code .
```

### To run Laravel Project

```bash
php artisan serve
```
-------------------------------------------
# Automatic Installion of Breeze and Roles

To automate installation of laravel breeze and permission run the script config.sh

## Where can i find config.sh? 

You can download config.sh (https://github.com/KleKlai/laravelCRUD/blob/main/config.sh)

## Instruction to run the script
1. Copy the downloaded config.sh to your laravel folder
2. Open your laravel folder inside visual studio code
3. Open terminal in visual studio code
4. Make sure to choose git terminal
5. Finally execute the code below to begin.

```bash
bash config.sh
```
The script will give you instruction what to do next just follow.

-------------------------------------------
# Manual Installation of Packages

## Package to be Installed
1. Laravel Breeze - For basic login logout with functions
2. Laravel Permission - For role base authentication

### To create basic authentication install Laravel Breeze
Documentation: https://laravel.com/docs/8.x/starter-kits

```bash
composer require laravel/breeze --dev

php artisan breeze:install

npm install && npm run dev

php artisan migrate
```

### To create role base authentication 
Documentation: https://spatie.be/index.php/docs/laravel-permission/v5/introduction

```php
composer require spatie/laravel-permission
```

After installation put the "Spatie\Permission\PermissionServiceProvider::class," in "config/app" under "Package Service Providers comments"

```bash
php artisan vendor:publish --provider="Spatie\Permission\PermissionServiceProvider"
php artisan optimize:clear
php artisan migrate
```
### Create Seeder for Roles

```php
php artisan make:seeder RoleSeeder
```
### Create Seeder for User

```php
php artisan make:seeder UserSeeder
```

### Assign Role to as user (code) 

```php
$variable->assignRole('what role?');

// Example
$user->assignRole('Admin');
```


### To reflect the seeder you created run this command

```bash
php artisan migrate:fresh --seed
```
### To Create Form with Database, Controller, Resource

m - migration/database
c - controller
r - resources (aka functions)

```bash
php artisan make:model Form -mcr
```

```php
// Tanan Code

// Create entry
Form::create([
            'column_name'    => $request->name,
            'column_name'    => $request->gender,
        ]);

// Update specific form
$form->update([
            'status'    => $request->status
        ]);

// Delete specific form
$form->delete();
```
