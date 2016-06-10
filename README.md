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
