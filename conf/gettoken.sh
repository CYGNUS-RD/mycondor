#!/bin/bash
#

unset OIDC_SOCK; unset OIDCD_PID; eval `oidc-keychain`
oidc-gen --flow device --dae https://iam.cloud.infn.it/devicecode --issuer https://iam.cloud.infn.it --scope='openid profile email offline_access wlcg wlcg.groups' --pw-cmd="" infncloud-wlcg
oidc-token infncloud-wlcg -s "openid profile offline_access wlcg wlcg.groups" > /tmp/token
