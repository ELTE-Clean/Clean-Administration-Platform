FROM node:14-alpine
WORKDIR /usr/src/app
COPY package*.json ./
COPY . .
EXPOSE 5001
RUN npm install -c=production
CMD ["npm", "run", "prod"]