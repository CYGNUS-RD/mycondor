# CYGNO HTCondor Queue

HOWTO submit jobs on CYGNO condor **INFN Cloud** or **TIER1@CANF** queues

you can access the experiment queues:
* via notebook https://notebook.cygno.cloud.infn.it/  
* via [docker](https://docs.docker.com/get-docker/) with this [mycondor](https://github.com/CYGNUS-RD/mycondor) docker software
* installing [HTCondor](https://htcondor.org/downloads/), cygnolib and oidc-gen ([see](https://github.com/CYGNUS-RD/cygno)) on your client computer
* via TIER1 user interface ([TIER1 queue only](https://confluence.infn.it/display/TD/9+-+Job+submission))


### Submit jobs to INFN Cloud queues or TIER1@CNAF queues via notebook (recommended)
* requirements: web browser and access to INFN cloud (see [howto](https://github.com/CYGNUS-RD/cygno/blob/main/infrastructure.md#signup-on-computing-ressources-needed-for-all-resources-cloud-lngs-lnf))
* connect to Cygno cloud interface:  https://notebook.cygno.cloud.infn.it
* open a terminal and use the command **cygno_htc** to access your prefered queue [see help](https://github.com/CYGNUS-RD/mycondor?tab=readme-ov-file#htc-command-line)
* optional, configure your [preferred queue ip](https://github.com/CYGNUS-RD/mycondor/blob/main/README.md#personaliaze-your-default-queue--infn-cloud)

### mycondor container (optional)
* Requirements: [docker](https://docs.docker.com/get-docker/) platform
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
* use **cygno_htc** command line to access TIER1/CLOUD queue
* The **/home/submituser/** folder is shared with your computer facility where the docker is running

### cygno_htc command line 

* since cygnolib **v1.0.18**, cygno_htc script to configure and monitor TIER1/cloud has been included
* since notebook **version >= v1.0.27** the cli cygno_htc has been set up to handle queue at TIER1 and on cloud
* ```cygno_htc -t``` to configure/reauthenticate the TIER1 queues (reauthentication is needed when you restart notebook/docker)
* ```cygno_htc -c``` to configure/reauthenticate @ the INFN cloud queue (reauthentication is needed when you restart the docker container,) 
* to monitor the queue ```cygno_htc -q``` (type ```cygno_htc -h``` for help)
```
v1.0.27# cygno_htc --help
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
<!-- * if the queue is lost, you can reconfigure simply by typing again ```cygno_htc -t/``` or ```cygno_htc -c``` (job are not lost)

![alt text](firstLogin.png "example of first login when creating tier1 authentication")

after authentication check the queue status by typing ```cygno_htc -q```: -->
* For example to see the jobs queued on the default CE:
```
HTCONDOR:/home/submituser> cygno_htc -q
htc@tier1


-- Schedd: ce02-htc.cr.cnaf.infn.it : <131.154.192.41:9619?... @ 10/22/24 17:34:14
OWNER    BATCH_NAME     SUBMITTED   DONE   RUN    IDLE  TOTAL JOB_IDS
cygno002 ID: 1034090  10/22 09:11      _      _      _      1 1034090.0

Total for query: 1 jobs; 1 completed, 0 removed, 0 idle, 0 running, 0 held, 0 suspended 
Total for cygno002: 1 jobs; 1 completed, 0 removed, 0 idle, 0 running, 0 held, 0 suspended 
Total for all users: 6091 jobs; 2307 completed, 0 removed, 264 idle, 3518 running, 2 held, 0 suspended
```
the resources at TIER1@CANF are accessible via 7 CE that can be specified by adding the CE number to the **cygno_htc** command line e.g. ```cygno_htc -q 5```
```
HTCONDOR:/home/submituser> cygno_htc -q 5
htc@tier1


-- Schedd: ce05-htc.cr.cnaf.infn.it : <131.154.192.54:9619?... @ 10/22/24 17:37:43
OWNER    BATCH_NAME     SUBMITTED   DONE   RUN    IDLE  TOTAL JOB_IDS
cygno005 ID: 1144807  10/22 13:59      _      _      _      1 1144807.0

Total for query: 1 jobs; 1 completed, 0 removed, 0 idle, 0 running, 0 held, 0 suspended 
Total for cygno005: 1 jobs; 1 completed, 0 removed, 0 idle, 0 running, 0 held, 0 suspended 
Total for all users: 6202 jobs; 2341 completed, 0 removed, 393 idle, 3463 running, 5 held, 0 suspended
```
see help ```cygno_htc -h``` for full command available. 

## Submit job to CNAF

To submit jobs to the CNAF queues start from the templates for reconstruction and digitization are provided in /cvmfs/sft-cygno.infn.it/config/templates/ path in Notebooks. <br />
In your private create a folder and a subfolder with the names you like. For example, Launch and Launch/Sub_folder. Copy the template files in Launch/Sub_folder/. <br />
Modify the subber.sh file (see later what is in the subberfile). Then from terminal, go to Launch folder and use ```source Sub_folder/subber.sh```. This will generate a folder in Launch/logs/newfolder with the exec and sub file, and it will automatically submit the job to the queue. Upon retrieve (```cygno_htc -f <jobID> <CEID>```) the .error .out and .log files will appear inside the logs/newfolder. A return file will also be saved in the Launch folder. It will contain the outcome of the executable program you launched in the queue (the reconstruction.py for the reconstruction example): 0=success; other number = fail. 

### Subber file content example
Taking as anexample the /cvmfs/sft-cygno.infn.it/config/templates/subber.sh file, here follows a brief description: <br />
* RUN: it is a variable which for the reco is the run number to analyze. It can be explicitly written or be a passed argument (in bash script for example as $1). **Modify as you need to** 
* BATCHNAME: variable which will be identifying your job on the queues and the .error .out .log  and the return_BATCHNAME.txt files upon retrieve. **Modify as you need to**
* CE: queue identifier. **Modify value between 1 and 6**
* IMAGE: reference image to run the program in. **Do not modify**
* CPUs: number of CPUs to request for the job. There is a limit at 32, but the whole queue works on optimization. If you ask for 32 cores you will stay in the queue longer as you will need to wait for 32 cores to be free at the same time
* EXECUTEPATH : absolute path on notebook to the folder where the executable file or program will be
* EXECUTE: path to the executable file
* ARGUMENTS : arguments required by theexecutable
* OTHERFILE: Files or folders to upload to the machine follow the commented examples if needed. The limit of upload should be 10 MB, so clean your upload.
* FILENAMES: list of the outputfiles of your code. This is a bit tricky: you need to know the name of the output files in advance. This way the outputfiles listed will be sent to the cloud automatically. You will not be able to retrieve thme with ```cygno_htc -f <jobID> <CEID>```.
* ENDPOINT_URL: where do you want to upload the output files. Now S3 is the only working. **Do not modify**
* BACKET: bucket where you want your files to be uploaded (cygno-data is forbidden)
* TAG: path inside the bucket where you want your files to be uploaded. This can be modified, but in order to keep order on the cygno-analysis disk, the From_queue/ part must be kept. Any folder generated in cygno-analysis outside From_queue will be deleted.


## On old Queues (deprecated)
### Submit a job 

**General setup:**
check if all is right e.g. monitoring the condor queue status, e.g.
```
HTCONDOR:/home/submituser> cygno_htc -q
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
Now you are up and running. On in the notebook/container move in the directory with your code. if you are using the container the **/home/submituser/** is a permanent directory to share data/code with your hosting server

to submit your code, create a **subfile** following the instructions: 

* condor@INFN [https://codimd.infn.it/s/VD3RWisM6#Submitting-a-demo-job](https://codimd.infn.it/s/VD3RWisM6#Submitting-a-demo-job)
* file IO [https://codimd.infn.it/s/pbisNdDlN](https://codimd.infn.it/s/pbisNdDlN) [esempio](https://github.com/CYGNUS-RD/cygno/blob/main/dev/presigned.py)
* in the [folder](https://github.com/CYGNUS-RD/mycondor/tree/main/submituser) there are some examples of code and submit files

file tranfer: https://htcondor.readthedocs.io/en/latest/users-manual/file-transfer.html
* use the command below to submit your job:
```
cygno_htc -s <subfile>
```
* heck the job status and retrieve the job output using the following commands:
```
cygno_htc -q (all jobs)
cygno_htc -m (my jobs)
cygno_htc -j (all CYGNO user)
```
to transfer file
```
cygno_htc -f <jobid> <ceid>
```
to remove the job
```
cygno_htc -r <jobid> <ceid>
```
more detailed info: https://confluence.infn.it/display/TD/Submission+to+the+new+cluster+HTC23

some helpful raw commands:
```
condor_submit sub_reco -spool -pool ce02-htc.cr.cnaf.infn.it:9619 -name ce02-htc.cr.cnaf.infn.it

condor_q XXXX -pool ce02-htc.cr.cnaf.infn.it:9619 -name ce02-htc.cr.cnaf.infn.it
condor_transfer_data XXXX -pool ce02-htc.cr.cnaf.infn.it:9619 -name ce02-htc.cr.cnaf.infn.it 

JOB=XXX; while true; do  condor_q ${JOB} -pool ce02-htc.cr.cnaf.infn.it:9619 -name ce02-htc.cr.cnaf.infn.it ; condor_transfer_data ${JOB} -pool ce02-htc.cr.cnaf.infn.it:9619 -name ce02-htc.cr.cnaf.infn.it; sleep 60; done
```

**CYGNO reconstruction submit example on TIER1@CANF with singularity**
* Open jupyter notebook/mycondor;
* Start your server (version >=1.0.27);
* Open the terminal on the notebook, type: ```cygno_htc -t``` and follow the instructions;
* pull reconstruction repository
* create a exec_reco.sh file inside the reconstruction folder, like the following:
```
#!/bin/bash
python3 reconstruction.py $1 -r $2 -j $3 --max-entries $4 --git $5
```
* create a ***sub_reco*** file (outside the reconstruction folder), like the following:
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
cygno_htc -s sub_reco
```

### Personalize your default queue @ INFN cloud
* check the default setup in condor file /etc/condor/condor_config.local
* if you prefer to change it with different queue ip (see below), you can set up your bash file, e.g.:
  ```
  vi /jupyter-workspace/cloud-storage/USERNAME/.bashrc
  ```
* put the following code in your bash file to set up queue 131.154.98.46 (the example is for the simulation 131.154.98.46)
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

- Queue 1 **reserved** to reco: 131.154.99.11   ( 5 Machines: 8core/16Gb RAM)
- Queue 2 public:               131.154.98.168  (10 Machines: 4core/ 8Gb RAM)
- Queue Sym and public:         131.154.98.46   ( 4 Machines: 8core/16Gb RAM)

use **cygno_htc** command to access TIER1/CLOUD queue
