
test_image:=zshrc:test
test_base_image:=zshrc:base

build-base:
	@docker build --target builder -t $(test_base_image) -f apt.Dockerfile .

build-test: build-base
	@docker build --target runner -t $(test_image) -f apt.Dockerfile --no-cache .

run-test:
	@docker run --rm -it $(test_image)