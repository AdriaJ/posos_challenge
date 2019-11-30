NAME = posos-application
PWD = $(shell pwd)

.PHONY: decrypt
decrypt:
	gpg -d data.tgz.gpg | tar -xz

.PHONY: build_train
build_train: decrypt
	docker build -f train2.Dockerfile\
	 							--tag $(NAME)_train\
								.

.PHONY: train
train: build_train clean_train
	docker run -it --rm -v $(PWD):/app\
								--name=$(NAME)_train\
								 $(NAME)_train:latest


.PHONY: clean_train
clean_train:
	docker rm -f $(NAME)_train 2> /dev/null || true
