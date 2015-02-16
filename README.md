# CICD_vagrant
Virtuella maskiner för våra CI/CD-kompetensdagar.

Det kommer att finnas tre maskiner:

- CI/CD maskin (192.168.33.10) med
 - Jenkins
 - Nexus
 - Artifactory
 - Git-server
 - Maven
 
- TEST

- PROD

## Jenkins:
 http://192.168.33.10:8080/

## Nexus:
 http://192.168.33.10:8081/nexus
 
 user: admin
 password: admin123
 
## Artifactory:
 http://192.168.33.10:8082/artifactory
 
 user: admin
 password: password

## Git:
ssh-add keys/id_rsa
 
git clone git@192.168.33.10:cicd_repo.git