all:	
	ansible-playbook setup.yml --ask-pass

setup:
	ansible-playbook setup.yml

first-run: all