FROM ubuntu:14.04

MAINTAINER Juergen Bruester github@devilscab.de

# add repos for avidemux
RUN echo "deb http://www.deb-multimedia.org wheezy main non-free" >> /etc/apt/sources.list
RUN echo "deb http://www.deb-multimedia.org wheezy-backports main" >> /etc/apt/sources.list

RUN apt-get update \
		&& apt-get -y --force-yes install deb-multimedia-keyring \
		&& apt-get update \
		&& apt-get -y install curl wget dialog nano bzip2 libav-tools avidemux-cli \
		&& apt-get clean \
		&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV otrdecoderFileName otrdecoder-bin-x86_64-unknown-linux-gnu-0.4.1132
RUN curl -o otrdecoder.tar.bz2 http://www.onlinetvrecorder.com/downloads/${otrdecoderFileName}.tar.bz2
RUN tar -xf otrdecoder.tar.bz2

WORKDIR ${otrdecoderFileName}
RUN chmod +x otrdecoder
ENV PATH $PATH:/"${otrdecoderFileName}"

# install multicut
RUN echo 'alias sudo=""' >> ~/.bashrc
RUN mkdir /home/root
RUN curl -o multicut.sh https://raw.githubusercontent.com/crushcoder/multicut_light/master/multicut_light_20100518.sh
RUN chmod +x multicut.sh
COPY .multicut_light.rc /root/.multicut_light.rc

# batch script
COPY functions.sh auto.sh ff.sh ffall.sh /${otrdecoderFileName}/
RUN chmod +x functions.sh auto.sh ff.sh ffall.sh

RUN mkdir /otr
WORKDIR /otr

CMD ["auto.sh"]