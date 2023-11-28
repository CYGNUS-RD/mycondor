#!/bin/bash
#
# CLOUD INFN version 15/2/2
######################
# confiig conndor CYGNO queue
cat > /etc/condor/condor_config.local << EOF 
AUTH_SSL_CLIENT_CAFILE = /etc/pki/ca-trust/source/anchors/htcondor_ca.crt
SCITOKENS_FILE = /tmp/token
SEC_DEFAULT_AUTHENTICATION_METHODS = SCITOKENS
COLLECTOR_HOST = 131.154.99.182.myip.cloud.infn.it:30618
SCHEDD_HOST = 131.154.99.182.myip.cloud.infn.it
EOF
### 
# config gettoken command 
cat > /usr/bin/gettoken << EOF
echo "*/10 * * * * eval \`oidc-keychain\` && echo \`oidc-token infncloud-wlcg -s \"openid profile offline_access wlcg wlcg.groups\"\` > /tmp/token" | crontab - 
unset OIDC_SOCK; unset OIDCD_PID; eval `oidc-keychain`
oidc-gen --flow device --dae https://iam.cloud.infn.it/devicecode --issuer https://iam.cloud.infn.it --scope='openid profile email offline_access wlcg wlcg.groups' --pw-cmd="" infncloud-wlcg
oidc-token infncloud-wlcg -s "openid profile offline_access wlcg wlcg.groups" > /tmp/token
EOF
### 
chmod +x /usr/bin/gettoken
#####################
