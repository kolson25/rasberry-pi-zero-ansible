# Ansible: Raspberry Pi Zero Provisioner
An Ansible provisioner for Raspberry Pi Zeros



## 1. Install Ansible
More Details: http://docs.ansible.com/ansible/latest/intro_installation.html#latest-releases-via-pip
1. `sudo easy_install pip`
2. `sudo pip install ansible`


## 2. Setup User Variables
In the `vars/user.yml` file you can copy and overwrite any variables listed in the `vars/main.yml` file.  Most importantly, double check that the ssh key path and wifi connection details are correct for your setup.  See all recommended variables below:

Variable | Default | Description
------------ | ------------- | -------------
user | Content from cell 1 | Content from cell 2
ssh_directory | `/home/pi/.ssh` | The directory the install will create to store your authorized_key
nvm_version | `0.33.2` | Version of node version manager
node_version | `node` | Node version.  NVM aliases like `node` or `stable` are also accepted.
ssh_key_path | `~/.ssh/id_rsa.pub` | The path on your LOCAL machine where your public ssh key can be found.  This will be copied to the pi as an authorized_key
dont_show_wifi_connections | `True` | Determines if wifi details will be logged to console during setup 
wifi | `{ ssid: 'testaddress', password: 'testpass' }` | An array of ssid and password combinations.  Find available ssid using `sudo iwlist wlan0 scan | grep ESSID`.  Each connection should be added on its own line (see example below).
apt_packages | `git & vim ` | apt-get packages you would like installed.  Each package should be added on its own line (see example below).
  
  
### Overwrite Example
In var/user.yml
```
node_version: 8.2.0

wifi:
  - { ssid: 'myactualssid', password: 'mywifipassword' }
  - { ssid: 'anotherwifissid', password: 'anotherpassword' }
  
apt_packages
  - git
  - vim
```



## 3. Run the Setup
`cd` into repository and run `make` to run the initial install.  You will be prompted to enter your ssh password.  By default, this should be `raspberry`.  If you already have an ssh key setup or are running a subsequent time, use `make setup`.  Other make commands and manual ansible commands if that's how you roll:


Ansible Command | Make Command | Use
------------ | ------------- | -------------
`ansible-playbook setup.yml --ask-pass` | `make` or `make all` | Runs the full playbook.  Should be used on the initial setup.  For subsequent runs, use `make setup` so that you aren't prompted for a password.
`ansible-playbook setup.yml` | `make setup` | Runs the full install, but does not require a manual ssh password.  Will error if run initially.
`ansible-playbook setup.yml --tags=wifi` | `make wifi` | Runs only the wifi section of the playbook.  Great for quickly adding one or more wifi connections.
