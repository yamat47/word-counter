# Word Counter

A simple and elegant web-based word counter application built with Ruby on Rails. Count words, characters, and paragraphs in real-time with a clean, minimalist interface.

## Features

- **Real-time counting**: Instant word, character, and paragraph counting as you type
- **No JavaScript fallback**: Works even with JavaScript disabled (submit button appears)
- **Responsive design**: Optimized for desktop and mobile devices
- **Clean UI**: Minimalist, monochrome design for distraction-free use
- **Turbo-powered**: Uses Hotwire Turbo for seamless interactions

## Requirements

- Ruby 3.4.5 or higher
- Rails 8.0.2 or higher
- SQLite3

## Installation

1. Clone the repository:
```bash
git clone https://github.com/yamat47/word-counter.git
cd word-counter
```

2. Install dependencies:
```bash
bundle install
```

3. Setup the database:
```bash
rails db:create
rails db:migrate
```

4. Start the Rails server:
```bash
rails server
```

5. Open your browser and navigate to `http://localhost:3000`

## Development

### Running tests

```bash
# Run all tests
rails test

# Run system tests
rails test:system
```

### Code quality

```bash
# Run RuboCop for code linting
bundle exec rubocop

# Run with auto-correction
bundle exec rubocop -a
```

### Security checks

```bash
# Install security tools
gem install bundler-audit brakeman

# Run security audit
bundle-audit check --update
brakeman -q -w2
```

## CI/CD

This project uses GitHub Actions for continuous integration. The CI pipeline runs:
- Unit and system tests
- RuboCop for code style checking
- Security audits with Bundler Audit and Brakeman

## Project Structure

```
word-counter/
├── app/
│   ├── assets/           # Stylesheets and JavaScript
│   ├── controllers/      # Rails controllers
│   ├── views/           # View templates
│   └── javascript/      # Stimulus controllers
├── config/              # Application configuration
├── test/                # Test files
└── .github/workflows/   # CI configuration
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is open source and available under the [MIT License](LICENSE).

## Disclaimer

- Count results are for reference only and may vary based on language and character handling
- We are not responsible for any damages resulting from use of this tool