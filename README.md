#### Installation

The setups steps expect following tools installed on the system.

- Github
- Ruby [3.0.0]
- Rails [5.0.0]

##### 1. Check out the repository

```bash
git clone git@github.com:ngocnguyen90/short-url-api.git
```

##### 2. Create and setup the database

Run the following commands to create and setup the database.

```ruby
bundle exec rake db:create
bundle exec rake db:setup
```

##### 3. Start the Rails server

You can start the rails server using the command given below.

```ruby
bundle exec rails s
```

And now you can visit the site with the URL http://localhost:3000

#### Run the tests

    bundle exec rspec

#### REST API

The REST API to the URL shortener app is described below.

##### 1. Encodes a URL to a shortened URL

##### Request

`POST /api/v1/urls/encode`

    curl -X POST http://localhost:3000/api/v1/urls/encode -H 'Content-Type: application/json' -d '{"long_url":"http://google.com"}'

##### Response

    HTTP/1.1 200 OK
    Date: Thu, 24 Feb 2011 12:36:30 GMT
    Status: 200 OK
    Connection: close
    Content-Type: application/json
    Content-Length: 2

    {"short_url": "http://short.es/x705cp3j" }

##### 2. Decodes a shortened URL to its original URL

##### Request

`POST /api/v1/urls/decode`

    curl -X POST http://localhost:3000/api/v1/urls/decode -H 'Content-Type: application/json' -d '{"short_url":"http://short.es/g0N"}'

##### Response

    HTTP/1.1 200 OK
    Date: Thu, 24 Feb 2011 12:36:30 GMT
    Status: 200 OK
    Connection: close
    Content-Type: application/json
    Content-Length: 2

    {"long_url": "http://google.com" }
#### My Approach
My approach consist of two major parts:
- An activerecord model called Url for storing the details of the shortened link. We need to write programming logic to generate the shortened URLS that we can add to our model called Url
- A controller consist of two endpoints. one for encoding a url to a shortened url and the other is
decoding a shortened url to its original url

#### Security
- Using Rack::Attack to protect my application through customized throttling and blocking
- Using config.force_ssl = true to force all access to the app over SSL
- Using Rack::Cors to configure CORS

#### Scalability
- The shortened URL should expire after a timespan.
- The Endpoints should have api_key like a unique API key provided to each user, to protect from the spammers, access, and resource control for the user
- Shortening Algorithm to avoid duplicate data
- the difference between the URL in UTF-8 format or URL-encoded format
- Scale out our database because probably We will be storing Billions of links
- Speeding Up the Read Operation by Caching
- Load Balancing
