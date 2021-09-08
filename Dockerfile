# We first need to tell Docker what is the language of the image
FROM python:3.7-alpine
LABEL maintainer="Quentin Mennecart"

# Recommended when using python with docker
ENV PYTHONUNBUFFERED 1

# copy from ... to ...
COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache postgresql-client jpeg-dev
RUN apk add --update --no-cache --virtual .tmp-build-deps \
	gcc libc-dev linux-headers postgresql-dev musl-dev zlib zlib-dev
RUN pip install -r /requirements.txt
RUN apk del .tmp-build-deps

RUN mkdir /app
WORKDIR /app
COPY ./app /app

RUN mkdir -p /vol/web/media
RUN mkdir -p /vol/web/static
# This is for security issues. It avoid using root user to run the app and uses a new user instead.
RUN adduser -D user
# Give the server access to the volumetric folder
RUN chown -R user:user /vol/
# The owner can do everything with the folder, the rest can read and execute from the directory
RUN chmod -R 755 /vol/web
USER user