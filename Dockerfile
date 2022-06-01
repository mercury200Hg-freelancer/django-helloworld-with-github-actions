FROM ubuntu:20.04

ENV TZ="Asia/Kolkata"
ENV DEBIAN_FRONTEND=noninteractive

EXPOSE 8000

WORKDIR /opt/hello-world

ADD . .

RUN apt update && \
    apt install -y tzdata python3-dev python3-pip python3-virtualenv sqlitebrowser && \
    python3 -m pip install --upgrade pip && \
    if [ -f requirements.txt ]; then pip3 install -r requirements.txt; fi && \
    python3 manage.py migrate --noinput;

ENTRYPOINT ["/usr/bin/python3","manage.py",  "runserver", "0.0.0.0:8000"]