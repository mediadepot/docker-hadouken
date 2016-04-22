FROM mediadepot/base
# Install apk packages
RUN apk --no-cache --update upgrade \
	&& apk add \
	boost-dev libtorrent-dev cmake build-base openssl-dev bash zip unzip wget
#Create hadouken folder structure & set as volumes
RUN mkdir -p /srv/hadouken/app && \
	mkdir -p /srv/hadouken/data && \
	mkdir -p /srv/hadouken/config

#Install Hadouken
RUN git clone https://github.com/hadouken/hadouken.git /srv/hadouken/app && \
	cd /srv/hadouken/app && git checkout tags/v5.1.0 \
	git submodule update --init	&& \
	./linux/build.sh

#	./linux/install-boost.sh && \
#	./linux/install-libtorrent.sh && \

#Copy over start script and docker-gen files
ADD ./start.sh /srv/start.sh
RUN chmod u+x  /srv/start.sh

VOLUME ["/srv/hadouken/app", "/srv/hadouken/config", "/srv/hadouken/data"]

EXPOSE 8080

#CMD ["/srv/start.sh"]
CMD ["sh"]