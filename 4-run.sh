#!/bin/sh

docker build -t my-dev-app -f 4-dev-app.dockerfile broken-app

docker run --rm -p 3000:3000 my-dev-app
