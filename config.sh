#!/bin/bash

red=`tput setaf 1`
reset=`tput sgr0`
printf "========================================================================================="
printf "\n"
printf "${red}Before you proceed. Please make sure your database credentials has been added to .env and database is turn on.${reset}"
printf "\n"
printf "=========================================================================================\n"

read -p "Did you already add? [y|n]?" CONT
if [ "$CONT" = "y" ]; then

    echo "Preparing"

    echo -ne '#####                     (33%)\r'
    sleep 1
    echo -ne '#############             (66%)\r'
    sleep 1
    echo -ne '#######################   (100%)\r'
    echo -ne '\n'

    echo "Installing Breeze"
    composer require laravel/breeze --dev

    echo "Deploying Breeze Kit"

    php artisan breeze:install
    sleep 3
    npm install && npm run dev

    echo "Installing Roles & Permission"
    composer require spatie/laravel-permission

    echo "Deploying Roles & Permission"

    php artisan vendor:publish --provider="Spatie\Permission\PermissionServiceProvider"
    php artisan optimize:clear
    php artisan migrate

    sed -i '10 i use Spatie\\Permission\\Traits\\HasRoles;' app/Models/User.php
    sed -i '14 i use HasRoles;' app/Models/User.php
    sed -i '47 i \\t$role = "Guest"; ' app/Models/User.php app/Http/Controllers/Auth/RegisteredUserController.php
    sed -i '48 i \\t$user->assignRole($role);' app/Models/User.php app/Http/Controllers/Auth/RegisteredUserController.php
    sed -i "12 i @role('Admin')I am a Admin! @else I am a Guest...@endrole" resources/views/dashboard.blade.php
    
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

    php artisan migrate:fresh --seed

    printf "${green}User seeder completed successfully.${reset}"
    printf "\n"
    printf "========================================================================================="
    printf "\n"
    printf "${green}Default admin account  email: $email password: $password ${reset}"
    printf "\n"
    printf "=========================================================================================\n"

  read -p "Do you want to deploy locally the system? [y|n]?" CONT
  if [ "$CONT" = "y" ]; then
    php artisan serve
  else
    echo "Project is now development ready..."
    echo "======== Happy Coding... ========"
  fi
else
  echo "Kindly add your database credentials in env file."
fi


