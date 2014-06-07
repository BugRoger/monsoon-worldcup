FROM phusion/passenger-ruby21:0.9.10

# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

# ...put your own build instructions here...

RUN apt-get -y update
RUN apt-get install -y -q postgresql-client

ADD nginx/monsoon-worldcup.conf /etc/nginx/sites-enabled/monsoon-worldcup.conf
ADD nginx/postgres.env /etc/nginx/main.d/postgres.env
RUN rm -f /etc/service/nginx/down

WORKDIR /tmp 
ADD ./Gemfile Gemfile
ADD ./Gemfile.lock Gemfile.lock
RUN bundle install



# Add public key for ssh login
#
# docker ps 
# docker inspect <ID> | grep IPAddress
# ssh -i /monsoon-worldcup/docker/rails/ssh/id_rsa root@`docker inspect rails | jq -r '.[].NetworkSettings.IPAddress'`
# vagrant ssh -c "ssh -i /monsoon-worldcup/docker/rails/ssh/id_rsa root@`docker inspect rails | jq -r '.[].NetworkSettings.IPAddress'`"

ADD ssh/id_rsa.pub /tmp/id_rsa.pub 
RUN cat /tmp/id_rsa.pub  >> /root/.ssh/authorized_keys && rm -f /tmp/id_rsa.pub 

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
