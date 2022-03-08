FROM ubuntu

# Install every dependencies
RUN apt-get update -y && \ 
    apt-get install wget -y && \
    apt-get install gnupg -y ; \
    wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | apt-key add - ; \
    echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-5.0.list && \
    apt-get update && \
    apt-get install -y mongodb-org && \
    useradd -ms /bin/bash runner

COPY .env /home/mongodb/
COPY setup.sh /home/mongodb/

RUN chown -R runner:runner /home/mongodb/

EXPOSE 27017

#USER runner

WORKDIR /home/mongodb/

ENTRYPOINT ["sh", "setup.sh"]
#ENTRYPOINT [ "/bin/bash" ]