function getImageVersions {
	#1 - image name
	wget -q https://registry.hub.docker.com/v1/repositories/moledzki/${1}/tags -O -  | sed -e 's/[][]//g' -e 's/"//g' -e 's/ //g' | tr '}' '\n'  | awk -F: '{print $3}'
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
	sudo docker build -t moledzki/${IMAGE_NAME}:${IMAGE_VERSION} ${BUILD_ARGS[*]} image/
}

function pushImage {
	sudo docker push moledzki/${IMAGE_NAME}:${IMAGE_VERSION}
}
