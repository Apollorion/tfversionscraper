# tfversionscraper
Scrapes terraform versions and builds an API for linking them.

# Requirements
docker
ansible
terraform
aws account

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

run launcher.yml `ansible-playbook launcher.yml`