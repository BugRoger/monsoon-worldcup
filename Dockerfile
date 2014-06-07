FROM phusion/passenger-ruby21:0.9.10

# Set correct environment variables.
ENV HOME /root
ENV SECRET_KEY_BASE db48f56a4ffa80bed89d69c849ff63584b6fb4555248a032c1559a0f3de9d4197450e47412142b106a65c9a38501a7b8a93cc861861ece008def2d63903cfeb2

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

# ...put your own build instructions here...

RUN apt-get -y update
RUN apt-get install -y -q postgresql-client libpq-dev

ADD docker/rails/nginx/monsoon-worldcup.conf /etc/nginx/sites-enabled/monsoon-worldcup.conf
ADD docker/rails/nginx/postgres.env /etc/nginx/main.d/postgres.env
ADD docker/rails/nginx/rails.env /etc/nginx/main.d/rails.env

WORKDIR /tmp 
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN bundle install --without development test doc


# Add public key for ssh login
#
# docker ps 
# docker inspect <ID> | grep IPAddress
# ssh -i /monsoon-worldcup/docker/rails/ssh/id_rsa root@`docker inspect rails | jq -r '.[].NetworkSettings.IPAddress'`
# vagrant ssh -c "ssh -i /monsoon-worldcup/docker/rails/ssh/id_rsa root@`docker inspect rails | jq -r '.[].NetworkSettings.IPAddress'`"

ADD docker/rails/ssh/id_rsa.pub /tmp/id_rsa.pub 
RUN cat /tmp/id_rsa.pub  >> /root/.ssh/authorized_keys && rm -f /tmp/id_rsa.pub 

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN rm -f /etc/service/nginx/down
