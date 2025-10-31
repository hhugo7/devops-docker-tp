FROM node:18-alpine

WORKDIR /app

COPY package*.json ./

RUN npm install --only=production

COPY . .

RUN adduser -D appuser && chown -R appuser /app
USER appuser

EXPOSE 3000

CMD ["npm", "start"]
