# gitpod-workspace

This is a workspace template for general AWS CDK development in Gitpod.

Click this button below to open a fresh new CDK development workspace in Gitpod

[![Open in Gitpod](https://img.shields.io/badge/Gitpod-ready--to--code-blue?logo=gitpod)](https://gitpod.io/#https://github.com/pahud/gitpod-workspace)

public dockder image for this codespace:

`public.ecr.aws/pahudnet/gitpod-workspace:latest`

# `awscdk.run` support

Need anything else? Hit the button to install any public CDK app from github with `awscdk.run`.

[![awscdk-run](https://img.shields.io/badge/Deploy%20with-AWSCDK.RUN-blue)](https://awscdk.run)




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
aws configure sso --profile default
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

## Configure `credential_process` for the `default` profile

```sh
aws configure set credential_process ${GITPOD_REPO_ROOT}/utils/aws-sso-credential-process
```

AWS CLI requires the `~/.aws/credentials` file so we simple touch an empty one to get rid of the warning.

```sh
touch ~/.aws/credentials && chmod 600 $_
```

## Start your CDK development

You should be able to run the CDK CLI now.

```sh
$ cdk diff
$ cdk deploy
$ cdk destroy
```
