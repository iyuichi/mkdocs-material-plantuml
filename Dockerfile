FROM alpine:3.8

# Default to UTF-8 file.encoding
ENV LANG C.UTF-8

# install JDK
RUN { \
		echo '#!/bin/sh'; \
		echo 'set -e'; \
		echo; \
		echo 'dirname "$(dirname "$(readlink -f "$(which javac || which java)")")"'; \
	} > /usr/local/bin/docker-java-home \
	&& chmod +x /usr/local/bin/docker-java-home
ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV PATH $PATH:/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin
ENV JAVA_VERSION 8u191
ENV JAVA_ALPINE_VERSION 8.191.12-r0
RUN set -x \
	&& apk add --no-cache \
		openjdk8="$JAVA_ALPINE_VERSION" \
	&& [ "$JAVA_HOME" = "$(docker-java-home)" ]

# Install paython & PlantUML
RUN apk update; \
    apk add python2-dev py-pip graphviz ttf-droid ttf-droid-nonlatin curl; \
    curl -L https://sourceforge.net/projects/plantuml/files/plantuml.jar/download -o /usr/bin/plantuml.jar ;\
    apk del curl ;
COPY plantuml /usr/bin/plantuml 
RUN chmod +x /usr/bin/plantuml 
# Install dependencies
COPY requirements.txt .
RUN \
pip install -r requirements.txt && \
rm requirements.txt

# Set working directory
WORKDIR /docs

# Expose MkDocs development server port
EXPOSE 8000

# Start development server by default
ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]