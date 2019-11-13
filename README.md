# tfversionscraper
Scrapes terraform versions and builds an API for linking them.

# Requirements
- docker
- ansible
- terraform
- aws account

# Install
Edit launcher.yml vars, to be unique to you:

```yaml
  vars:
    aws_config:
      region: "us-east-2"
      profile: "default"
    terraform:
      state: "present"
      backend_config:
        bucket: "apollorion-tfstates"
        key: "tfversionscraper.tfstate"
      vars:
        dump_bucket_name: "tfversionscraper"
```
Under `vars.terraform.vars` there is an optional variable `docs_base_url`.  
If this variable is included, it will replace S3 URLS in the publicly available documentation.
If included, it should have a protocol (http, https) as well as end with a forward slash ("/"). 
If excluded, it will generate the URL from the S3 website.
  
run launcher.yml `ansible-playbook launcher.yml`

# What Happens

NOTE: The API WILL NOT be functional until at least one invocation of the lambda function has occurred. After running the launcher playbook, you will either need to manually trigger the lambda function the first time via the AWS Console, or wait ~24 hours for the Cloudwatch event to automatically run the function the first time. 

When launcher.yml is ran successfully, a number of things will happen.

1. Utilizing docker, it will build the lambda function payload.
2. Utilizing terraform, it will create:
      - Lambda function
      - S3 bucket
      - Policies Needed
      - Cloudwatch Event (runs lambda function once daily)
3. Once the lambda function runs the first time (either wait, or run it manually with any parameters) it will build all the required json files for the API.


# API usage

After running the playbook, documentation will be available at:  
`http://<BUCKET>.s3-website.<REGION>.amazonaws.com/`
