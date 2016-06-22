[![Code Climate](https://codeclimate.com/github/dvmonroe/hubspot/badges/gpa.svg)](https://codeclimate.com/github/dvmonroe/hubspot)
[![Build Status](https://travis-ci.org/dvmonroe/hubspot.svg?branch=master)](https://travis-ci.org/dvmonroe/hubspot)

## Run Locally
```sh
$ bin/setup
$ bin/run
# if you get a permission denied error on either cmd run chmod +x  bin/setup || chmod +x bin/run
```

## To bebug or to access local data

loading in irb:
```sh
$ irb
2.3.1 :001 > load 'config.rb'
2.3.1 :002 > Contact.find(1201).engagements
2.3.1 :003 > Engagement.find(81320089).contacts
```

To see all possible rake commands
```sh
$ rake -T
```

# Design Notes

## Database
You'll notice we've overridden the `id` on multiple tables.  This is so that we don't get the auto generated incremenetal `id` that you'd get with a sql db. We want the `id` of the table record to be that of the hubspot record `id`.  If for some reason we don't get an `id` from hubspot for the record we don't want it to save with an auto generated `id`.

So that `id` can still be our primary key we ensured that null is false and added a unique index to the `id` column.

## Deployment
You'll need to add a `deploy` dir to `config/` and add a `production.rb` file in that dir.  You'll need to add at the very least the server for which you're deploying to (See capistrano docs for examples).

## Future Improvements
1. Add specs
2. Add more of our records to excel workbook 
3. Update run time to allow for passable options of what records we want
4. Consider not dropping entire db on run and instead inserting or updating new or existing records
5. Run a server to display/visualize records via web client
