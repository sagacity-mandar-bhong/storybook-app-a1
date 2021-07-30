# Stage 1

FROM node:14-alpine as build-step
RUN mkdir -p /app
WORKDIR /app
COPY package.json /app
RUN npm install
COPY . /app
RUN npm run build
RUN npm run build-storybook -- -o ./storybook-build

# Stage 2
FROM nginx:1.17.1-alpine
COPY --from=build-step /app/dist/storybook /usr/share/nginx/html
COPY --from=build-step /app/storybook-build /usr/share/nginx/html/storybook