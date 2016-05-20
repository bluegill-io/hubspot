## Local Setup

create a file named .env at the root of this directory && insert:

```sh
API_KEY= { your api key }
DEAL_URL=https://api.hubapi.com/deals/v1/deal/recent/modified?
CONTACT_URL=https://api.hubapi.com/contacts/v1/lists/all/contacts/all?
OWNER_URL=https://api.hubapi.com/owners/v2/owners/?
COMPANY_URL=https://api.hubapi.com/companies/v2/companies/recent/modified?
ENGAGEMENT_URL=https://api.hubapi.com/engagements/v1/engagements/recent/modified?

```

## To Run
```sh
$ gem install bundler
$ bundle install
$ rake db:create && rake db:migrate && rake db:seed
$ ./bin/run
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
