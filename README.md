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

## App overview

- Once `rails server` is up and running and app was loaded on the browser, you can navigate to home page where in you can assign a product for route destination by picking which product to route and hit assign route, this will automatically evaluate based from criteria for those destinations defined in the app and it will automatically assign the product to the correct route which will display on the Routed products table.
- You can manage products as well under `Products` menu you can.
- You can manage destinations as well under `Destinations` menu.
- To assign and view routed products this will be displayed on the home page, you can only assign route for those products that wasnt assigned only.