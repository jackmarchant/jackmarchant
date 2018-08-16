FROM elixir:1.6-alpine AS build

WORKDIR /build

COPY mix.exs .
COPY mix.lock .
COPY deps deps

ARG MIX_ENV=prod
ARG APP_VERSION=0.0.0
ENV MIX_ENV ${MIX_ENV}
ENV APP_VERSION ${APP_VERSION}

RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get

COPY lib lib
COPY test test
COPY config config
COPY rel rel

# Uncomment line below if you have assets in the priv dir
COPY priv priv

# Build Phoenix assets
COPY assets assets
RUN mix phx.digest
RUN mix ecto.migrate

RUN mix release --env=${MIX_ENV}

### Minimal run-time image
FROM alpine:latest

RUN apk --no-cache update && apk --no-cache upgrade && apk --no-cache add ncurses-libs openssl bash ca-certificates

RUN adduser -D app

ARG MIX_ENV=prod
ARG APP_VERSION
ARG PORT=4000
ARG HOSTNAME=localhost
ARG DATABASE_URL=ecto://postgres:postgres@localhost:5432/jack_marchant_dev

ENV MIX_ENV ${MIX_ENV}
ENV APP_VERSION ${APP_VERSION}
ENV PORT ${PORT}
ENV HOSTNAME ${HOSTNAME}
ENV DATABASE_URL ${DATABASE_URL}

WORKDIR /opt/app

# Copy release from build stage
COPY --from=build /build/_build/${MIX_ENV}/rel/* ./

USER app

# Mutable Runtime Environment
RUN mkdir /tmp/app
ENV RELEASE_MUTABLE_DIR /tmp/app
ENV START_ERL_DATA /tmp/app/start_erl.data

# Start command
CMD ["/opt/app/bin/jack_marchant", "foreground"]