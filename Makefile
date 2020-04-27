.PHONY: all
all:
	docker build -t briandowns/fips-image-build-flannel:v0.12.0 .

.PHONY: image-push
image-push:
	docker push briandowns/fips-image-build-flannel:v0.12.0 >> /dev/null

.PHONY: image-manifest
image-manifest:
	docker manifest create fips-image-build-flannel:v0.12.0 \
		$(shell docker image inspect briandowns/fips-image-build-flannel:v0.12.0 | jq -r '.[] | .RepoDigests[0]')
