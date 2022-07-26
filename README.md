# Blog - Improve web application's availability with hybrid failover using CloudFront and Route 53

## Introduction

Companies who architect their applications for high availability introduce redundancy in their origin infrastructure. For example, they deploy redundant origins that can be hosted in two different AWS regions. Very often, they use Amazon CloudFront as an entry point to their application to route traffic to healthy origins. To implement failover mechanisms with CloudFront, developers can either use Route 53’s Failover routing policy (https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/routing-policy.html#routing-policy-failover) or CloudFront’s native Origin Failover (https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/high_availability_origin_failover.html)feature. Both options offer different characteristics in terms of time to failover and added latency. 
With the provided CDK code, you will be able to experiment and learn about each option and how to combine both of them in a hybrid approach to further enhance the availability of your web applications.

## Solution's objectives

The objective of this code, is to allow you to quickly test the benefits of using a hybrid failover solution using Cloudfront Origin Failover and Route53.

The solution will achieve the following:
* Create an API Endpoint using AWS API Gateway and Lambda on both Primary and Backup Regions (with custom domain name + certificate)
* Create a Route53 healthcheck for both API Endpoints
* Create a Route53 DNS entry, with an Alias for both Primary and Secondary API Endpoint
* Create two (02) Cloudfront Distributions with the following setup:
  * Setup 1: Configured with Route53 failover dns record as Origin
  * Setup 2: Configured with Origin failover group. Route 53 failover dns record as primary and secondary API gateway as a fallback.
* Export both Cloudfront distrbutions' domain names to allow you to test both solutions.


## Architecture

![image](https://user-images.githubusercontent.com/46141598/179996740-af1d97c7-52af-48cd-9bea-bcd155d5a3c2.png)

## Solution Requirements
* Required privileges to create AWS resources in two different regions
* Public domain hosted on Amazon Route53
* Node.JS installed (as AWS CDK uses Node.js). Visit https://nodejs.org/ to install.
* AWS CDK Toolkit installed `npm install -g aws-cdk`

## Deploy the solution

Deploy this stack to your Primary and Fallback Region:
* `git clone https://github.com/csahraoui/cloudfront-combined-failover.git`
* `cd cloudfront-combined-failover`
* `./deploy.sh AWS_REGION AWS_BACKUP_REGION DOMAIN_NAME HOSTED_ZONE_ID`

Required Arguments:
* AWS_REGION: Allow you to specify your Primary Region
* AWS_BACKUP_REGION: Allow you to specify your Fallback Region
* DOMAIN_NAME: This stack will require you to have a public domain name hosted on Amazon Route53. Provide your domain name
* HOSTED_ZONE_ID: This stack will require you to have a public domain name hosted on Amazon Route53. Provide your Hosted Zone ID

Deployment example
* `./deploy.sh eu-west-1 us-east-1 mydomain.com Z0XXXXXXXXXXXX`

At the end of the deployment, you can find an export of the FQDN of 2 Cloudfront distributions:
* Setup 1: Cloudfront Distribution with Route53 failover DNS record as origin
* * Export Name = R53FailoverDistribDomain
* Setup 2: Cloudfront Distribution with Combined Route53 Failover with Cloudfront Origin Failover 
* * Export Name = CombinedFailoverDistribDomain

Outputs:
 `CdkRegionStack.CombinedFailoverDistribDomain = https://XXXXXXX.cloudfront.net/prod`
 `CdkRegionStack.R53FailoverDistribDomain = https://YYYYYYYY.cloudfront.net/prod`

## Testing
In order to test both failover solutions, you could use the following bash script. You will need to provide the previously exported Cloudfront Distribution URL 

`./test.sh https://xxxxxxxx.cloudfront.net/prod`

## Clean Up
To destroy the stack from your Primary and Fallback Region:
* `./destroy.sh AWS_REGION AWS_BACKUP_REGION DOMAIN_NAME HOSTED_ZONE_ID`

Destroy example
* `./destroy.sh eu-west-1 us-east-1 mydomain.com Z0XXXXXXXXXXXX`
