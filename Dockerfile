# We first need to tell Docker what is the language of the image
FROM python:3.7-alpine
LABEL maintainer="Quentin Mennecart"

# Recommended when using python with docker
ENV PYTHONUNBUFFERED 1

# copy from ... to ...
COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache postgresql-client
RUN apk add --update --no-cache --virtual .tmp-build-deps \
	gcc libc-dev linux-headers postgresql-dev
RUN pip install -r /requirements.txt
RUN apk del .tmp-build-deps

RUN mkdir /app
WORKDIR /app
COPY ./app /app

# This is for security issues. It avoid using root user to run the app and uses a new user instead.
RUN adduser -D user
USER user