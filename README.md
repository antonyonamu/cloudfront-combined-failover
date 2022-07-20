# Blog - Improve web application's availability with hybrid failover using CloudFront and Route 53

Companies who architect their applications for high availability introduce redundancy in their origin infrastructure. For example, they deploy redundant origins that can be hosted in two different AWS regions. Very often, they use Amazon CloudFront as an entry point to their application to route traffic to healthy origins. To implement failover mechanisms with CloudFront, developers can either use Route 53’s Failover routing policy (https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/routing-policy.html#routing-policy-failover) or CloudFront’s native Origin Failover (https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/high_availability_origin_failover.html)feature. Both options offer different characteristics in terms of time to failover and added latency. In this blog post, you will learn about each option and how to combine both of them in a hybrid approach to further enhance the availability of your web applications.

## Architecture

![image](https://user-images.githubusercontent.com/46141598/179996740-af1d97c7-52af-48cd-9bea-bcd155d5a3c2.png)


## Useful commands

Deploy this stack to your Primary and Fallback Region:
* `./deploy.sh AWS_REGION AWS_BACKUP_REGION DOMAIN_NAME HOSTED_ZONE_ID`

Required Arguments:
* AWS_REGION: Allow you to specify your Primary Region
* AWS_BACKUP_REGION: Allow you to specify your Fallback Region
* DOMAIN_NAME: This stack will require you to have a public domain name hosted on Amazon Route53. Provide your domain name
* HOSTED_ZONE_ID: This stack will require you to have a public domain name hosted on Amazon Route53. Provide your Hosted Zone ID

Deployment example
* `./deploy.sh eu-west-1 us-east-1 mydomain.com Z0XXXXXXXXXXXX`

To destroy the stack from your Primary and Fallback Region:
* `./destroy.sh AWS_REGION AWS_BACKUP_REGION DOMAIN_NAME HOSTED_ZONE_ID`
Destroy example
* `./destroy.sh eu-west-1 us-east-1 mydomain.com Z0XXXXXXXXXXXX`
