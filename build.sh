#!/bin/sh

repository=$(cat repository)
gradle_current_version=$(cat gradle-current-version)
jdk_current_version=$(cat jdk-current-version)

for gradle_version in $(cat gradle-versions); do
    for jdk_version in $JDK_VERSIONS; do
        tag="${repository}:${gradle_version}-jdk${jdk_version}"
        docker build \
            -t "${repository}:${gradle_version}-jdk${jdk_version}" \
            --build-arg jdk_version="$jdk_version" \
            --build-arg gradle_version="$gradle_version" \
            --build-arg install_deps="$INSTALL_DEPS" \
            --build-arg cleanup="$CLEANUP" \
            .
        docker push "$tag"
        
        if [ "$gradle_version" = "$gradle_current_version" ]; then
            latest_tag="${repository}:jdk${jdk_version}"
            docker tag "$tag" "$latest_tag"
            echo docker push "$latest_tag"
            if [ "$jdk_version" = "$jdk_current_version" ]; then
                latest_tag="${repository}:latest"
                docker tag "$tag" "$latest_tag"
                docker push "$latest_tag"
            fi
        fi

        if [ "$jdk_version" = "$jdk_current_version" ]; then
            latest_tag="${repository}:${gradle_version}"
            docker tag "$tag" "$latest_tag"
            docker push "$latest_tag"
        fi
    done
done
