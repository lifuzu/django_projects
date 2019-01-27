FROM python:3.7

# TODO: consider VERSION for projects later

# creates an argument variable called DEPLOY_ENV
# set it to the development environment by default
# options: [dev|qa|stag|prod]
ARG DEPLOY_ENV=dev
ARG DEPLOY_USER=deploy
ARG DOMAIN_NAME=rili.local.com

ENV DEPLOY_ENV ${DEPLOY_ENV:-dev}
ENV DEPLOY_USER ${DEPLOY_USER:-deploy}

# Docker won’t buffer the output from your application
ENV PYTHONUNBUFFERED 1

# creates an environment variable called DOCKER_CONTAINER
# that you might use in settings.py for Docker container deployment situation
ENV DOCKER_CONTAINER 1

ENV DEPLOY_HOME /kubase/${DEPLOY_USER}/sites/${DOMAIN_NAME}

RUN apt-get update && apt-get install -y --no-install-recommends sudo

RUN useradd -m ${DEPLOY_USER} && echo "${DEPLOY_USER}:docker" | chpasswd && adduser ${DEPLOY_USER} sudo

COPY . ${DEPLOY_HOME}

RUN pip install --upgrade pip
RUN pip install -r ${DEPLOY_HOME}/requirements.txt

WORKDIR ${DEPLOY_HOME}

EXPOSE 8000

# Install supervisor
RUN apt-get update && apt-get install -y --no-install-recommends supervisor
RUN mkdir -p /var/log/supervisor && chown ${DEPLOY_USER} /var/log/supervisor
# Setting up projects in supervisor
COPY tools/templates/supervisord.template.conf /etc/supervisor/conf.d/supervisord.conf
RUN sed -i "s/DOMAIN/${DOMAIN_NAME}/g"      /etc/supervisor/conf.d/supervisord.conf
RUN sed -i "s|DEPLOY_HOME|${DEPLOY_HOME}|g" /etc/supervisor/conf.d/supervisord.conf
RUN sed -i "s/DEPLOY_USER/${DEPLOY_USER}/g" /etc/supervisor/conf.d/supervisord.conf
# Setting up supervisor web UI
RUN echo >> /etc/supervisor/supervisord.conf
RUN echo "[inet_http_server]"  >> /etc/supervisor/supervisord.conf
RUN echo "port=0.0.0.0:9001"   >> /etc/supervisor/supervisord.conf
# RUN sed -i -e "s/\;\(\[inet_http_server\]\)/\1/g" /etc/supervisor/supervisord.conf
# RUN sed -i -e "s/\;\(port=127.0.0.1:9001\)/\1/g"  /etc/supervisor/supervisord.conf

EXPOSE 9001
EXPOSE 5555

# USER ${DEPLOY_USER}

ENTRYPOINT ["./tools/entrypoint/web.sh"]
CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]
