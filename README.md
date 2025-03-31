# Envision

Envision is a modern Ruby on Rails application aimed at migrating the Gerrit code review system to a contemporary tech stack. The project provides an enhanced user interface and improved functionality while maintaining compatibility with existing Gerrit data.

![Envision](https://via.placeholder.com/800x400?text=Envision+Project)

## Features

- **Modern UI**: Built with Tailwind CSS and daisyUI components for a clean, responsive interface
- **User Authentication**: Complete authentication system with login, registration, and password reset
- **Team Management**: Create and manage teams with different user roles (admin, member, viewer)
- **Hierarchical Data Model**: Portfolios > Applications > Projects
- **Theme Support**: Light/dark mode with daisyUI themes
- **Responsive Design**: Works seamlessly on desktop and mobile devices
- **Migration Tools**: Tools to assist in migrating from Gerrit

## Technology Stack

- **Backend**: Ruby on Rails
- **Database**: PostgreSQL
- **Frontend**: Tailwind CSS, daisyUI, Stimulus.js
- **Authentication**: Devise (implemented)
- **Authorization**: Role-based via TeamMembership model

## Getting Started

### Prerequisites

- Ruby 3.2.0 or higher
- Rails 8.0.0 or higher
- PostgreSQL 13 or higher
- Node.js 16 or higher
- Yarn

### Installation

1. Clone the repository

   ```bash
   git clone https://github.com/castingclouds/envision.git
   cd envision
   ```

2. Install dependencies

   ```bash
   bundle install
   yarn install
   ```

3. Setup the database

   ```bash
   rails db:create db:migrate db:seed
   ```

   This will create sample users and teams for testing:

   - Admin user: `admin@example.com` (password: `password`)
   - Regular user: `john@example.com` (password: `password`)
   - And several other users with different team roles

4. Start the server

   ```bash
   bin/dev
   ```

5. Visit `http://localhost:3000` in your browser

## Implemented Features

### Authentication System

A complete authentication system has been implemented using Devise with the following features:

- **User Registration**: New users can create accounts with email, username, and password
- **Login**: Secure authentication with email/password
- **Password Reset**: Users can request password reset via email
- **Remember Me**: Option to stay logged in across sessions
- **User Profiles**: Basic user profile information

### Team Management

A comprehensive team management system allows users to:

- **Create Teams**: Any user can create a new team
- **Team Roles**: Three permission levels (admin, member, viewer)
- **Team Membership**: Users can be invited to join teams
- **Team Dashboard**: View team members and their roles
- **Leave/Join Teams**: Users can leave teams or accept invitations

### User Interface

The UI has been built with a focus on usability and aesthetics:

- **Responsive Design**: Works on all device sizes
- **DaisyUI Components**: Modern, accessible UI components
- **Consistent Styling**: Uniform design language across all pages
- **Flash Messages**: User feedback for actions
- **Navigation**: Intuitive navbar with authentication-aware options

## Development

### Running Tests

```bash
rails test
```

### Code Quality

```bash
rubocop
```

## Migration Strategy

The migration from Gerrit to Envision follows these phases:

1. **Analysis** (100% complete)
2. **Design** (90% complete)
3. **Implementation** (65% complete)
   - Authentication system ✓
   - Team management ✓
   - User interface foundations ✓
   - Hierarchical data model (in progress)
4. **UI Development** (70% complete)
   - Authentication forms ✓
   - Team management interfaces ✓
   - Landing page ✓
   - Project interfaces (in progress)
5. **Data Migration** (20% complete)
6. **Testing** (15% complete)

## Project Structure

The project follows a standard Rails application structure with the following additions:

- `docs/`: Documentation for the migration process
- `app/assets/tailwind/`: Tailwind CSS configuration
- `app/javascript/controllers/`: Stimulus controllers
- `app/models/`: Core models including User, Team, and TeamMembership
- `app/controllers/`: Controllers for teams, team memberships, and home
- `app/views/devise/`: Customized authentication views
- `app/views/teams/`: Team management views
- `app/views/shared/`: Shared components like navbar
- `db/seeds.rb`: Sample data generation

## Future Plans

The following features are planned for upcoming development:

1. **Hierarchical Data Model Implementation**:
   - Complete the Portfolio, Application, and Project models
   - Create interfaces for managing these entities
   - Implement relationships between teams and projects

2. **Code Review Functionality**:
   - Implement core code review features
   - Support for commenting on code
   - Review approval workflows

3. **Gerrit Data Migration**:
   - Tools for importing existing Gerrit data
   - Compatibility layer for existing integrations
   - Data validation and verification

4. **Advanced Features**:
   - CI/CD integration
   - Automated code quality checks
   - Performance metrics and dashboards

## Contributing

Please see [CONTRIBUTING.md](CONTRIBUTING.md) for details on how to contribute to this project.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgements

- The Gerrit open source community
- Rails community
- Tailwind CSS and daisyUI teams
