FROM quay.io/kwiksand/cryptocoin-base:latest

RUN useradd -m crave

ENV DAEMON_RELEASE="v2.1.0.2"
ENV CRAVE_DATA=/home/crave/.crave
    
USER crave

RUN cd /home/crave && \
    mkdir /home/crave/bin && \
    mkdir .ssh && \
    chmod 700 .ssh && \
    ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts && \
    ssh-keyscan -t rsa bitbucket.org >> ~/.ssh/known_hosts && \
    git clone --branch $DAEMON_RELEASE https://github.com/CooleRRSA/crave.git craved && \
    cd /home/crave/craved/src && \
    make -f makefile.unix USE_UPNP= && \
    strip craved && \
    mv craved /home/crave/bin && \
    rm -rf /home/crave/craved
    
EXPOSE 30104 30105

#VOLUME ["/home/crave/.crave"]

USER root

COPY docker-entrypoint.sh /entrypoint.sh

RUN chmod 777 /entrypoint.sh && \
    echo "\n# Some aliases to make the crave clients/tools easier to access\nalias craved='/usr/bin/craved -conf=/home/crave/.crave/crave.conf'\n\n[ ! -z \"\$TERM\" -a -r /etc/motd ] && cat /etc/motd" >> /etc/bash.bashrc && \
    echo "Crave (CRAVE) Cryptocoin Daemon\n\nUsage:\n craved help - List help options\n craved listtransactions - List Transactions\n\n" > /etc/motd && \
    chmod 755 /home/crave/bin/craved && \
    mv /home/crave/bin/craved /usr/bin/craved && \
    ln -s /usr/bin/craved /usr/bin/crave

ENTRYPOINT ["/entrypoint.sh"]

CMD ["craved"]
