SERVER_IMAGE = dockernbdvolume_server
DATA_IMAGE = dockernbdvolume_data
CLIENT_IMAGE = dockernbdvolume_client

all: poc

poc:
	fig build server client data
	fig up data || true  # will create a stopped container with name dockernbdvolume_data
	$(eval DATA_CID := $(shell docker ps -lq))
	$(eval DATA_VOLUME := $(shell docker inspect -f '{{index .Volumes "/data"}}' $(DATA_CID)))
	docker run -it --rm -v $(DATA_VOLUME):/data/ $(SERVER_IMAGE)
