# README

## Overview

- Rails version: 7
- Ruby version: 3.1.2
- node version: 14.21.2


## Setup

- Install `rbenv` reference: `https://github.com/rbenv/rbenv`
- Install `3.1.2 ruby` through `rbenv`
- Install `mysql` through `brew`
- Install `bundler`
- Run `bundle install`
- Install `nvm` reference: `https://github.com/nvm-sh/nvm`
- Install `v14.21.2 node` or higher through `nvm`
- Install `yarn`
- Run `yarn install`
- Run `bundle exec rake db:setup` to run migration and seed
- Run `rails s` or `bin/dev`
- Open browser `localhost:3000`


## Test

- Run `bundle exec rspec spec`
