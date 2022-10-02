# AMI provisioning using wordpress packer - AWS

![Badge](https://img.shields.io/badge/packer-1.5.1-green)
![Badge](https://img.shields.io/badge/ansible-2.9.6-green)

## Dependencies
Used to access AWS

## Objetive

Provide ami aws with wordpress installed

ansible localhost -m setup | grep ansible_distribution_major_version
fuser -k  80/tcp

## Configuration 

Set your variables as well as the profile used to access AWS and region
```
{
  "variables": {
   "profile" : "customprofile",
   "region" : "region",
   "source_ami" : "ami-02e98f78",
   "instance_type" : "t3.micro", 
   "ssh_username" : "centos"
  },
```

## Comands
```
## Checks the json template
packer inspect instace_centos.json
## Run the build
packer build instace_centos.json
```
## License

GPLv3