FROM phusion/baseimage:0.9.10

# Crap
ENV http_proxy http://proxy.wdf.sap.corp:8080 
ENV https_proxy http://proxy.wdf.sap.corp:8080
ENV ftp_proxy http://proxy.wdf.sap.corp:8080 
ENV no_proxy sap.corp,localhost

# Set correct environment variables.
ENV HOME /root

RUN locale-gen en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8
ENV LC_ALL en_US.UTF-8
RUN apt-get -y update
RUN LC_ALL=en_US.UTF-8 DEBIAN_FRONTEND=noninteractive apt-get install -y postgresql-9.3

# Add Postgres to runit
RUN mkdir /etc/service/postgres
ADD run_postgres.sh /etc/service/postgres/run
RUN chown root /etc/service/postgres/run

ADD postgresql.conf /etc/postgresql/9.3/main/postgresql.conf
ADD pg_hba.conf /etc/postgresql/9.3/main/pg_hba.conf

# Add public key for ssh login
ADD ssh/id_rsa.pub /tmp/id_rsa.pub 
RUN cat /tmp/id_rsa.pub  >> /root/.ssh/authorized_keys && rm -f /tmp/id_rsa.pub 

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME ["/var/lib/postgresql"]
EXPOSE 5432
CMD ["/sbin/my_init"]
