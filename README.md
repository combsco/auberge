## Auberge (API-only)
[![standard-readme compliant](https://img.shields.io/badge/readme%20style-standard-brightgreen.svg?style=flat-square)](https://github.com/RichardLitt/standard-readme)

> Auberge is a hotel management and booking system.

## Table of Contents

- [Background](#background)
- [Install](#install)
- [FAQ](#FAQ)
- [License](#license)

## Background
*TODO*: Why did I make this project?

## Install
*TODO*: Write up deployment via Docker

*TODO*: Write up deployment via Heroku/Dokku

*TODO*: Write up release upgrade/downgrade

## FAQ
#### Do you work in the Hospitality industry or even a hotel?
I do not. So if you see something out of place or if you have insight to give please open an issue, love to hear from you.

#### Where's the front-end?
It's not developed yet. However, feel free to create your own.

#### Will this API have documentation on it's endpoints?
Yes, but still pondering on which spec to use. (RAML, Blueprint, Swagger)

#### Why is the API and the front-end of the Auberge split?
Enforces separation of concerns, abstracts complexity and allows flexibility overall. Enables you to use our front-end, bring your own front-end, desktop application, mobile application and other adapters. Gives the ability to scale the API to better infrastructure without disrupting other components. However, this all comes with some cons: Independent testing, build and deployment, and needing to know different technologies/languages to contribute.

#### Will a new API/front-end version or vice-versa break the system?
Short answer, no. Medium answer, maybe. The API will be backwards compatible, meaning if a new version is released, and deployed. Your front-end won't come to grinding halt and stop working. However, if you try to use API resources that are not yet implemented in the version you are running then you may run into some trouble.

#### How will you keep the Auberge API and front-end in sync?
*Thought process, since front-end doesn't exist yet*

If the customer has upgraded the front-end and api to current versions but a user is using the old version of the front-end (because CDN/browser caches). Everything will continue to work and function as normal because it's still hitting backwards compatible resources.

If the customer has upgraded the front-end and decides to not upgrade the backend. The front-end will notify the customer that certain features are disabled/flagged because the API backend needs to be version x.x.x

If the customer has upgraded the API and decides to not upgrade the backend. The only trouble you'll run into is if something was marked as non-backwards compatible.

#### How would you deploy Auberge API and front-end?
I would put the front-end on a CDN, set it and forget it. Since it will be a SPA the user only needs to download/load it once and it will be cached until a new version is released.

I would deploy the API to a server either bare bone or with docker.

#### Why not use Phoenix?
Short answer, cause I don't want to. I understand that frameworks such as Phoenix, Ruby on Rails, Django and others, fit so many use cases that we all might as well harness the power and use them. My problem with this is many developers use these frameworks without even having knowledge of the language itself. So Auberge is a learning expedition for me to get better acquainted with Elixir/Erlang and other technologies without a handicap.

## Contribute

Feel free to dive in! [Open an issue](https://github.com/combsco/auberge/issues/new) or submit PRs.

Auberge follows the [Contributor Covenant](http://contributor-covenant.org/version/1/3/0/) Code of Conduct.

## License
BSD-3-Clause © 2017 Christopher Combs

See LICENSE file for full text.
