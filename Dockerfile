FROM jwong235/bing-rewards:latest

RUN apt-get -y update && apt-get -y upgrade && apt-get -y clean && apt-get -y --purge autoremove

COPY script.sh run.sh /bing-rewards/

WORKDIR /bing-rewards

RUN chmod +x run.sh script.sh

RUN /bin/bash /bing-rewards/update.sh
