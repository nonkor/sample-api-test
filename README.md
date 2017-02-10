![last build result](https://travis-ci.org/nonkor/sample-api-test.svg?branch=master)

# Sample API test

There is a basic set of API tests developed using RSpec and httparty technologies.

## API resourses

4 API endpoints about GitHub Pull Request functionality are covered here:
- GET /repos/:owner/:repo/pulls
- GET /repos/:owner/:repo/pulls/:number
- POST /repos/:owner/:repo/pulls
- PATCH /repos/:owner/:repo/pulls/:number

## Credentials

To validate chosen functionality I manage test account _KorvinBoxText_ with associated _techlab_ project. Login, pero and token (which is stored as a array of byte-chars) could be found in [credentials.yml](credentials.yml) file.

## Run specs

To prepare specs for running, download this repo and install gems locally:
 - bundle install
Run test by command:
 - bundle exec rspec
And see result in a console.

## CI builds

Travis CI runs [builds](https://travis-ci.org/nonkor/sample-api-test) after each commits. See settings in [.travis.yml](.travis.yml)
