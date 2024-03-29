.PHONY: dev build clean

default: build

dev:
	docker run --rm -it -v $$(pwd)/src:/build/src:ro -v $$(pwd)/out:/build/out $$(docker build -q --target=development-environment --rm --file=Dockerfile ./src) \

build:
	DOCKER_BUILDKIT=1 docker build --target=export-stage --rm --output=./out/ --file=Dockerfile ./src

clean:
	rm out/main*
