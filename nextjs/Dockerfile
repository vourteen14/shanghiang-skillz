FROM node:20 AS build

WORKDIR /app

COPY app/package.json ./
RUN npm install

COPY app/ ./

RUN npm test -- --coverage --watchAll=false
RUN npm run build

FROM node:20-alpine AS final

WORKDIR /app

COPY --from=build /app/package.json ./
COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/.next ./.next

EXPOSE 3000

CMD ["npm", "start"]