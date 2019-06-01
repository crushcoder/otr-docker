FROM debian/eol:wheezy

MAINTAINER Juergen Bruester github@devilscab.de

# add repos for avidemux		
RUN echo "deb http://archive.deb-multimedia.org wheezy main non-free" >> /etc/apt/sources.list
RUN echo "deb http://archive.deb-multimedia.org wheezy-backports main" >> /etc/apt/sources.list
RUN apt-get update \
		&& apt-get install -y --force-yes deb-multimedia-keyring \
		&& apt-get update \
		&& apt-get -y install curl wget dialog nano bzip2 bc avidemux-cli ffmpeg \
		&& apt-get clean \
		&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


ENV otrdecoderFileName otrdecoder-bin-x86_64-unknown-linux-gnu-0.4.1133
RUN curl -o otrdecoder.tar.bz2 https://www.onlinetvrecorder.com/downloads/otrdecoder-bin-x86_64-unknown-linux-gnu-0.4.1133.tar.bz2
RUN tar -xf otrdecoder.tar.bz2

WORKDIR ${otrdecoderFileName}
RUN chmod +x otrdecoder
ENV PATH $PATH:/"${otrdecoderFileName}"

# install multicut
RUN echo 'alias sudo=""' >> ~/.bashrc
RUN mkdir /home/root
RUN curl -o multicut.sh https://raw.githubusercontent.com/crushcoder/multicut_light-1/master/multicut_light.sh
RUN chmod +x multicut.sh
COPY multicut_light.rc /root/.multicut_light.rc

RUN curl -o otrcut.sh https://raw.githubusercontent.com/m23project/otrcut.sh/master/otrcut.sh
RUN chmod +x otrcut.sh

# batch script
COPY functions.sh auto.sh ff.sh ffall.sh mcall.sh /${otrdecoderFileName}/
COPY README_de.md README.md /
RUN chmod +x functions.sh auto.sh ff.sh ffall.sh mcall.sh

RUN mkdir /otr
WORKDIR /otr

CMD ["auto.sh"]