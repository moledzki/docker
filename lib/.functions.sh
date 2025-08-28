function getImageVersions {
	#1 - image name
	curl -s https://hub.docker.com/v2/namespaces/moledzki/repositories/${1}/tags  | jq -r '.results[].name' | sort -rV | head -1
}

function ensureNewImageVersion {
	if getImageVersions ${IMAGE_NAME} | grep ${IMAGE_VERSION}
	then
		echo "Version ${IMAGE_VERSION} is already pushed to docker registry, please update INFO file!"
		exit 1
	fi
}

function buildArgumentList {
	declare -g BUILD_ARGS=()
	for arg in "$@"
	do
		BUILD_ARGS+=("--build-arg ${arg}")
	done
}

function buildImage {
	ensureNewImageVersion
	buildArgumentList "$@"
	docker build -t moledzki/${IMAGE_NAME}:${IMAGE_VERSION} ${BUILD_ARGS[*]} image/
}

function pushImage {
	docker push moledzki/${IMAGE_NAME}:${IMAGE_VERSION}
}
