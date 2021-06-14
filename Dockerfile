FROM node:16.3.0-alpine as dependencies
WORKDIR /app
COPY package*.json ./
RUN npm ci --production

FROM node:16.3.0-alpine
WORKDIR /app
RUN adduser -D noroot && chown -R noroot /app
USER noroot
COPY --from=dependencies /app/node_modules ./node_modules/
COPY . .
EXPOSE 3000
ENV PORT "3000"
ENV MONGODB_URI "mongodb://localhost:27017"
CMD ["npm", "start"]
