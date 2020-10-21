# gitpod-workspace

This is a workspace template for general AWS CDK development in Gitpod.

Click this button below to open a fresh new CDK development workspace in Gitpod

[![Open in Gitpod](https://camo.githubusercontent.com/1eb1ddfea6092593649f0117f7262ffa8fbd3017/68747470733a2f2f676974706f642e696f2f627574746f6e2f6f70656e2d696e2d676974706f642e737667)](https://gitpod.io/#https://github.com/pahud/gitpod-workspace)


## Create AWS CDK App

```bash
npx projen new awscdk-app-ts
```

## Create AWS CDK Construct Lib

```bash
npx projen new awscdk-construct
```

## Configure AWS CLI V2 with AWS SSO

```bash
aws configure sso
```

The following example generate the SSO profile with `default` as the profile name:

```
$ aws configure sso --profile default
SSO start URL [None]: https://pahud-sso.awsapps.com/start                                                                                                                               
SSO Region [None]: us-east-1                                                                                                                                                            
Attempting to automatically open the SSO authorization page in your default browser.
If the browser does not open or you wish to use a different device to authorize this request, open the following URL:

https://device.sso.us-east-1.amazonaws.com/

Then enter the code:

DJHN-QKRK
The only AWS account available to you is: 123456789012
Using the account ID 123456789012
The only role available to you is: AdministratorAccess
Using the role name "AdministratorAccess"
CLI default client Region [None]: ap-northeast-1                                                                     
CLI default output format [None]:                                                                                    

To use this profile, specify the profile name using --profile, as shown:

aws s3 ls --profile default        
```

## Request temporary credentials and update ~/.aws/credentials

```sh
$ bash utils/refresh_credentials.sh 
=> requesting temporary credentials
=> updating ~/.aws/credentials as profile default
[OK] done
```
If you have different SSO profile name, run it with `AWS_PROFILE`:

```sh
$ AWS_PROFILE=<OTHER_PROFILE_NAME> bash utils/refresh_credentials.sh 
```

## Start your CDK development

You should be able to run the CDK CLI now.

```sh
$ cdk diff
$ cdk deploy
$ cdk destroy
```