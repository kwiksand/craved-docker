FROM quay.io/kwiksand/cryptocoin-base:latest

RUN useradd -m crave

ENV CRAVE_DATA=/home/crave/.crave
    
RUN apt-get install -y libgmp-dev && \
    git clone https://github.com/bitcoin/secp256k1.git && \
    cd secp256k1 && \
    ./autogen.sh && \
    ./configure && \
    make && \
    make install

USER crave

RUN cd /home/crave && \
    mkdir .ssh && \
    chmod 700 .ssh && \
    ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts && \
    ssh-keyscan -t rsa bitbucket.org >> ~/.ssh/known_hosts && \

    LD_LIBRARY_PATH=/usr/local/lib && \
    export LD_LIBRARY_PATH && \

    git clone https://github.com/CooleRRSA/crave.git craved && \
    cd /home/crave/craved/src && \
    make -f makefile.unix USE_UPNP= && \
    strip craved
    
EXPOSE 30104 30105

#VOLUME ["/home/crave/.crave"]

USER root

COPY docker-entrypoint.sh /entrypoint.sh

RUN chmod 777 /entrypoint.sh && cp /home/crave/craved/src/craved /usr/bin/craved && chmod 755 /usr/bin/craved

ENTRYPOINT ["/entrypoint.sh"]

CMD ["craved"]
