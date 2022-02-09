#!/bin/sh
# 
echo "ciao" > /tmp/test
#
# install crontab
#
yum install -y crontabs
crontab -l | { cat; echo "*/10 * * * * eval \`oidc-keychain\` && echo \`oidc-token infncloud-wlcg -s \"openid profile offline_access wlcg wlcg.groups\"\` > /tmp/token"; } | crontab -
