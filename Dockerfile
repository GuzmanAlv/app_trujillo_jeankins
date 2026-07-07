FROM ubuntu:22.04 AS build
RUN apt-get update && apt-get install -y curl git unzip
RUN git clone https://github.com/flutter/flutter.git /flutter
ENV PATH="/flutter/bin:$PATH"
WORKDIR /app
COPY . .
RUN flutter build web --release

FROM nginx:alpine
COPY --from=build /app/build/web /usr/share/nginx/html
EXPOSE 80
ENTRYPOINT ["nginx", "-g", "daemon off;"]