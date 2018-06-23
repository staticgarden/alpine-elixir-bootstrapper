# Alpine Elixir Bootstrapper

There are many ways to Deploy an Elixir application. This docker image is specifically
built for the following setup:

  1. Docker applications are built using [distillery](https://github.com/bitwalker/distillery) which builds releases.
  2. They are deployed on Amazon ECS using docker containers. (You should be able to get it working on other container platforms too)
  3. Releases are built using [bitwalker/alpine-elixir](https://hub.docker.com/r/bitwalker/alpine-elixir/) and pushed to an S3 bucket.
  4. Your applications are started using the `bootstrap.sh` script which downloads the release, unzips it and runs it

## Environment variables

  1. `APP_NAME`: The name of your application which is defined in distillery.
  2. `S3_BUCKET`: The S3 bucket where your releases are stored.
  3. `RELEASE_TAR`: The full path of your release tar e.g. `emailer/emailer-prod-0.1.6+ref-gbdfa6a9.tar.gz`

## Deployment Flow
  1. Build a distillery release inside a `bitwalker/alpine-elixir` image e.g. `rel/builds/emailer-prod-0.1.6+ref-gbdfa6a9.tar.gz`
  2. Copy it to S3: `aws s3 cp "rel/builds/emailer-prod-0.1.6+ref-gbdfa6a9.tar.gz" "s3://deployments/emailer/"`
  3. Register a task definition with the updated `RELEASE_TAR`. TODO
  4. Update your service to use this new task definition.
