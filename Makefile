.PHONY: test

COMPOSE_PROJECT_NAME=jack_marchant

COMPOSE_FILE?=docker-compose.yml

BASE_DIR=$(PWD)

COMPOSE_OVERRIDE_FILE?=
ifeq ($(COMPOSE_OVERRIDE_FILE),)
COMPOSE=docker-compose -p $(COMPOSE_PROJECT_NAME) -f $(COMPOSE_FILE)
else
COMPOSE=docker-compose -p $(COMPOSE_PROJECT_NAME) -f $(COMPOSE_FILE) -f $(COMPOSE_OVERRIDE_FILE)
endif

build:
	$(COMPOSE) build

up:
	$(COMPOSE) pull
	$(COMPOSE) up -d $(COMPOSE_PROJECT_NAME)

down:
	$(COMPOSE) down

clean:
	$(COMPOSE) kill
	$(COMPOSE) rm --force

shell:
	docker exec -it $(COMPOSE_PROJECT_NAME)_$(COMPOSE_PROJECT_NAME)_1 /bin/sh

init: build up shell

logs:
	docker logs -f $(COMPOSE_PROJECT_NAME)_$(COMPOSE_PROJECT_NAME)_1

pre-deploy: VERSION?=
pre-deploy:
	docker build -t jackmarchant/$(COMPOSE_PROJECT_NAME):$(VERSION) --build-arg APP_VERSION=$(VERSION) --build-arg HOSTNAME=localhost --build-arg PORT=4000 --build-arg DATABASE_URL=ecto://postgres:postgres@localhost:5432/jack_marchant_dev --build-arg MIX_ENV=prod .

deploy: VERSION?=
deploy:
	docker build -t jackmarchant/$(COMPOSE_PROJECT_NAME):$(VERSION) --build-arg APP_VERSION=$(VERSION) --build-arg HOSTNAME=localhost --build-arg PORT=4000 --build-arg DATABASE_URL=ecto://postgres:postgres@localhost:5432/jack_marchant_dev --build-arg MIX_ENV=prod .
	docker push jackmarchant/$(COMPOSE_PROJECT_NAME):$(VERSION)
