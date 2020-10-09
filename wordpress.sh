#!/bin/bash
########################################################################################
#Autor: Emerson																		   #
#Titulo: Script de automação para instalação            					           #	
#Data: 07/12/2019																	   #			
#																					   #	
########################################################################################
clear
echo 
echo ========================="Instalando dependências..."======================================
echo
 sudo yum install epel-release -y && sudo yum install ansible -y && sudo yum install git -y
echo
echo =========================="Clone do repositorio git..."====================================
echo
 cd /tmp
 git clone https://github.com/Emerson89/wp-centos.git
 cd wp-centos
 sudo echo -e "[wordpress]\n127.0.0.1" >> hosts
echo
echo =========================="Executando receita ansible..."==================================
echo
 sudo ansible-playbook -i hosts -c local playbook.yml
                                                                                                                                           
                                                                                                                                             
                                     
