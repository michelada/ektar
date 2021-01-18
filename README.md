# Ektar
Rails engine for Subscriptions

## Usage
-

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'ektar'
```

And then execute:
```bash
$ bundle
```

Mount the engine in your application through routes.rb
```ruby
  mount Ektar::Engine => "/ektar"
```

## Development
Clone this repo and execute:
```bash
$ bundle
$ bundle exec lefthook add pre-commit
```

Run migrations
```bash
$ bin/rails db:create db:migrate
```

To start the dummy Rails application you will need [Overmind](https://github.com/DarthSim/overmind).
On MacOS it can be installed via Homebrew:
```bash
$ brew install overmind
```

Start the project with:
```bash
$ overmind start
```

Your Rails server will be available at http://localhost:3010

To run linters execute:
```bash
$ bundle exec lefthook run pre-commit
```

Compile assets with
```bash
  $ bin/rails app:ektar:webpacker:clean_webpack_output_folder app:ektar:webpacker:compile
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
