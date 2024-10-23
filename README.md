# CYGNO HTCondor Queue

HOWTO submit jobs on CYGNO condor **INFN Cloud** or **TIER1@CANF** queues

you can access the experiment queues:
* via notebook https://notebook.cygno.cloud.infn.it/  
* via [docker](https://docs.docker.com/get-docker/) with this [mycondor](https://github.com/CYGNUS-RD/mycondor) docker software
* via TIER1 user interface ([TIER1 queue only](https://confluence.infn.it/display/TD/9+-+Job+submission))


### submit jobs to INFN Cloud queues or TIER1@CNAF queues via notebook (raccomanded)
* requirments: web browser and access to INFN cloud (see [howto](https://github.com/CYGNUS-RD/cygno/blob/main/infrastructure.md#signup-on-computing-ressources-needed-for-all-resources-cloud-lngs-lnf))
* connect to cygno cloud interface:  https://notebook.cygno.cloud.infn.it
* open a terminal and use the commanad **htc** to access your prefered queue [see help](https://github.com/CYGNUS-RD/mycondor?tab=readme-ov-file#htc-command-line)
* optional, configure your [preferd queue ip](https://github.com/CYGNUS-RD/mycondor/blob/main/README.md#personaliaze-your-default-queue-in-infn-cloud)

### mycondor container (optional)
* requirements: [docker](https://docs.docker.com/get-docker/) platform
* clone [mycondor]([mycondor](https://github.com/CYGNUS-RD/mycondor))
```
git clone https://github.com/CYGNUS-RD/mycondor.git
cd mycondor/
```
* run and access the container
```
docker-compose up -d
docker exec -ti mycondor /bin/bash
```      
* use **htc** command line to access TIER1/CLOUD queue
* the **/home/submituser/** folder is shared with your computer facility where the docker is running

### htc command line 

* since cygnolib **v1.0.18**, cygno_htc script to configure and monitor TIER1/cloud has been included
* since notebook **version >= v1.0.27** the cli htc has been set up to handle queue at TIER1 and on cloud
* ```htc -t``` to configure/reauthenticate the TIER1 queues (reautentication is needed when you restart notebook/docker)
* ```htc -c``` to configure/reauthenticate @ the INFN cloud queue (reautentication is needed when you restart the docker container,) 
* to monitor the queue ```htc -q``` (type ```htc``` for help)
```
v1.0.27# htc --help
Usage:
  -t/-c --tier1/--cloud, configure/switch between htc@tier1 and htc@cloud
  -s --submit, submit a job:  -s <subfilename> <ceid> [only for tier1 ceid=1-7 default ce02]
  -f --tranfer, tranfer files: -f <jobid> <ceid> [only for tier1 ceid=1-7 default ce02]
  -r --remove, remove jobs: -r <jobid> <ceid> [only for tier1 ceid=1-7 default ce02]
  -q --monitor, monitor jobs: -q <ceid> [only for tier1 ceid=1-7 default ce02]
  -m --myjobs, monitor my jobs (USER@mycondor): -m <ceid> [only for tier1 ceid=1-7 default ce02]
  -j --jobs, monitor all jobs: -j <ceid> [only for tier1 ceid=1-7 default ce02]
  -h --help, show this help
```
* if the queue is lost, you can reconfigure simply typing again ```htc -t/``` or ```htc -c``` (job are not lost)

![alt text](firstLogin.png "example of first login when creating tier1 authentication")

after autentication check the queue status just typing ```htc -q```:
```
HTCONDOR:/home/submituser> htc -q
htc@tier1


-- Schedd: ce02-htc.cr.cnaf.infn.it : <131.154.192.41:9619?... @ 10/22/24 17:34:14
OWNER    BATCH_NAME     SUBMITTED   DONE   RUN    IDLE  TOTAL JOB_IDS
cygno002 ID: 1034090  10/22 09:11      _      _      _      1 1034090.0

Total for query: 1 jobs; 1 completed, 0 removed, 0 idle, 0 running, 0 held, 0 suspended 
Total for cygno002: 1 jobs; 1 completed, 0 removed, 0 idle, 0 running, 0 held, 0 suspended 
Total for all users: 6091 jobs; 2307 completed, 0 removed, 264 idle, 3518 running, 2 held, 0 suspended
```
the resorce at TIER1@CANF are acessible via 7 CE that can be specified adding the CE number to the **htc** commnad line e.g. ```htc -q 5```
```
HTCONDOR:/home/submituser> htc -q 5
htc@tier1


-- Schedd: ce05-htc.cr.cnaf.infn.it : <131.154.192.54:9619?... @ 10/22/24 17:37:43
OWNER    BATCH_NAME     SUBMITTED   DONE   RUN    IDLE  TOTAL JOB_IDS
cygno005 ID: 1144807  10/22 13:59      _      _      _      1 1144807.0

Total for query: 1 jobs; 1 completed, 0 removed, 0 idle, 0 running, 0 held, 0 suspended 
Total for cygno005: 1 jobs; 1 completed, 0 removed, 0 idle, 0 running, 0 held, 0 suspended 
Total for all users: 6202 jobs; 2341 completed, 0 removed, 393 idle, 3463 running, 5 held, 0 suspended
```
see help ```htc -h``` for full command available. 

### Submit a job 

**general setup:**
check if all is right e.g. monitoring the condor queue status, e.g.
```
HTCONDOR:/home/submituser> htc -q
htc@cloud


-- Schedd: 131.154.98.46.myip.cloud.infn.it : <131.154.98.46:31618?... @ 10/22/24 16:46:39
OWNER  BATCH_NAME    SUBMITTED   DONE   RUN    IDLE   HOLD  TOTAL JOB_IDS
condor ID: 20433   10/8  11:09      _      _      _      1      1 20433.0
condor ID: 20473   10/18 14:48      _      _      _      _      1 20473.0
condor ID: 20615   10/21 17:18      _      _      _      _      1 20615.0
condor ID: 20641   10/22 14:12      _      _      _      _      1 20641.0
condor ID: 20642   10/22 14:13      _      _      _      _      1 20642.0
condor ID: 20643   10/22 14:13      _      _      _      _      1 20643.0
condor ID: 20644   10/22 14:14      _      _      _      _      1 20644.0
condor ID: 20645   10/22 14:14      _      _      _      _      1 20645.0

Total for query: 8 jobs; 7 completed, 0 removed, 0 idle, 0 running, 1 held, 0 suspended 
Total for all users: 8 jobs; 7 completed, 0 removed, 0 idle, 0 running, 1 held, 0 suspended

```
Now you are up and running. On in the notebook/container move in the direcrory with your code. if you are using the container the **/home/submituser/** is a permanent directory to share data/code  with you hosting server

to submit your code, follow the instructions below for more details: 

* condor@INFN [https://codimd.infn.it/s/VD3RWisM6#Submitting-a-demo-job](https://codimd.infn.it/s/VD3RWisM6#Submitting-a-demo-job)
* file IO [https://codimd.infn.it/s/pbisNdDlN](https://codimd.infn.it/s/pbisNdDlN) [esempio](https://github.com/CYGNUS-RD/cygno/blob/main/dev/presigned.py)
* in the [folder](https://github.com/CYGNUS-RD/mycondor/tree/main/submituser) there are some exaple of code and submit files

file tranfer: https://htcondor.readthedocs.io/en/latest/users-manual/file-transfer.html

**CYGNO reconstruction submit example on TIER1@CANF with sigularity**
* Open jupyter notebook/mycondor;
* Start your server (version >=1.0.27);
* Open the terminal on the notebook, type: ```htc -t``` and follow the instructions;
* pull reconstruction repository
* create a exec_reco.sh file inside the reconstruction folder, like the following:
```
#!/bin/bash
python3 reconstruction.py $1 -r $2 -j $3 --max-entries $4 --git $5
```
* create a ***sub_reco*** file (outside the reconstruction folder), like following:
```
+SingularityImage = "docker://gmazzitelli/cygno-wn:v1.0.25-cygno"
Requirements = HasSingularity
request_cpus = 8

executable = /home/mazzitel/reconstruction/exec_reco.sh

log    = reconstruction_77744.log
output = reconstruction_77744.out
error  = reconstruction_77744.error
should_transfer_files   = YES

transfer_input_files  = /home/mazzitel/reconstruction/index.php, /home/mazzitel/reconstruction/waveform.py, /home/mazzitel/reconstruction/ReadMe_PMT.md, /home/mazzitel/reconstruction/datasets, /home/mazzitel/reconstruction/.gitignore, /home/mazzitel/reconstruction/utilities.py, /home/mazzitel/reconstruction/cluster, /home/mazzitel/reconstruction/postprocessing, /home/mazzitel/reconstruction/submit_reco.py, /home/mazzitel/reconstruction/profiling.py, /home/mazzitel/reconstruction/energyCalibrator.py, /home/mazzitel/reconstruction/treeVars.py, /home/mazzitel/reconstruction/debug_code, /home/mazzitel/reconstruction/calibration.txt, /home/mazzitel/reconstruction/After_reco, /home/mazzitel/reconstruction/snakes.py, /home/mazzitel/reconstruction/configFile_MC.txt, /home/mazzitel/reconstruction/morphsnakes.py, /home/mazzitel/reconstruction/corrections, /home/mazzitel/reconstruction/cython_cygno.pyx, /home/mazzitel/reconstruction/cythonize.sh, /home/mazzitel/reconstruction/modules_config, /home/mazzitel/reconstruction/exec_reco.sh, /home/mazzitel/reconstruction/scripts, /home/mazzitel/reconstruction/plotter, /home/mazzitel/reconstruction/clusterTools.py, /home/mazzitel/reconstruction/pedestals, /home/mazzitel/reconstruction/reconstruction.py, /home/mazzitel/reconstruction/output.py, /home/mazzitel/reconstruction/cameraChannel.py, /home/mazzitel/reconstruction/data, /home/mazzitel/reconstruction/configFile_LNF.txt, /home/mazzitel/reconstruction/README.md, /home/mazzitel/reconstruction/configFile_MANGO.txt, /home/mazzitel/reconstruction/mva, /home/mazzitel/reconstruction/utils, /home/mazzitel/reconstruction/swiftlib.py, /home/mazzitel/reconstruction/configFile_LNGS.txt, /home/mazzitel/reconstruction/showOneImage.py, /home/mazzitel/reconstruction/rootlogon.C

transfer_output_files = reco_run77744_3D.root, reco_run77744_3D.txt

arguments             = configFile_LNGS.txt 77744 8 -1 96c209647473ef7273012cbbb2338266216c4123

+CygnoUser = "$ENV(USERNAME)"
queue
```
* and then use the command below to submit your job:
```
htc -s sub_reco
```
* You can check the job status and retrieve the job output using the following commands:
```
htc -q (all jobs)
htc -m (my jobs)
htc -j (all CYGNO user)
```
to tranfer file
```
htc -f <jobid> <ceid>
```
to remove the job
```
htc -r <jobid> <ceid>
```
more dettailed info: https://confluence.infn.it/display/TD/Submission+to+the+new+cluster+HTC23

raw commands
```
condor_submit sub_reco -spool -pool ce02-htc.cr.cnaf.infn.it:9619 -name ce02-htc.cr.cnaf.infn.it

condor_q XXXX -pool ce02-htc.cr.cnaf.infn.it:9619 -name ce02-htc.cr.cnaf.infn.it
condor_transfer_data XXXX -pool ce02-htc.cr.cnaf.infn.it:9619 -name ce02-htc.cr.cnaf.infn.it 

JOB=XXX; while true; do  condor_q ${JOB} -pool ce02-htc.cr.cnaf.infn.it:9619 -name ce02-htc.cr.cnaf.infn.it ; condor_transfer_data ${JOB} -pool ce02-htc.cr.cnaf.infn.it:9619 -name ce02-htc.cr.cnaf.infn.it; sleep 60; done
```
### personaliaze your default queue @ INFN cloud
* check the default setup in condor file /etc/condor/condor_config.local
* if you prefer to change it with differe queue ip (see below), you can setup yuor bash file, e.g.:
  ```
  vi /jupyter-workspace/cloud-storage/USERNAME/.bashrc
  ```
* put the following code in your bash file to setup queue 131.154.98.46 (the example is for the simulation 131.154.98.46)
  ```
  # config condor CYGNO queue
  cat > /etc/condor/condor_config.local << EOF 
  AUTH_SSL_CLIENT_CAFILE = /etc/pki/ca-trust/source/anchors/htcondor_ca.crt
  SCITOKENS_FILE = /tmp/token
  SEC_DEFAULT_AUTHENTICATION_METHODS = SCITOKENS
  COLLECTOR_HOST = 131.154.98.46.myip.cloud.infn.it:30618
  SCHEDD_HOST = 131.154.98.46.myip.cloud.infn.it
  EOF

  alias condor_job_detail='condor_q -all -format "-----------------------------------------\n\nClusterID: %d\n" ClusterId -format "JobStatus: %d\n" JobStatus -format "CygnoUser: %s\n\n" CygnoUser'
  
  alias condor_my_jobs='condor_q -all -format "ClusterID: %d " ClusterId -format "JobStatus: %d " JobStatus -format "CygnoUser: %s\n" CygnoUser | grep $USERNAME' 
  ```
* close and re-open your terminal, now the queues are configured forever (this is valid for any cluster configured under condor)

- Queue 1 **reserved** to reco: 131.154.98.50   ( 5 Machines: 8core/16Gb RAM)
- Queue 2 public:               131.154.98.168  (10 Machines: 4core/ 8Gb RAM)
- Queue Sym and public:         131.154.98.46   ( 4 Machines: 8core/16Gb RAM)

use **htc** command to access TIER1/CLOUD queue
