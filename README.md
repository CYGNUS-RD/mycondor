# CYGNO Condor Queue

Submit jobs on CYGNO condor INFN Cloud queue

there are two way to submit job under the experiment queue:
1) acccess to cloud https://notebook.cygno.cloud.infn.it:8888/ open a terminal and follow the istruction to [submit a job](https://github.com/CYGNUS-RD/mycondor/#submit-a-job)
3) download and install Docker for your platform [https://docs.docker.com/get-docker/](https://docs.docker.com/get-docker/) and use Cygno Condor Container from your PC or server, etc.

### Cygno Condor from Cloud terinal 
to config once forever your condor eviroment open a terminal and:

      cd private
      wget https://raw.githubusercontent.com/CYGNUS-RD/mycondor/main/conf/condor_config.local; cp ./condor_config.local /etc/condor/
      wget https://raw.githubusercontent.com/CYGNUS-RD/mycondor/main/conf/gettoken; chmod +x gettoken 

### Cygno Condor Container
download Cygno Condor Container configuration 

      git clone https://github.com/CYGNUS-RD/mycondor.git
      cd mycondor/

in the directory ***private*** you will find example and there you have to copy/move your code to be submitted. The folder is shared with running container and continuosly updated

run Cygno Condor Container (first time it take some time to download the container image)

      docker-compose up -d
      
when up, connect via shell to the Cygno Condor Container 

      docker exec -it <image name> /bin/bash
     
<image name>  is tipicaly *mycondor-condor-1* or *mycondor_condor_1* depending your system. you can always get the name of the immage by the command **docker ps**:
                                                                                                   
       mycondor mazzitel$ docker ps
       CONTAINER ID   IMAGE                 COMMAND                  CREATED       STATUS       PORTS      NAMES
       d872b92ee256   dodasts/mini-htc:v0   "/bin/sh -c '/start_…"   4 hours ago   Up 4 hours   9618/tcp   mycondor-condor-1 
    
### Submit a job 

bought through the *cloud terminal* or in the *container shell*, firstly you have to get the INFN token giving the command **gettoken** to the prompt

      [root@5045c42ec547 /]# gettoken

follow the istrctions and press enter to any question (do not enter any password), check if all is right e.g. monotoring the condor queue status

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
* file IO [https://codimd.infn.it/s/pbisNdDlN](https://codimd.infn.it/s/pbisNdDlN)

***Tip on containers***: you can exit when you like from the contaner and reconnect with ***docker exec -it mycondor_condor_1 /bin/bash*** command; to stop the container (you actually can have it running forever) give de command ***docker-compose down***; all the files are shared via the local foleder ***mycondor/submituser*** also if you are not connected to the container; if you can't access the queues try first to refresh the token via ***gettoken*** command


  
