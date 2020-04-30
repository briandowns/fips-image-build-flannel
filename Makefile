SEVERITIES = HIGH,CRITICAL

.PHONY: all
all:
	docker build --build-arg TAG=$(TAG) -t briandowns/fips-image-build-flannel:$(TAG) .

.PHONY: image-push
image-push:
	docker push briandowns/fips-image-build-flannel:$(TAG) >> /dev/null

.PHONY: scan
image-scan:
	trivy --severity $(SEVERITIES) --no-progress --ignore-unfixed briandowns/fips-image-build-flannel:$(TAG)

.PHONY: image-manifest
image-manifest:
	docker image inspect briandowns/fips-image-build-flannel:$(TAG)
	DOCKER_CLI_EXPERIMENTAL=enabled docker manifest create fips-image-build-flannel:$(TAG) \
		$(shell docker image inspect briandowns/fips-image-build-flannel:$(TAG) | jq -r '.[] | .RepoDigests[0]')
