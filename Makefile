build:
	docker build -f Dockerfile.squashed .

devbuild:
	docker build -f Dockerfile.dev .
