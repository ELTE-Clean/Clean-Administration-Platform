FROM amd64/docker:20.10.17-alpine3.16

RUN apk update && apk upgrade
RUN apk add --no-cache curl
RUN apk add --no-cache make
RUN apk add --no-cache file
WORKDIR /usr
RUN curl -o clean.tar.gz -k https://ftp.cs.ru.nl/Clean/Clean31/linux/clean3.1_64.tar.gz
RUN tar -xf clean.tar.gz
WORKDIR /usr/clean
RUN file -L /bin/sh > a.txt
RUN file -L bin/clm >> a.txt
# RUN make
RUN export CLEAN_HOME=/usr/clean
RUN export PATH=$PATH:$CLEAN_HOME/bin

WORKDIR /usr/src/app
COPY package*.json ./
COPY . .

ENV PYTHONUNBUFFERED=1
RUN apk add --no-cache python3 && ln -sf python3 /usr/bin/python
RUN python3 -m ensurepip
RUN pip3 install --no-cache --upgrade pip setuptools
RUN pip install pyyaml
EXPOSE 5000

RUN apk add nodejs npm
RUN npm ci --only=production
CMD ["node", "server.js"]