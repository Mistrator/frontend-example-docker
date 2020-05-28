FROM node:alpine as build-stage
WORKDIR /app
COPY . .
RUN npm install
ENV API_URL=http://localhost:8000
RUN npm run build

FROM node:alpine
RUN npm install -g serve
WORKDIR /app
RUN adduser -D app && chown app:app /app
USER app
COPY --from=build-stage /app/dist /app/dist
EXPOSE 5000/tcp
CMD ["serve", "-s", "-l", "5000", "dist"]
