FROM node:lts-slim
ENV NODE_ENV=production
USER 1000

WORKDIR /app

COPY package.json .

RUN npm install --production

COPY . .

CMD ["node", "src/000.js"]
