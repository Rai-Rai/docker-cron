FROM ubuntu:18.04

# Install cron
RUN apt-get update -y
#RUN apt-get full-upgrade -y  --no-install-recommends
RUN apt-get install -y  --no-install-recommends cron git nano php7.2 php7.2-xml

# Add crontab file in the cron directory
ADD crontab /etc/cron.d/simple-cron

# Add shell script and grant execution rights
ADD script.sh /script.sh
RUN chmod +x /script.sh

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/simple-cron

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

# Run the command on container startup
CMD cron && tail -f /var/log/cron.log
