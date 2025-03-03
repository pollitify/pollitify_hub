
# Rails 8 Authentication with Bootstrap 5 and Devise Gem

This is a simple Rails 8 application that implements authentication using the popular `devise` gem along with Bootstrap 5 for styling. This project provides an easy-to-use authentication system with features like user registration, login, logout, and password management.

## Features

- User authentication (sign up, login, logout).
- Password reset and change.
- Bootstrap 5 integration for responsive and modern UI.
- User management with Devise's built-in methods.
- Customizable views and controllers for authentication.
- Allow Super Admin to manage users and restrict access for regular users.
- Simple filter users using javascript controller.

## Prerequisites

Before you begin, ensure you have the following installed on your system:

- Ruby (version 3.0 or higher)
- Rails 8.x
- Node.js and Yarn
- PostgreSQL or SQLite (depending on your preference)

## Installation

Follow the steps below to set up the project locally:

1. **Clone the repository:**

   ```bash
   git clone https://github.com/dangkhoa2016/Rails-8-Authentication.git
   cd Rails-8-Authentication
   ```

2. **Install dependencies:**

   Ensure you have the necessary gems installed by running:

   ```bash
   bundle install
   ```

3. **Install JavaScript dependencies:**

   Install Bootstrap 5 and other JavaScript packages using Yarn:

   ```bash
   yarn install
   ```

4. **Set up the database:**

   Create and migrate the database:

   ```bash
   rails db:create
   rails db:migrate
   ```

   Additionally, you can seed the database with sample data:

   ```bash
    rails db:seed
    ```

    also, I have created a fake users at `db/seed/fake_users.rb` file, you can load it by running this command in rails console:

    ```bash
    rails c
    load 'db/seed/fake_users.rb'
    ```

5. **Configure Devise:**

   To set up Devise for user authentication, run:

   ```bash
   rails generate devise:install
   ```

   Generate the user model with Devise:

   ```bash
   rails generate devise User
   ```

   More details on Devise configuration can be found in the [Devise documentation](https://github.com/heartcombo/devise).

6. **Add Bootstrap 5 to your application:**

   Bootstrap 5 is included via the `yarn` package manager. You can use the default setup provided in `application.bootstrap.scss` and `application.js` files. Bootstrap is linked by default in this setup.

7. **Add some ENV variables:**

   You can add some ENV variables to your `.env` file, using the [.env.sample](.env.sample) file as a template, you can copy it to `.env` file and modify it as you need


8. **Run the Rails server:**

   Start the Rails development server:

   ```bash
   rails server
   ```

   Build css file:

   ```bash
    yarn build:css
    ```

    Check at [Procfile.dev](Procfile.dev) file for more information about how to run both rails and css build at the same time.

9. **Access the application:**

   Open your browser and navigate to `http://localhost:3000`. You should see the application with Bootstrap 5 styling and authentication features.

10. **Some debug and learn:**
    Please check at [manual](manual) folder for more information.

## Usage

- **Sign Up:** Create a new user account (at `http://localhost:3000/users/sign_up`), you need to check rails log to get the confirmation email link for development environment testing.
- **Login:** Log in with your registered credentials (at `http://localhost:3000/users/sign_in`).
- **Logout:** Log out from the application (at `http://localhost:3000/users/sign_out`).
- **Password Reset:** Reset your password if you forget it (at `http://localhost:3000/users/password/new`).

## Configuration

You can customize the Devise authentication system by modifying the following files:

- `config/initializers/devise.rb` — Devise configuration settings.
- `app/views/devise/` — Custom views for Devise (e.g., login, registration).
- `app/controllers/application_controller.rb` — Modify any application-wide behavior.

## Contributing

Feel free to fork this repository and submit pull requests. You can also report issues or suggest improvements in the Issues section.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
