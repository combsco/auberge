## Auberge (API-only)
[![standard-readme compliant](https://img.shields.io/badge/readme%20style-standard-brightgreen.svg?style=flat-square)](https://github.com/RichardLitt/standard-readme) [![calver](https://img.shields.io/badge/calver-YY.MINOR.MICRO-22bfda.svg?style=flat-square)](http://calver.org)

> Auberge [oh-**bair**-zhiz; *French* oh-**berzh**] is a hotel management and booking system.

## Table of Contents

- [What is Auberge?](#What is Auberge?)
- [Status](#Status)
- [Install](#install)
- [Deployment](#Deployment)
- [FAQ](../FAQ.md)
- [Contributing](#contributing)
- [License](#license)

## What is Auberge?
*TODO*: Why did I make this project?

## Technology Stack
Written in [Elixir](http://elixir-lang.org/) and keeping state with [PostgreSQL](http://postgresql.org/).

Some other shoutouts from my mix.exs file:

- [Maru](https://github.com/elixir-maru/maru) - A API micro-framework inspired by grape
- [Corsica](https://github.com/whatyouhide/corsica) - Because... CORS
- [Credo](http://credo-ci.org/) - Static code analysis
- [Distillery](https://github.com/bitwalker/distillery) - Helps to ship it!
- [ESpec](https://github.com/antonmi/espec) - BDD testing framework (once I make the tests)

## Status
Auberge is currently in development and not yet ready for proper release. Everything is subject to change without notice.

What endpoints work as of the last PR? Customers, Properties, RoomRates, RoomTypes

## Install (developer)
```bash
$ brew install elixir # Only if you have Homebrew installed.
$ git clone git@github.com:combsco/auberge.git
$ cd auberge
$ mix deps.get   # Get any missing dependencies
$ mix ecto.setup # This will create, migrate and seed the database

# console
$ iex -S mix

# run it
$ mix run

# If you want to start fresh with no seed data
$ mix ecto.reset
```

For releases there will just be a binary or docker file you can run no extra setup like above.
*TODO*: Write up release upgrade/downgrade

## Deployment
*TODO*: Write up deployment via Docker

*TODO*: Write up deployment via Heroku/Dokku

## Todo
- Reservations - Create/Maintain Reservations
- Inventory - Search and find what availability you have.
- Folios - All financial line items of a reservation are held
- Invoices - Once a folio is finalized it turns into a invoice?
- Users - People who can access the system. (front desk, management, etc)

## Contributing
1. Fork it!
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a new Pull Request


Found a bug, questions, discussion, or etc! [Open an issue](https://github.com/combsco/auberge/issues/new) or submit PRs.

Auberge follows the [Contributor Covenant](http://contributor-covenant.org/version/1/3/0/) Code of Conduct.

## License
Apache 2.0 © 2017 Christopher Combs

See LICENSE file for full text.
