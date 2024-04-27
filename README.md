# WEATHER OR NOT

## GETTING STARTED
Perform the following steps from a shell/terminal:
1. Navigate to the parent folder you want this project to live in.
1. Clone the project and _cd_ into it by running `git clone git@github.com:RoseAndres/weather_or_not.git && cd weather_or_not`
1. Run `bundle` to install all dependencies from the gemfile.

## EXTERNAL DEPENDENCIES
* [redis](https://redis.io) is used for caching:
  * The easiest way to get started with this is to install is via [homebrew](https://brew.sh/), using the following command: `brew install redis`

## CONFIG
* Set the environment variable `REDIS_URL` to the url of your redis store (`redis://localhost:6379/0` by default, if you installed via Homebrew and are running it locally)

## CREDENTIALS
Request the `master.key` file from another team member to enable your instance of the app's encrypted credentials. You will not be able to use them without that file.

NOTE: once you have obtained this file **DO NOT COMMIT IT**. This will compromise the encrypted credentials.

## RUNNING THE PROJECT
Perform the following steps:
1. Start redis server with `redis-server` (again, assuming you installed with Homebrew locally) in its own shell window/tab.
1. Start your rails server with `bin/rails c` in its own shell window/tab.
1. Navigate to `localhost:3000` in a web browser
1. Start forecasting!
