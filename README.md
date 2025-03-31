# Envision

Envision is a modern Ruby on Rails application aimed at migrating the Gerrit code review system to a contemporary tech stack. The project provides an enhanced user interface and improved functionality while maintaining compatibility with existing Gerrit data.

![Envision](https://via.placeholder.com/800x400?text=Envision+Project)

## Features

- **Modern UI**: Built with Tailwind CSS and daisyUI components
- **Hierarchical Data Model**: Portfolios > Applications > Projects
- **Theme Support**: Light/dark mode with daisyUI themes
- **Responsive Design**: Works on desktop and mobile devices
- **Migration Tools**: Tools to assist in migrating from Gerrit

## Technology Stack

- **Backend**: Ruby on Rails
- **Database**: PostgreSQL
- **Frontend**: Tailwind CSS, daisyUI, Stimulus.js
- **Authentication**: Devise (planned)
- **Authorization**: Pundit (planned)

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

4. Start the server

   ```bash
   bin/dev
   ```

5. Visit `http://localhost:3000` in your browser

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
2. **Design** (80% complete)
3. **Implementation** (45% complete)
4. **UI Development** (60% complete)
5. **Data Migration** (20% complete)
6. **Testing** (10% complete)

## Project Structure

The project follows a standard Rails application structure with the following additions:

- `docs/`: Documentation for the migration process
- `app/assets/tailwind/`: Tailwind CSS configuration
- `app/javascript/controllers/`: Stimulus controllers

## Contributing

Please see [CONTRIBUTING.md](CONTRIBUTING.md) for details on how to contribute to this project.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgements

- The Gerrit open source community
- Rails community
- Tailwind CSS and daisyUI teams
