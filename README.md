# Simple Adversary Defense Script (SAD Script)

Defend your Linux machine from a simple adversary who has taken down defenses and established persistence!

## About The Project 

SAD Script was developed to emulate common misconfigurations utilized by cyber defense competitions. SAD Script is written in BASH and is simple to understand and fast to run. 


## Getting Started 

SAD Script is easy!

### Prerequisites

SAD Script has only been tested on Ubuntu 22.x.x but should work on systems based on systemd that have the following:
- APT Package Manager
- User must have all sudo perms 
- python3

It is recommended to run SAD Script on an Ubuntu Desktop 22.x.x Virtual Machine. Remember to take a snapshot BEFORE running SAD Script as your VM will be abused. 


### Installation 

Clone the repo into any directory you'd like. 
```
git clone https://github.com/Jacob-Ham/SADScript.git
```

Enter the directory
```
cd SADScript
```
## Usage 

Using SAD Script is as simple as executing the bash script with sudo. 

```
sudo bash SADScript.sh
```

Now just wait, SAD Script is abusing your system and installing required packages. This usually takes about 1 minute but can take longer depending on your system and internet speed.

## What does SAD Script Cover? 


-  Creates Environment:
	  - Installs cowsay
	  - Installs sshpass
	  - Installs openssh-server
	  - Installs sl
	  - Installs cmatrix
	  - Installs gc
-  Change the Users .bashrc aliases to:
	- alias ls="sl -a"
	- alias cd="cowsay You may not cd"
	- alias cat="echo meow"
	- alias nano="echo nanope"
	- alias su="echo Super User Dont"
	- alias sudo="cmatrix"
	- Teaching absolute paths and terminal resets
- Spawn fake systemd services 
	- Creates directory /root/.script/
	- Creates directory /root/.util/
	- Creates two scripts for the services to run (script.sh, net.sh)
	- script.sh just echo text
	- net.sh creates new hacker users, gives them bash shell, and adds them to sudoers every 5 min
	- Creates evilservice.service and sysnet.service in /etc/systemd/system/
	- evilservice.service - Easy to find using systemctl 
	- sysnet.service - More difficult to find using systemctl
-  Creates 69 random users with /bin/sh shells and random passwords 
	- Should teach bash oneliner to disable accounts or change login shells
- Changes SSH Config 
	- Disables StrictHostKeyChecking 
	- Enables root login in sshd_config
- Creates a user spawn script 
	- Located in /root/.script/spawn.sh 
	- Creates 4 new users every time it is ran. 
- Makes root Cronjob 
	- Cronjob will run every minute 
	- Calls /root/.script/spawn.sh to spawn users. 
- Creates one root level account with /bin/bash shell
	- This user is logged into to an ssh shell every 10 seconds if kicked out 
	- Used to teach checking logged in users and disabling accounts. 
- Creates a python web server on port 80
	- Web server exposes files on system. 

### Features coming soon 
- Disable more SSH configs: key auth
- Create another service that re-runs the SAD Script at an interval and reintroduce vulns. Establishes attackers persistance. 
- Have the emulated "hacker" run commands and steal data. 
- Modify executables 
- Create SETUID binary in /opt/scripts
- Installs and enables UFW
	- Allows all incoming and outgoing to the default rules
