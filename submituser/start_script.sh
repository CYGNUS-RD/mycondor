#!/bin/sh
# 
echo "ciao" > /tmp/test
#
# install crontab
#
#crontab -l | { cat; echo "*/10 * * * * eval `oidc-keychain` && echo `oidc-token infncloud-wlcg -s "openid profile offline_access wlcg wlcg.groups"` > /tmp/token 2>&1"; } | crontab -
