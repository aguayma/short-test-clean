# Intial Setup

    docker-compose build
    docker-compose run short-app rails db:setup && rails db:migrate

# To run the specs

    docker-compose -f docker-compose-test.yml run short-app-rspec

# To run migrations

    docker-compose run short-app rails db:migrate
    docker-compose -f docker-compose-test.yml run short-app-rspec rails db:test:prepare

# Run the web server

    docker-compose up

# Adding a URL

    curl -X POST -d "full_url=https://google.com" http://localhost:3000/short_urls.json

# Getting the top 100

    curl localhost:3000

# Checking your short URL redirect

    curl -I localhost:3000/abc


# Base62 Logic Shortest URL Logic

    I noticed that in the ShortUrl model that there was an array with 62 characters so
    I used base62 to factor in a unique short code. For the uniqueness I used the
    ShortUrl object.id, which would allow me to create unique codes that are not being used.

    However, this doesn't account for the possibility of there being deleted records.
    If I had more time, I would of wanted to create a separe function that used ShortUrl.count
    and taking into account the first object being created, then going through and ensuring that
    the created short_code does not already exist in the db. 
