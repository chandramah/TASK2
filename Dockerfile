
FROM node:18

WORKDIR /app

COPY APP/package*.json ./
RUN npm install

COPY APP/. .

EXPOSE 3000
CMD ["npm", "start"]
