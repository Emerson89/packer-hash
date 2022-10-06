# Provisioning ec2 aws instantiation using gitlab-ci

## Objective

Provision ec2 via pipeline with custom ami installed wordpress using terraform, packer and ansible

## Dependencies
 - ansible-2.10.8
 - packer-1.8.3
 - terraform-1.2.9

## How about a CI
Used gitlab-runner in shell

For best practices use backend s3 to store the tf.state required to create a backet s3

## Terraform backend s3

Create a s3 to store tfstate

```hcl
   backend "s3" {
    bucket  = "s3-tfstates-terraform"
    key     = "terraform-ec2.tfstate"
    region  = "us-east-1"
    profile = "local"
  }
```
Variables gitlab-ci

- AWS_ACCESS_KEY <-- used mask
- AWS_SECRET_KEY <-- used mask
- AWS_SOURCE_AMI
- AWS_DEFAULT_REGION <-- create a default
- SSH_USERNAME (centos/rocky)

To use gitlab-ci use the example **.gitlab-ci.yml**

Create environments *prd* and *dev* to segment environments across regions

<img src="https://i.imgur.com/FjSEqq8.png"
     alt="Markdown Monster icon"
     style="float: left; margin-right: 10px;" />

## Ansible Wordpress 

# Supports SOs
- centos 7
- rocky 8

# Example playbook

```
- name: Applying installation and dependency 
  hosts: all
  vars:
    wp_mysql_db: MyWP
    wp_mysql_user: wpUser
    wp_mysql_password: worddb
  become: yes 
   
  roles:
     - server
```
## Variables
| Name | Description | Default | 
|------|-----------|---------|
| wp_mysql_db | Name database | MyWP|
| wp_mysql_user | Name User database | wpUser | 
| wp_mysql_password | password database | worddb

For local ansible test can be used vagrant

## Terraform

For local terraform test can be used the localstack

## Packer

To test local the packer must add the credentials as environment variable
- AWS_ACCESS_KEY
- AWS_SECRET_KEY 
- AWS_SOURCE_AMI 
- SSH_USERNAME(centos/rocky)
- AWS_DEFAULT_REGION

```
## Checks the json template
packer validate ami_aws.pkr.hcl
## Run the build
packer build ami_aws.pkr.hcl
```
## Inputs terraform

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| data ami | AMI ID used to provision the instance | `any` | `"packer-*"` | no |
| key\_name | Key Pair name to use for the instance | `string` | `"key-pem"` | no |
| region | Region where the instance will be provided | `string` | `"us-east-1"` | no |
| profile | aws user profile | `string` | `"local"` | no |
| name | instance name | `any` | `ec2 by terraform` | no |
| associate_public_ip_address | associar ip public | `bool`| `"true"`| no |
| eip | associar ip elastic | `bool`| `"false"`| no |
| ingress | ingress rules security group | `map` | `{}` | yes |
| egress | egress rules security group | `map` | `{ "engress_rule" = { "from_port" = "0" "to_port" = "0" "protocol" = "-1" "cidr_blocks" = ["0.0.0.0/0"]}` | no |
| cpu\_credits | Instance CPU credits option ("unlimited" or "standard")) | `string` | `""` | no |
| availability_zone | zones availability | `string` | `null` | no
| disable_api_termination | If true, enables EC2 Instance Termination Protection | `bool` | `null` | no
| ebs_block_device | Additional EBS block devices to attach to the instance | `list` | `[]` | no
| ebs_optimized | If true, the launched EC2 instance will be EBS-optimized | `bool` | `null` | no
| ephemeral_block_device | Customize Ephemeral (also known as Instance Store) volumes on the instance | `list` | `[]` | no
| timeouts | Define maximum timeout for creating, updating, and deleting EC2 instance resources | `map` | `{}` | no
| vpc_security_group_ids | A list of security group IDs to associate with | `list` | `null` | no
| enable_volume_tags | Whether to enable volume tags (if enabled it conflicts with root_block_device tags) | `bool` | `true` | no
| volume_tags | A mapping of tags to assign to the devices created by the instance at launch time | `map` | `{}` | no
| launch_template | Specifies a Launch Template to configure the instance | `map` | `null` | no
| monitoring | If true, the launched EC2 instance will have detailed monitoring enabled | `bool` | `false` | no
| network_interface | Customize network interfaces to be attached at instance boot time | `list` | `[]` | no
| private_ip | Private IP address to associate with the instance in a VPC | `string` | `null` | no
| root_block_device | "Customize details about the root block device of the instance. See Block Devices below for details | `list` | `[]` | yes
| subnet_id | The VPC Subnet ID to launch in | `map` | `{}` | no
| user_data | The user data to provide when launching the instance | `string` | `null` | no
| user_data_base64 | Can be used instead of user_data to pass base64-encoded binary data directly | `string` | `null` | no
| sgname | Name to be used on security-group created | `string` | `sg ec2 by terraform` | no
| description | Description of security group | `string` | `Security Group managed by Terraform` | no
| vpc_id | ID of the VPC where to create security group | `string` | `""` | no
| ebs\_optimized | Controls whether the instance will be provisioned as EBS-optimized | `bool` | `false` | no |
| instance\_count | Number of instances that will be provisioned | `number` | `1` | no |
| instance\_type | Type (class) of instance | `any` | `"t3.micro"` | no |
| subnet\_id | Subnet ID where the instance will be provisioned | `string` | `""` | no |
| vpc\_id | vpc id where the instance will be provisioned | `string` | `""` | no |
| tags | Instance Tag Map | `map` | `{}` | no |

## License

GPLv3
