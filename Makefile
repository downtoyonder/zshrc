SHELL := /bin/bash

test_image := zshrc:apt.test

build-test: 
	@docker build -t $(test_image) --no-cache -f test/apt.Dockerfile .

run-test:
	@if [[ ! -v IN_DOCKER ]]; then \
		if [[ $$(docker images --filter reference=$(test_image) | wc -l) -lt 2 ]]; then \
			make build-test; \
		fi \
	fi 

	@docker run --rm -it $(test_image)

entry := apply/apply.sh

apply-config:
	@bash $(entry)

clean:
	@rm -rf flags zplug
	@mkdir zplug
	@- docker rmi $(test_image)