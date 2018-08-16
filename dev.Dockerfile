FROM elixir:1.6-alpine

WORKDIR /build

# COPY . .

RUN mix local.hex --force
RUN mix local.rebar --force
