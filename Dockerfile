FROM python:3-slim

COPY requirements.txt ./requirements.txt

## install dependencies
RUN apt-get update && \
    apt-get install -y build-essential musl-dev && \
    apt-get install -y libpq-dev && \
    pip install -r requirements.txt && \
    apt-get -y remove build-essential musl-dev libpq-dev && \
    apt-get -y clean && apt-get -y autoremove

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

## set working directory
WORKDIR /usr/src/app

COPY . .

EXPOSE 8000
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
