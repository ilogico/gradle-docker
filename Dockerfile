ARG jdk_version='8'
FROM openjdk:${jdk_version}

ARG gradle_version='4.9'
ARG install_deps=':'
ARG cleanup=':'

RUN sh -c "$install_deps" \
    && mkdir -p /opt \
    && cd /opt \
    && curl -o gradle.zip "https://downloads.gradle.org/distributions/gradle-${gradle_version}-bin.zip" \
    && unzip gradle.zip \
    && rm gradle.zip \
    && ln -s "/opt/gradle-${gradle_version}/bin/gradle" /usr/local/bin/gradle \
    && sh -c "$clean_up"

VOLUME "/root/.gradle"
