# WEATHER OR NOT

Ruby Version: 3.1.3  
Rails Version: 7.1.3

## GETTING STARTED
Perform the following steps from a shell/terminal:
1. Navigate to the parent folder you want this project to live in.
1. Clone the project and _cd_ into it by running `git clone git@github.com:RoseAndres/weather_or_not.git && cd weather_or_not`
1. Run `bundle` to install all dependencies from the gemfile.

## EXTERNAL DEPENDENCIES
* [redis](https://redis.io) is used for caching:
  * The easiest way to get started with this is to install is via [homebrew](https://brew.sh/), using the following command: `brew install redis`

## CONFIG
* Rename the `example.env` file in the root directory to `.env`.
* Change the value of `REDIS_URL` to the url of your redis store (`redis://localhost:6379/0` by default, if you installed via Homebrew and are running it locally)

## CREDENTIALS
Request the `master.key` file from another team member and place it into the `config` directory to enable your instance of the app to use the encrypted credentials. You will not be able to use them without that file.

NOTE: once you have obtained this file **DO NOT COMMIT IT**. This will compromise the encrypted credentials.

## RUNNING THE PROJECT
Perform the following steps:
1. Start redis server with `redis-server` (again, assuming you installed with Homebrew locally) in its own shell window/tab.
1. Start your rails server with `bin/rails s` in its own shell window/tab.
1. Navigate to `localhost:3000` in a web browser
1. Start forecasting!

## TESTING
This app is tested using the [Minitest](https://github.com/minitest/minitest) framework that came installed by default. 

It also makes use of [VCR](https://github.com/vcr/vcr) to store responses from external APIs, to prevent unnecessary usage, and filters any sensitive data out of the stored responses.
You can find the cassette files in [test/cassettes](test/cassettes).

[SimpleCov](https://github.com/simplecov-ruby/simplecov) is also used to generate a summary of code coverage after tests are run. You will see a readout of the code coverage at the end of the console output when running the tests, and can also view it in a pretty GUI by opening `coverage/index.html` in a browser _(note that the `coverage` directory is not tracked and will only be generated once you have run the test suite at least once)_.

 ### RUNNING TESTS
 Executing `bin/rails test` from the console will run the test suite and generate an up-to-date coverage summary.
