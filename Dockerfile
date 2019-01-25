FROM python:3.7

# Docker won’t buffer the output from your application
ENV PYTHONUNBUFFERED 1
# creates an environment variable called DEPLOY_ENV
# and sets it to the development environment
# options: [dev|qa|stag|prod]
ENV DEPLOY_ENV dev
# creates an environment variable called DOCKER_CONTAINER
# that you can use in settings.py
ENV DOCKER_CONTAINER 1

# TODO: change deployment folder /code/ to something else
COPY ./requirements.txt /code/requirements.txt
RUN pip install --upgrade pip
RUN pip install -r /code/requirements.txt

COPY . /code/
WORKDIR /code/

EXPOSE 8000