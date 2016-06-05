## Local Setup

create a file named .env at the root of this directory & update key value pairs as .env.example


## To Run
```sh
$ gem install bundler
$ bundle install
$ ruby ./bin/run.rb
```

## To bebug or to access local db

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
