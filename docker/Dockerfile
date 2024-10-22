FROM htcondor/mini
RUN yum install -y oidc-agent
RUN pip install git+https://github.com/DODAS-TS/boto3sts
RUN pip install git+https://github.com/CYGNUS-RD/cygno.git
RUN chmod -R 777 /home/submituser/
RUN echo "### personalization ###" >> /etc/bashrc
RUN echo "alias htc='source cygno_htc'" >> /etc/bashrc
RUN echo "PS1='HTCONDOR:\w> '" >> /etc/bashrc
RUN echo "alias tcloud='oidc-gen --flow device --dae $IAM_SERVER/devicecode --issuer $IAM_SERVER --scope="$IAM_SCOPES" --pw-cmd="" cloud'" >> /etc/bashrc
COPY htcondor_ca.crt /etc/pki/ca-trust/source/anchors/htcondor_ca.crt
WORKDIR home/submituser/
