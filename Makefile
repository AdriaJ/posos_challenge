NAME = posos-application
PWD = $(shell pwd)

.PHONY: decrypt
decrypt:
	gpg -d data.tgz.gpg | tar -xz

.PHONY: build_train
build_train: decrypt
	docker build -f trainer/trainer.Dockerfile\
	 							--tag $(NAME)_train\
								.

.PHONY: train
train: build_train clean_train
	docker run -it --rm -v $(PWD)/trainer:/app\
						-v $(PWD)/data:/data\
						-v $(PWD)/models:/models\
						--name=$(NAME)_train\
						 $(NAME)_train:latest


.PHONY: clean_train
clean_train:
	docker rm -f $(NAME)_train 2> /dev/null || true


.PHONY: build_api
build_api:
	docker build -f api/api.Dockerfile\
	 			--tag $(NAME)_api\
				.

.PHONY: api
api: build_api clean_api
	docker run -d --name $(NAME)_api\
	            -v $(PWD)/api:/app\
	            -v $(PWD)/models:/models\
				-p 4002:4002\
				$(NAME)_api:latest




.PHONY: clean_api
clean_api:
	docker rm -f $(NAME)_api 2> /dev/null || true
