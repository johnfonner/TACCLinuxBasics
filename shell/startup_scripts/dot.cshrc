# -*- shell-script -*-
# TACC startup script: ~/.cshrc version 2.0  -- 10/23/2013

## START_BLOCK ##
#------------------------------------------------------------------------------
# Note: this file is managed via LosF
#
# You should, in general, not edit this file directly as you will 
# *lose* the contents during the next sync process. Instead, 
# edit the template file in your local config directory:
# 
# /admin/build/admin/config/const_files/Stampede/login/dot.cshrc
#
# Questions? karl@tacc.utexas.edu
#
#------------------------------------------------------------------------------

## END_BLOCK ##

# This file is "sourced" on EVERY shell invocation:
#      login shells
#      interactive shells
#      non-interactive shells
#
# In a parallel mpi job, this file (~/.cshrc) is sourced on every 
# node so it is important that the actions here do not tax the file
# system. Each nodes' environment during an MPI job has ENVIRONMENT 
# set to "BATCH" and the prompt variable is empty.

###################################
# Optional Startup Script tracking 
if ( $?SHELL_STARTUP_DEBUG ) then
   echo "${DBG_INDENT}~/.cshrc{"
endif

############
# SECTION 1
#
# There are three independent and safe ways to control your initial
# module setup. The list below is from the simplest to hardest.
#   a) Use "module save"  (see "module help" for details).
#   b) Place module commands in ~/.modules
#   c) Place module commands in this file inside the if block.
#
# Note that you should only do one of the above.  You do not want
# to override the inherited module environment by having module
# commands outside of the if block.[3]

if ( ! $?__CSHRC_SOURCED__ && ! $?ENVIRONMENT ) then
  setenv __CSHRC_SOURCED__ 1

  ###################################################################
  # **** PLACE MODULE COMMANDS HERE and ONLY HERE                ****
  ###################################################################

  # module load git

endif


############
# SECTION 2
#
# Please set or modify any environment variables inside the if block
# below.  For example, modifying PATH or other path like variables
# (e.g LD_LIBRARY_PATH), the guard variable (PERSONAL_PATH) prevents 
# your PATH from having duplicate directories on sub-shells.

if ( ! $?PERSONAL_PATH ) then
  setenv PERSONAL_PATH 1

  ###################################################################
  # **** PLACE Environment Variables including PATH here.        ****
  ###################################################################

  # set path=( $HOME/bin $path )

endif

#####################################################################
# **** Place any else below.                                     ****
#####################################################################

# alias m   more
# alias bls /bin/ls

##########
# Umask
#
# If you are in a group that wishes to share files you can use "umask"
# to make your files be group readable.  Placing umask here is the only
# reliable place for csh users.

# umask 022


###################################
# Optional Startup Script tracking 

if ( $?SHELL_STARTUP_DEBUG ) then
   echo "${DBG_INDENT}}"
endif
