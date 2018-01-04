# AWS
## Repository for scripts reference of environment cloud AWS

## Requirements
You need install AWS-CLI and configuration.

### AWS alert email aws-ec2-alert-stop.sh
This script send email for email registered in variable 'EMAILS' for example (EMAILS="your_email@domain.com, your_email2@domain.com" with custom message

### AWS Stop instances aws-ec2-stop.sh
This script stop all instances if not have Key="NoShutdown" and Value="Noshutdown"
