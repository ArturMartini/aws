# AWS
## Repository for scripts reference of environment cloud AWS

## Requirements
AWS-CLI for instegration with AWS Cloud.
Crontab for schedule tasks.

### AWS alert email aws-ec2-alert-stop.sh
This script send email for email registered in variable 'EMAILS' for example (EMAILS="your_email@domain.com, your_email2@domain.com" with custom message

### AWS Stop instances aws-ec2-stop.sh
This script stop all instances if not have Key="NoShutdown" and Value="Noshutdown"

Example of configuration tasks in crontab
sudo crontab -e
add lines:
30 20 * * 1,2,3,4,5 /home/ec2-user/aws-scheduler/aws-ec2-alert-stop.sh >> /home/ec2-user/aws-scheduler/log/aws-ec2-alert-stop.log
0 21 * * 1,2,3,4,5 /home/ec2-user/aws-scheduler/aws-ec2-stop.sh >> /home/ec2-user/aws-scheduler/log/aws-ec2-stop.log
