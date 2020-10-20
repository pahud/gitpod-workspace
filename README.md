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

For example:

```
$ aws configure sso
SSO start URL [None]: https://pahud-sso.awsapps.com/start                                                                                                                               
SSO Region [None]: us-east-1                                                                                                                                                            
Attempting to automatically open the SSO authorization page in your default browser.
If the browser does not open or you wish to use a different device to authorize this request, open the following URL:

https://device.sso.us-east-1.amazonaws.com/

Then enter the code:

XXXX-XXXX
The only AWS account available to you is: 123456789012
Using the account ID 123456789012
The only role available to you is: AdministratorAccess
Using the role name "AdministratorAccess"
CLI default client Region [None]: ap-northeast-1                                                                     
CLI default output format [None]:                                                                                                                                          
CLI profile name [AdministratorAccess-123456789012]: default          
```