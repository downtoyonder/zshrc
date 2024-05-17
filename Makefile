
test_image:=zshrc:test

build-test:
	@docker build -t $(test_image) -f apt.Dockerfile .

run-test: build-test
	@docker run --rm -it $(test_image)