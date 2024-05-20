
test_image:=zshrc:apt.test
test_base_image:=zshrc:apt.base

build-base:
	@docker build -t $(test_base_image) -f test/apt.base.Dockerfile .

build-test: build-base
	@docker build -t $(test_image) --no-cache -f test/apt.Dockerfile .

run-test:
	@docker run --rm -it $(test_image)