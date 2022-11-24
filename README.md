# Portfolio_DataEng
The main purpose of this repository is to create a cloud services infrastructure capable of creating buckets and clusters in order to run an orchestration via Airflow. Construction will be carried out in an IaC manner. The infrastructure will be coded with terraform. All environment installation and Airflow software will be via Ansible. As the OS used was windows, it became necessary to make some adjustments through WSL.

## Some important steps:

0) If you decide to run with CI/CD is just push with main or dev and github actions will take care of everything about infraestructure.
1) Run: terraform init
2) Run: terraform plan
3) Run: terraform apply --auto-approve
4) Install at WSL: ubuntu 18 LTS
5) Do at WSL: sudo vim /etc/wsl.config and insert "[automount] opttions="metadata"
6) Certify that: WSL and sudo chmod 400 at key.pem
7) Not the finnest solution, but will avoid some trouble about known hosts: rm ~/.ssh/known_hosts
8) Run: ansible-playbook ./airflow/playbook.yml -u ubuntu  --private-key ./infrastructure/aws/secretkey/key.pem -i ./airflow/hosts.yml
9) Wait infraestructure building and Airflow deploy
10) Access Airflow by: machine-ip:8080, password: airflow, user: airflow
11) In order to finish all services: terraform destroy


### Validator:
https://codebeautify.org/yaml-validator