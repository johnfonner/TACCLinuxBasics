Customizing the Linux Environment
=================================
---

#### Objectives  
*	Learn how startup scripts work
*	Find your startup scripts and see what is in them
*	Learn to create aliases, add environment variables, and customize the command prompt

---

At this point you should know some of the basics of working on the command line.  As you get into a rhythm of working in Linux, you will find that some frequently used commands would be better if they were customized somehow.  For example, if you type ```pwd``` a lot, maybe it would be better to just have your directory name as part of your command prompt.  Or perhaps the software you use requires you to set an environment variable.  Whatever the case, Linux has a lot of built in features for customizing your interactions with the system.

Every time you login to a system, Linux executes a set of "startup scripts" before displaying a command prompt.  Which startup scripts are executed depend on the shell you are using (e.g bash, tcsh, zsh) and the method used to login (e.g.interactive vs. non-interactive sessions).  Startup behavior can actually get a little complicated for the edge cases.  We will look specifically at the ```bash``` shell, which is the default at TACC, and go from there.

For ```bash``` users, there are two startup scripts that are important named ```.bashrc``` and ```.profile```. They are both located in your home directory, if they are present, but just typing ```ls``` won't list them.  In Linux, files starting with a "." are hidden unless you really want to see "all" files using ```ls -a```.

