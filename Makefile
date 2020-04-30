SEVERITIES = HIGH,CRITICAL

.PHONY: all
all:
	docker build -t briandowns/fips-image-build-flannel:v0.12.0 .

.PHONY: image-push
image-push:
	docker push briandowns/fips-image-build-flannel:v0.12.0 >> /dev/null

.PHONY: scan
image-scan:
	trivy --severity $(SEVERITIES) --no-progress --ignore-unfixed briandowns/fips-image-build-flannel:v0.12.0

.PHONY: image-manifest
image-manifest:
	which jq
	docker image inspect briandowns/fips-image-build-flannel:v0.12.0
	DOCKER_CLI_EXPERIMENTAL=enabled docker manifest create fips-image-build-flannel:v0.12.0 \
		$(shell docker image inspect briandowns/fips-image-build-flannel:v0.12.0 | jq -r '.[] | .RepoDigests[0]')
