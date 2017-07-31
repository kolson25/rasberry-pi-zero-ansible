all:	
	ansible-playbook setup.yml --ask-pass

setup:
	ansible-playbook setup.yml

wifi:
	ansible-playbook setup.yml --tags=wifi

first-run: all
