FROM python:alpine

WORKDIR /usr/src/app

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

RUN apk add --update docker openrc bash
RUN rc-update add docker boot

COPY . .

CMD [ "./run.sh" ]