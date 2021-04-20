.PHONY: dev clean

dev:
	docker run --rm -it -v $$(pwd)/src:/build/src:ro -v $$(pwd)/out:/build/out $$(docker build -q --target=development-environment --rm --file=Dockerfile ./src) \

clean:
	rm out/main*
