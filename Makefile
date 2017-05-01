NAME = ivanilves/blackvpn
TAG  = latest

build:
	docker build --no-cache -t $(NAME):$(TAG) .

push:
	docker push $(NAME):$(TAG)

all: build push
