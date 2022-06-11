FROM node:17.9.1-bullseye

# ----------- Installing Extra Packages
# Vim Editor
RUN apt-get update && apt-get install apt-file -y && apt-file update && apt-get install vim -y 

# ----------- Installing Clean Compiler
WORKDIR /usr
RUN curl -o clean.tar.gz -k https://ftp.cs.ru.nl/Clean/builds/linux-x64/clean-bundle-complete-linux-x64-latest.tgz
RUN tar -xf clean.tar.gz
ENV CLEAN_HOME=/usr/clean-bundle-complete
ENV PATH=$PATH:$CLEAN_HOME/bin


# ---------- Running the server
WORKDIR /usr/src/app
COPY package*.json ./
COPY . .

EXPOSE 5000
# RUN apk add nodejs npm
RUN npm ci --only=production
CMD ["node", "server.js"]