FROM jwong235/bing-rewards:latest

RUN apt-get -y update && apt-get -y upgrade && apt-get -y clean && apt-get -y --purge autoremove

COPY script.sh run.sh /bing-rewards/

WORKDIR /bing-rewards

RUN chmod +x run.sh script.sh

RUN git config --unset http.http://bitbucket.org/bing-rewards/bing-rewards.proxy

RUN /bin/bash /bing-rewards/scripts/update.sh

RUN /usr/local/bin/python -m pip install --upgrade pip
