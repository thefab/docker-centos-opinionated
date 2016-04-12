NAME=thefab/centos-opinionated
VERSION=$(shell ./version.sh)

build:
	docker build -f Dockerfile.squashed -t $(NAME):$(VERSION) .

devbuild:
	docker build -f Dockerfile.dev -t $(NAME):$(VERSION) .

debug: devbuild
	docker run -i -t $(NAME):$(VERSION) bash
