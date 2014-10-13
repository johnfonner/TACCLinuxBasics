Job Submission and Management
=============================
---

#### Objectives  
*	Learn what information the scheduler needs to run a job
*	Submit a job on Lonestar
*	Follow your job through the execution stages
*	Examine the output

---

For this session, we will look at submitting jobs on Lonestar, which uses the SGE scheduler.  Other TACC systems, like Stampede, use the SLURM scheduler, which has a different syntax, but the concepts are the same.  The TACC user guides always have information on interacting with the scheduler, and they are available here:

Lonestar: [https://www.tacc.utexas.edu/user-services/user-guides/lonestar-user-guide#running](https://www.tacc.utexas.edu/user-services/user-guides/lonestar-user-guide#running)   
Stampede: [https://www.tacc.utexas.edu/user-services/user-guides/stampede-user-guide#running](https://www.tacc.utexas.edu/user-services/user-guides/stampede-user-guide#running)  
Maverick: [https://www.tacc.utexas.edu/user-services/user-guides/maverick-user-guide#running](https://www.tacc.utexas.edu/user-services/user-guides/maverick-user-guide#running)  

### Using a Shared Computing Cluster

When you login to TACC, you arrive at a "login node" that is shared by many users.  If you try running resource intensive software on a login node, you will be very disappointed.  It will run slowly, since other users are also using the node, you will make the node less responsive to other users, and if you don't stop the software quickly, the system administrator will shut it down for you and disable your account.  Instead, software should run on dedicated "compute nodes" that you can reserve by interacting with the scheduler.  The goal is always to be a responsible user that respects other users while also getting all the computing resources you need to be productive.  Lets start by looking at the queue:

```
$ showq -l
ACTIVE JOBS--------------------------
JOBID     JOBNAME    USERNAME      STATE   CORE  HOST  QUEUE        ACCOUNT              REMAINING  STARTTIME
=============================================================================================================
...
WAITING JOBS WITH JOB DEPENDENCIES---
...
UNSCHEDULED JOBS---------------------
...
Total jobs: 205   Active Jobs: 168   Waiting Jobs: 35    Dep/Unsched Jobs: 2
```

The ```showq``` command will give you quite a bit of information about all the jobs currently running on the compute nodes of the system.  In this case, we used the ```-l``` flag to get the "long" format, but normally you won't use that.  Let's look at the information this shows us:  

*	JOBID - a sequential number assigned to every job
*	JOBNAME - a name provided by the user for convenience
*	USERNAME - the name of the user that launched the job
*	STATE - tells if the job is currently running, waiting, waiting because of a dependency, or unscheduled.  Jobs shown as unscheduled are usually finished, and the system is just cleaning up the node.
*	CORE - the number of physical CPU cores reserved for the job.  It is up to the user and the software to use those CPU cores efficiently
*	HOST - how many "hosts" or "nodes" are being used by this job
*	QUEUE - What queues do you see in the list?  Each queue uses a different pool of nodes, which may have different hardware specifications.  For example, the "largemem" queue has nodes with 1,000 GB of memory
*	ACCOUNT - every job is "charged" to an account.  Your accounts are listed when you login.
*	REMAINING - the maximum amount of time the job has to complete.  For waiting jobs, this field is:
*	WCLIMIT - this is the amount of wall clock time requested by the user.  If a job is still running after this much time, it is killed, the node is cleaned up, and it is ready for another job. 
*	STARTTIME - when the job started running.  For waiting jobs, this field instead shows the QUEUETIME, when the job was submitted to the queue.

A lot of this information was supplied by the user to the scheduler.  We'll see how to do this in the next section.

### Creating a Job Submission Script

It's usually easiest to start with a template when creating a job submission script.  TACC keeps some examples under the /share/doc/ directory, and there are also examples in the user guides (links at the start of this document).  Here is an example for Lonestar:

```
#!/bin/bash
#$ -V
#$ -cwd
#$ -pe 1way 12
#$ -N my_job_name          # change this to whatever name you want (but no spaces!)
#$ -o output.$JOB_ID       # name of the "stdout" output file
#$ -e error.$JOB_ID        # name of the "stderr" output file
#$ -q normal               # "normal" for production jobs. "development" for test jobs
#$ -A <YourAllocationHere> # allocation name. Not required if you only have one allocation.
#$ -l h_rt=24:00:00        # max runtime.  24:00:00 = 24 hours. you can't run longer than 48 hours.
##$ -M <YourEmail>          # email address (optional; take out the extra "#" to use this feature)
##$ -m e                    # email at end of job ("-m be" would email at the beginning as well)

# make sure we have the modules loaded that we expect:
module list

# run commands here:
myHost=$(hostname)
echo "This job ran on host $myHost at $(date)"
time sleep 120
echo "Job finished at $(date)"
```

Copy the text into your your own job submission script on Lonestar and edit it using your favorite text editor.  There are multiple ways to do this, depending on your preferences.  For the example, we'll show how to do it in the ```nano``` editor.

```
$ nano job_script.sge
```

That command will open nano.  You should be able to copy and paste the text from this example now.  You can move around with the arrow keys to make edits.  When you're ready to save, Ctrl+X (shown as ^X in the menu) will close the window, and nano will ask you if you want to save.

### Checking Job Status

Time to see if your job ran.

```
$ showq -u
```

We used the "-u" argument to only show your jobs (rather than the long list from before).  You can press the up arrow to go to your last command.  In this case, it makes it easy to repeat the ```showq -u``` command to check on your job.  After a couple of minutes, you should see it move to the running state.  Then it will go to "unscheduled" for a few seconds.  Then the jobs will disappear.  Of course, if you used the email option, you can also just wait for the email.

### Examining the Output

Linux command line software will usually write to files and/or print to the screen. When you run a command on a compute node in "batch" mode, writing to files works like normal.  All the nodes can see your $HOME, $WORK, and $SCRATCH filesystems.  But what about data printed to the screen?

It is captured in the output files you specified.  If you followed the template, you'll end up with something similar to output.12345 and error.12345.  In this case, error messages that would have been printed to the screen go to the error.* file.  Normal output was redirected to output.*. What information is there other than the output from your commands?

## Challenges  
*	How would you join the "stdout" and "stderr" files into one? (Hint: you can do this in the #$ section of your job submission script)
*	Submit a job to a different queue.
*	Do all the queues have the same wall clock time limits?  What queue has the shortest runtime limit?  Why? 
*	Do all the queues have the same CPU core limits?  What queue lets you use the most cores?  Why?