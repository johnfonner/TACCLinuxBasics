Using Software Modules
----------------------

---

#### Objectives
*	Find software through the module system
*	Load and unload modules
*	Load different versions of the same package
*	Understand prerequisites
*	Save new default modules

---

TACC maintains hundreds of software packages on its systems.  If all the software were loaded at the same time, it would not only bloat the environment, but you would run into problems with dependencies and versioning requirements.  Do you need python 2.7 or python 3?  What MPI libraries or compiler does your code need?  To avoid all these problems, TACC uses a module system (lmod) to only load the software that you want, while still maintaining access to all available software packages.  If you have already ssh'ed into a TACC system, let's explore the way modules work.

### Finding modules

```
$ module list
Currently Loaded Modules:
  1) TACC          3) Linux      5) cluster-paths    7) mvapich2/1.6    9) tar/1.22
  2) TACC-paths    4) cluster    6) intel/11.1       8) gzip/1.3.12
```

The ```module``` commands on TACC systems all start with the word "module" and have at least one more argument after that tells what you want to do.  If you used git from the command line previously, this may remind you of how ```git clone``` and other such commands behave.  

Typing ```module list``` lets us see what modules are currently loaded.  By default, a number of helpful modules are already loaded that provide core capabilities for interacting with the cluster.  What other modules can we load?

```
$ module avail
```

Get ready for lots of modules.  Notice that the modules in this list are arranged in a heirarchy.  We'll come back to that, but for now, lets look at a better way to search.  There are actually two good ways.

```
$ module spider bedtools

$ module key bedtools
```

If we know what module we are looking for, it is easiest just to search for it using a ```module spider``` or ```module key``` commands.  Spider gives you more information about the module and the prerequisites.  Keyword (or "key" for short) only has a compact description, which is better if you have a long list of modules.  Try this:

```
$ module spider genomics

$ module key genomics
```

In addition to searching the names of software packages, the "keyword" command lives up to its name by searching other description and keyword text that go along with the module.  Its not Google, but this is one potential way to discover packages related to your field.

Enough searching.  Let's load some packages.

### Managing Loaded Modules

```
$ module spider python
$ module load python
$ module list
```

When multiple versions of a package exist, one of them is registered as the default.  If you don't specify the version, the default is automatically loaded.  As TACC updates software, they also update the default modules to be the newer, but stable, versions.  If you need a specific version, be sure to specify it.  For example:

```
$ module load python/2.7.1
$ module list
```

What about modules with prerequisites?

```
$ module load bedtools
```

Bedtools requires a different compiler to be loaded so that it has access to the right libraries.  By default, the "intel" compiler is loaded, but we need to swap over to "gcc".  The normal approach doesn't work here:

```
$ module load gcc

Lmod Error: You can only have one compiler module loaded at time.
You already have intel loaded.
To correct the situation, please enter the following command:

  module swap intel gcc/4.4.5

Please submit a consulting ticket if you require additional assistance.
```

The module system is saving us from having two compilers loaded at the same time.  In this case, we can either:

```
$ module unload intel
$ module load gcc
```

or, to be a little more concise:

```
$ module swap intel gcc
```

Now that the prerequisites are met, you can now ```module load bedtools```

If things ever get messed up, and you just want to get back to the global system default, you can use:

```
$ module restore system
```

### Customizing the Default

One module I use all the time is ```git```  You may be tempted to put module commands in your startup scripts, but that can cause problems if it is not done correctly.  A save way to change your defaults is to use the ```module save``` command.  Let's try this for git.  First, make sure you have the default set loaded, then lets load git.

```
$ module restore
$ module load git
```

Now, to save it as the default, we do this:

```
$ module save
```

Next time you login to the system, these modules will be loaded.

## Challenges


*	What happens if you type ```module``` without any other arguments?
*	Try using the "ml" shorthand command.  Does it work like "module list" or "module load"?
*	Load the module ```trinityrnaseq``` and discover its dependencies
