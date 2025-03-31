# Contributing to Envision

Thank you for considering contributing to Envision! This document outlines the process for contributing to the project and how to report issues.

## Code of Conduct

By participating in this project, you agree to abide by our Code of Conduct. Please be respectful and considerate of others when contributing.

## How to Contribute

### Reporting Bugs

If you find a bug in the application, please create an issue in the project repository with the following information:

1. A clear, descriptive title
2. Steps to reproduce the bug
3. Expected behavior
4. Actual behavior
5. Screenshots (if applicable)
6. Environment details (OS, browser, etc.)

### Suggesting Enhancements

We welcome suggestions for enhancements! Please create an issue with:

1. A clear, descriptive title
2. A detailed description of the proposed enhancement
3. Any relevant mockups or examples
4. Why this enhancement would be beneficial

### Pull Requests

We actively welcome pull requests:

1. Fork the repository
2. Create a new branch from `main`
3. Make your changes
4. Run tests and ensure they pass
5. Submit a pull request

#### Pull Request Guidelines

- Follow the coding style of the project
- Include tests for new features or bug fixes
- Update documentation as needed
- Keep pull requests focused on a single concern
- Write clear, descriptive commit messages

## Development Process

### Setting Up Your Development Environment

1. Clone the repository

   ```bash
   git clone https://github.com/yourusername/envision.git
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

4. Start the development server

   ```bash
   bin/dev
   ```

### Running Tests

Before submitting a pull request, make sure all tests pass:

```bash
rails test
```

### Code Style

We use RuboCop for Ruby code style. Run the following to check your code:

```bash
rubocop
```

## Branching Strategy

- `main` - Production-ready code
- `develop` - Development branch where features are integrated
- Feature branches - Named as `feature/your-feature-name`
- Bug fix branches - Named as `fix/bug-description`

## Release Process

1. Features are merged into `develop`
2. When ready for release, `develop` is merged into `main`
3. A new version tag is created
4. Release notes are generated

## Documentation

If you're adding new features, please update the relevant documentation:

- Update the README.md if necessary
- Add or update API documentation
- Update wiki pages if applicable

## Questions?

If you have any questions about contributing, feel free to open an issue for clarification.

Thank you for contributing to Envision!
