## Auberge (API-only)
[![standard-readme compliant](https://img.shields.io/badge/readme%20style-standard-brightgreen.svg?style=flat-square)](https://github.com/RichardLitt/standard-readme) [![calver](https://img.shields.io/badge/calver-YY.MINOR.MICRO-22bfda.svg?style=flat-square)](http://calver.org)

> Auberge [oh-**bair**-zhiz; *French* oh-**berzh**] is a hotel management and booking system.

## Table of Contents

- [What is Auberge?](#What is Auberge?)
- [Status](#Status)
- [Install](#install)
- [Deployment](#Deployment)
- [FAQ](../master/FAQ.md)
- [Contributing](#contributing)
- [License](#license)

## What is Auberge?
*TODO*: Why did I make this project?

## Technology Stack
Written in [Elixir](http://elixir-lang.org/)
Keeping state with [PostgreSQL](http://postgresql.org/)
Some other shoutouts from my mix.exs:
- Maru - Grape-like API framework
- Corsica - Because... CORS
- Credo - Code Review/Analysis
- Distillery - Helps to ship it!
- ESpec - BDD Testing (once I make the tests)

## Status
Auberge is currently in development and not yet ready for proper release. Everything is subject to change without notice.

What endpoints work? Customers, Properties, RoomRates, RoomTypes

## Install
```bash
$ brew install elixir
$ git clone git@github.com:combsco/auberge.git
$ cd auberge
$ mix deps.get
$ mix ecto.setup

# console
$ iex -S mix

# run it
$ mix run
```

*TODO*: Write up release upgrade/downgrade

## Deployment
*TODO*: Write up deployment via Docker

*TODO*: Write up deployment via Heroku/Dokku

## Contributing

Feel free to dive in! [Open an issue](https://github.com/combsco/auberge/issues/new) or submit PRs.

Auberge follows the [Contributor Covenant](http://contributor-covenant.org/version/1/3/0/) Code of Conduct.

## License
Apache 2.0 © 2017 Christopher Combs

See LICENSE file for full text.
