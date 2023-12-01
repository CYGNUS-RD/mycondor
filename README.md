# CYGNO Condor Queue

Submit jobs on CYGNO condor INFN Cloud queue

there are two way to submit job under the experiment queue:
* acccess to cloud https://notebook.cygno.cloud.infn.it:8888/ open a terminal and follow the [istruction for Cygno Condor Cloud](https://github.com/CYGNUS-RD/mycondor#cygno-condor-cloud)
* download and install Docker for your platform (e.g. your leptop) [https://docs.docker.com/get-docker/](https://docs.docker.com/get-docker/) and use Cygno Condor Container from your PC or server, etc. an then follow the [istruction for Cygno Condor Container](https://github.com/CYGNUS-RD/mycondor#cygno-condor-container)

### Cygno Condor Cloud in your notebook (once forever)
* connect to cygno cloud interface:  https://notebook.cygno.cloud.infn.it:8888
* to sertup caondor access permanently plese setup (where USERNAME is your username)
  ```
  vi /jupyter-workspace/cloud-storage/USERNAME/.bashrc
  ```
  * put this code in your bash file
  ```
  # confiig conndor CYGNO queue
  cat > /etc/condor/condor_config.local << EOF 
  AUTH_SSL_CLIENT_CAFILE = /etc/pki/ca-trust/source/anchors/htcondor_ca.crt
  SCITOKENS_FILE = /tmp/token
  SEC_DEFAULT_AUTHENTICATION_METHODS = SCITOKENS
  COLLECTOR_HOST = 131.154.98.46.myip.cloud.infn.it:30618
  SCHEDD_HOST = 131.154.98.46.myip.cloud.infn.it
  EOF
  ```
  * cloese and re-open your terminal, now the queues are configured forver (this is valid for any cluster configured under condor)

* to submit your job **open a terminal** and follow the instructions below to [submit a job](https://github.com/CYGNUS-RD/mycondor/blob/main/README.md#submit-a-job)

- Queue 1 **reserved** to reco: 131.154.98.218
- Queue 2 **reserved** to reco: 131.154.99.82
- Queue Sym and public: 131.154.98.46

### Cygno Condor Container (optional)
download Cygno Condor Container configuration 

    git clone https://github.com/CYGNUS-RD/mycondor.git
    cd mycondor/

in the directory ***private*** you will find example and there you have to copy/move your code to be submitted. The folder is shared with running container and continuosly updated

run Cygno Condor Container 
```
docker-compose up -d
```      
      
then follow the istraction below to [submit a job](https://github.com/CYGNUS-RD/mycondor/#submit-a-job) 
ONLY on Container (not from netebook terminal) you need to get the tocken any time you need with the command **gettoken** to the prompt

      [root@5045c42ec547 /]# gettoken
    
follow the istrctions and press enter to any question (do not enter any password) 
      
### Submit a job 
check if all is right e.g. monotoring the condor queue status

      [root@5045c42ec547 /]# condor_status
      Name                    OpSys      Arch   State     Activity LoadAv Mem   ActvtyTime

      wn-pod-7b4747c8cd-bq9d5 LINUX      X86_64 Unclaimed Idle      0.000 7959  8+01:45:21
      wn-pod-7b4747c8cd-ljslg LINUX      X86_64 Unclaimed Idle      0.000 7959  2+00:21:34
      wn-pod-7b4747c8cd-r52dg LINUX      X86_64 Unclaimed Idle      0.000 7959  8+01:35:19
      wn-pod-7b4747c8cd-sfqh7 LINUX      X86_64 Unclaimed Idle      0.000 7959  8+01:35:21
      wn-pod-7b4747c8cd-sksm4 LINUX      X86_64 Unclaimed Idle      0.000 7959  8+01:25:06

                     Machines Owner Claimed Unclaimed Matched Preempting  Drain

        X86_64/LINUX        5     0       0         5       0          0      0

               Total        5     0       0         5       0          0      0

Now you are up and running. On in the container shell you can change directory to the shared folder with your PC where you can put your software. On the cloud you have to change the directory and upload via web interface your software/directory with your code. The **private** is permanent directory.

      cd private/

to access and test your code, follow the istructions below for more detteils: 

* condor@INFN [https://codimd.infn.it/s/VD3RWisM6#Submitting-a-demo-job](https://codimd.infn.it/s/VD3RWisM6#Submitting-a-demo-job)
* file IO [https://codimd.infn.it/s/pbisNdDlN](https://codimd.infn.it/s/pbisNdDlN) [esempio](https://github.com/CYGNUS-RD/cygno/blob/main/dev/presigned.py)

***Tip on containers***: you can exit when you like from the contaner and reconnect with ***docker exec -it mycondor_condor_1 /bin/bash*** command; to stop the container (you actually can have it running forever) give de command ***docker-compose down***; all the files are shared via the local foleder ***mycondor/submituser*** also if you are not connected to the container; if you can't access the queues try first to refresh the token via ***gettoken*** command

file tranfer: https://htcondor.readthedocs.io/en/latest/users-manual/file-transfer.html

  
