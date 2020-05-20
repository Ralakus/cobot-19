FROM python:alpine

WORKDIR /usr/src/app

COPY requirements.txt ./
RUN apk add --update bash gcc g++ musl-dev linux-headers curl
RUN curl -L https://github.com/plotly/orca/releases/download/v1.3.1/orca-1.3.1.AppImage -o /bin/orca

RUN pip install --no-cache-dir -r requirements.txt

COPY . /usr/src/app

CMD [ "./run.sh" ]