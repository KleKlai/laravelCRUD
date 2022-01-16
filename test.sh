#!/bin/bash

# Ask user default username and password
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

printf "========================================================================================="
printf "\n"
printf "${red}Create default administrator account.${reset}"
printf "\n"
printf "=========================================================================================\n"

echo "Enter Email:"
read email
echo "Enter Password:"
read password

if [ -e database/seeders/DatabaseSeeder.php ]; then
    rm database/seeders/DatabaseSeeder.php
else
    echo "File does not exist"
fi

if [ -e database/seeders/RoleSeeder.php ]; then
    rm database/seeders/RoleSeeder.php
else
    echo "File does not exist"
fi

if [ -e database/seeders/UserSeeder.php ]; then
    rm database/seeders/UserSeeder.php
else
    echo "File does not exist"
fi
printf "${green}Debris remove successfully.${reset}"

echo -e "<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    public function run()
    {
        \$this->call([
            RoleSeeder::class,
            UserSeeder::class
        ]);
    }
}" >> database/seeders/DatabaseSeeder.php

echo -e "<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\User;
use Spatie\Permission\Models\Role;
use Spatie\Permission\Models\Permission;

class RoleSeeder extends Seeder
{
    public function run()
    {
        Role::create(['name' => 'Admin']);
        Role::create(['name' => 'Guest']);
    }
}
" >> database/seeders/RoleSeeder.php

printf "\n"
printf "${green}Role seeder completed successfully.${reset}"
printf "\n"

php artisan migrate:fresh
php artisan db:seed RoleSeeder

echo -e "<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\User;
use Illuminate\Support\Facades\Hash;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        \$admin = User::create([
            'name' => 'Admin Account',
            'email' => '$email',
            'password' => Hash::make('$password'),
        ]);

        \$admin->assignRole('admin');
    }
}" >> database/seeders/UserSeeder.php

printf "${green}User seeder completed successfully.${reset}"
printf "\n"
printf "========================================================================================="
printf "\n"
printf "${green}Default admin account  email: $email password: $password ${reset}"
printf "\n"
printf "=========================================================================================\n"
