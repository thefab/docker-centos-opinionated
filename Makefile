NAME=thefab/centos-opinionated
VERSION=$(shell ./version.sh)

build:
	docker build -f Dockerfile.squashed -t $(NAME):$(VERSION) .

devbuild:
	docker build -f Dockerfile.dev -t $(NAME):$(VERSION) .

debug: devbuild
	docker run -i -t $(NAME):$(VERSION) bash

release:
	if test "$(VERSION)" != "dev" -a "${DOCKER_PASSWORD}" != ""; then docker login -e="${DOCKER_EMAIL}" -u="${DOCKER_USERNAME}" -p="${DOCKER_PASSWORD}"; docker push $(NAME):$(VERSION); fi
