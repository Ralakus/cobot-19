FROM python:alpine

WORKDIR /usr/src/app

COPY requirements.txt ./
RUN apk add --update docker openrc bash gcc g++ musl-dev
RUN rc-update add docker boot

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD [ "./run.sh" ]