FROM node:14-alpine
WORKDIR /usr/src/app
COPY package*.json ./
COPY ../scripts/CorrectTest.py ./
COPY . .
EXPOSE 5000
RUN npm ci --only=production
CMD [ "node", "server.js" ]