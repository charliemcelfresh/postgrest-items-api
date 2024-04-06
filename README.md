### postgres-items-api

This project is part of a performance test among [Postgrest](https://postgrest.org/en/v12/), Sinatra (Ruby), Ruby on Rails, and Go. Here are the Go, Rails and Sinatra projects:

- https://github.com/charliemcelfresh/go-items-api
- https://github.com/charliemcelfresh/rails-items-api
- https://github.com/charliemcelfresh/sinatra-items-api

The above projects have MySQL as their backends; the current project of course has PostgreSQL as its backend.

Once all four are set up, you can compare their performance by running the Go project's performance testing client, see [go-items-api](https://github.com/charliemcelfresh/go-items-api) for details.

#### Install

This project uses [dbmate](https://github.com/amacneil/dbmate) to create all the PostgreSQL resources you'll need for this project. dbmate expects .env to have a DATABASE_URL defined

* Copy .env.SAMPLE to .env, and paste your Postgres database URI into it. dbmate references DATABASE_URL in .env to perform migrations
* Copy postgrest.conf.SAMPLE to postgrest.conf, and paste your database URI into it. Postgrest uses this file
