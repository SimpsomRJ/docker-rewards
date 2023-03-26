#!/bin/bash

#rm -R bing-rewards
#git clone https://github.com/jjjchens235/bing-rewards.git
#pip install -r bing-rewards/BingRewards/requirements.txt
cd /bing-rewards/
/bin/bash update.sh
cd /bing-rewards/BingRewards

if [ $# -eq 0 ] ; then
    echo "Syntax: ./run.sh '<original BingRewards.py parameters>' '<email1> <email2> ... <emailN>' '<password1> <password2> ... <passwordN>' <telegram_token> <telegram_user_id>"
    exit 1
fi

params=$( echo $1 )

if [ $# -gt 1 ]
then
    email=$( echo $2 )
fi

if [ $# -gt 2 ]
then
    pass=( $3 )
    passwords=`printf "'%s' " "${pass[@]}"`
fi

if [ $# -gt 3 ]
then
    tat=$( echo $4 )
fi

if [ $# -gt 4 ]
then
    tu=$( echo $5 )
fi

if [ ! -f config/config_multiple_accounts.json ] ; then 
    python setup.py -e $email -p $passwords
    python setup.py --telegram_api_token $tat--telegram_userid $tu
fi

sed -i 's/options.add_argument("--disable-gpu")/options.add_argument("--disable-gpu")\n        options.add_argument("--no-sandbox")\n        options.add_argument("--ipc=host")\n        options.add_argument("--disable-dev-shm-usage")\n/' src/driver.py
sed -i "s/('telegram_api_token'))/('telegram_api_token')).replace('\\\n', '')/" BingRewards.py
sed -i "s/('telegram_userid'))/('telegram_userid')).replace('\\\n', '')/" BingRewards.py

eval "/usr/bin/python3 BingRewards.py $params"
