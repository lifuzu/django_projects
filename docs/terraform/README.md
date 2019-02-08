# Learn terraform
https://learn.hashicorp.com/terraform/#getting-started

## Install terraform
https://www.terraform.io/downloads.html

Unzip the package, create `terraform`, move it to `/usr/local/bin`

Verifying by
```
$ terraform --help
Usage: terraform [-version] [-help] <command> [args]

The available commands for execution are listed below.
The most common, useful commands are shown first, followed by
less common or more advanced commands. If you're just getting
started with Terraform, stick with the common commands. For the
other commands, please read the help and docs before usage.

Common commands:
    apply              Builds or changes infrastructure
    console            Interactive console for Terraform interpolations
    destroy            Destroy Terraform-managed infrastructure
    env                Workspace management
    fmt                Rewrites config files to canonical format
    get                Download and install modules for the configuration
    graph              Create a visual graph of Terraform resources
    import             Import existing infrastructure into Terraform
    init               Initialize a Terraform working directory
    output             Read an output from a state file
    plan               Generate and show an execution plan
    providers          Prints a tree of the providers used in the configuration
    push               Upload this Terraform module to Atlas to run
    refresh            Update local state file against real resources
    show               Inspect Terraform state or plan
    taint              Manually mark a resource for recreation
    untaint            Manually unmark a resource as tainted
    validate           Validates the Terraform files
    version            Prints the Terraform version
    workspace          Workspace management

All other commands:
    debug              Debug output management (experimental)
    force-unlock       Manually unlock the terraform state
    state              Advanced state management
```
## Build Infrastructure

1. Create AWS config and credentials at `~/.aws/{config, credentials}`

2. Create `example.tf` under `tools/provision/terraform` as following:
```
provider "aws" {
  access_key = ""
  secret_key = ""
  region     = "us-west-1"
}

resource "aws_instance" "example" {
  ami           = "ami-063aa838bd7631e0b"
  instance_type = "t2.micro"
}
```
3. Enter the path `tools/provision/terraform`, run initial command:
```
$ cd tools/provision/terraform
$ terraform init

Initializing provider plugins...
- Checking for available provider plugins on https://releases.hashicorp.com...
- Downloading plugin for provider "aws" (1.57.0)...

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, it is recommended to add version = "..." constraints to the
corresponding provider blocks in configuration, with the constraint strings
suggested below.

* provider.aws: version = "~> 1.57"

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

## Apply Changes
In the same directory as the `example.tf` file you created, run `terraform apply`:
```
$ terraform apply

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  + aws_instance.example
      id:                           <computed>
      ami:                          "ami-063aa838bd7631e0b"
      arn:                          <computed>
      associate_public_ip_address:  <computed>
      availability_zone:            <computed>
      cpu_core_count:               <computed>
      cpu_threads_per_core:         <computed>
      ebs_block_device.#:           <computed>
      ephemeral_block_device.#:     <computed>
      get_password_data:            "false"
      host_id:                      <computed>
      instance_state:               <computed>
      instance_type:                "t2.micro"
      ipv6_address_count:           <computed>
      ipv6_addresses.#:             <computed>
      key_name:                     <computed>
      network_interface.#:          <computed>
      network_interface_id:         <computed>
      password_data:                <computed>
      placement_group:              <computed>
      primary_network_interface_id: <computed>
      private_dns:                  <computed>
      private_ip:                   <computed>
      public_dns:                   <computed>
      public_ip:                    <computed>
      root_block_device.#:          <computed>
      security_groups.#:            <computed>
      source_dest_check:            "true"
      subnet_id:                    <computed>
      tenancy:                      <computed>
      volume_tags.%:                <computed>
      vpc_security_group_ids.#:     <computed>


Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value:
```
enter 'yes'

then:
```
  Enter a value: yes

aws_instance.example: Creating...
  ami:                          "" => "ami-063aa838bd7631e0b"
  arn:                          "" => "<computed>"
  associate_public_ip_address:  "" => "<computed>"
  availability_zone:            "" => "<computed>"
  cpu_core_count:               "" => "<computed>"
  cpu_threads_per_core:         "" => "<computed>"
  ebs_block_device.#:           "" => "<computed>"
  ephemeral_block_device.#:     "" => "<computed>"
  get_password_data:            "" => "false"
  host_id:                      "" => "<computed>"
  instance_state:               "" => "<computed>"
  instance_type:                "" => "t2.micro"
  ipv6_address_count:           "" => "<computed>"
  ipv6_addresses.#:             "" => "<computed>"
  key_name:                     "" => "<computed>"
  network_interface.#:          "" => "<computed>"
  network_interface_id:         "" => "<computed>"
  password_data:                "" => "<computed>"
  placement_group:              "" => "<computed>"
  primary_network_interface_id: "" => "<computed>"
  private_dns:                  "" => "<computed>"
  private_ip:                   "" => "<computed>"
  public_dns:                   "" => "<computed>"
  public_ip:                    "" => "<computed>"
  root_block_device.#:          "" => "<computed>"
  security_groups.#:            "" => "<computed>"
  source_dest_check:            "" => "true"
  subnet_id:                    "" => "<computed>"
  tenancy:                      "" => "<computed>"
  volume_tags.%:                "" => "<computed>"
  vpc_security_group_ids.#:     "" => "<computed>"
aws_instance.example: Still creating... (10s elapsed)
aws_instance.example: Still creating... (20s elapsed)
aws_instance.example: Creation complete after 23s (ID: i-0b07a893d9d8fa6e1)

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

You can inspect the current state using terraform show:
```
$ terraform show
aws_instance.example:
  id = i-0b07a893d9d8fa6e1
  ami = ami-063aa838bd7631e0b
  arn = arn:aws:ec2:us-west-1:301935557214:instance/i-0b07a893d9d8fa6e1
  associate_public_ip_address = true
  availability_zone = us-west-1a
  cpu_core_count = 1
  cpu_threads_per_core = 1
  credit_specification.# = 1
  credit_specification.0.cpu_credits = standard
  disable_api_termination = false
  ebs_block_device.# = 0
  ebs_optimized = false
  ephemeral_block_device.# = 0
  get_password_data = false
  iam_instance_profile =
  instance_state = running
  instance_type = t2.micro
  ipv6_addresses.# = 0
  key_name =
  monitoring = false
  network_interface.# = 0
  network_interface_id = eni-03dd6035d13157574
  password_data =
  placement_group =
  primary_network_interface_id = eni-03dd6035d13157574
  private_dns = ip-172-31-15-183.us-west-1.compute.internal
  private_ip = 172.31.15.183
  public_dns = ec2-54-67-99-223.us-west-1.compute.amazonaws.com
  public_ip = 54.67.99.223
  root_block_device.# = 1
  root_block_device.0.delete_on_termination = true
  root_block_device.0.iops = 100
  root_block_device.0.volume_id = vol-0f19c97c86f51a349
  root_block_device.0.volume_size = 8
  root_block_device.0.volume_type = gp2
  security_groups.# = 1
  security_groups.3814588639 = default
  source_dest_check = true
  subnet_id = subnet-cbe65c93
  tags.% = 0
  tenancy = default
  volume_tags.% = 0
  vpc_security_group_ids.# = 1
  vpc_security_group_ids.3316243099 = sg-b5a632d2
```

## Configuration updated
Change AMI to: `ami-00ccbfda997c1cfb2`, as:
```
resource "aws_instance" "example" {
  ami           = "ami-00ccbfda997c1cfb2"
  instance_type = "t2.micro"
}
```
Apply Changes, run the command under the path `tools/provision/terraform`:
```
$ terraform apply
aws_instance.example: Refreshing state... (ID: i-0b07a893d9d8fa6e1)

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
-/+ destroy and then create replacement

Terraform will perform the following actions:

-/+ aws_instance.example (new resource required)
      id:                           "i-0b07a893d9d8fa6e1" => <computed> (forces new resource)
      ami:                          "ami-063aa838bd7631e0b" => "ami-00ccbfda997c1cfb2" (forces new resource)
      arn:                          "arn:aws:ec2:us-west-1:301935557214:instance/i-0b07a893d9d8fa6e1" => <computed>
      associate_public_ip_address:  "true" => <computed>
      availability_zone:            "us-west-1a" => <computed>
      cpu_core_count:               "1" => <computed>
      cpu_threads_per_core:         "1" => <computed>
      ebs_block_device.#:           "0" => <computed>
      ephemeral_block_device.#:     "0" => <computed>
      get_password_data:            "false" => "false"
      host_id:                      "" => <computed>
      instance_state:               "running" => <computed>
      instance_type:                "t2.micro" => "t2.micro"
      ipv6_address_count:           "" => <computed>
      ipv6_addresses.#:             "0" => <computed>
      key_name:                     "" => <computed>
      network_interface.#:          "0" => <computed>
      network_interface_id:         "eni-03dd6035d13157574" => <computed>
      password_data:                "" => <computed>
      placement_group:              "" => <computed>
      primary_network_interface_id: "eni-03dd6035d13157574" => <computed>
      private_dns:                  "ip-172-31-15-183.us-west-1.compute.internal" => <computed>
      private_ip:                   "172.31.15.183" => <computed>
      public_dns:                   "ec2-54-67-99-223.us-west-1.compute.amazonaws.com" => <computed>
      public_ip:                    "54.67.99.223" => <computed>
      root_block_device.#:          "1" => <computed>
      security_groups.#:            "1" => <computed>
      source_dest_check:            "true" => "true"
      subnet_id:                    "subnet-cbe65c93" => <computed>
      tenancy:                      "default" => <computed>
      volume_tags.%:                "0" => <computed>
      vpc_security_group_ids.#:     "1" => <computed>


Plan: 1 to add, 0 to change, 1 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_instance.example: Destroying... (ID: i-0b07a893d9d8fa6e1)
aws_instance.example: Still destroying... (ID: i-0b07a893d9d8fa6e1, 10s elapsed)
aws_instance.example: Still destroying... (ID: i-0b07a893d9d8fa6e1, 20s elapsed)
aws_instance.example: Still destroying... (ID: i-0b07a893d9d8fa6e1, 30s elapsed)
aws_instance.example: Still destroying... (ID: i-0b07a893d9d8fa6e1, 40s elapsed)
aws_instance.example: Still destroying... (ID: i-0b07a893d9d8fa6e1, 50s elapsed)
aws_instance.example: Destruction complete after 51s
aws_instance.example: Creating...
  ami:                          "" => "ami-00ccbfda997c1cfb2"
  arn:                          "" => "<computed>"
  associate_public_ip_address:  "" => "<computed>"
  availability_zone:            "" => "<computed>"
  cpu_core_count:               "" => "<computed>"
  cpu_threads_per_core:         "" => "<computed>"
  ebs_block_device.#:           "" => "<computed>"
  ephemeral_block_device.#:     "" => "<computed>"
  get_password_data:            "" => "false"
  host_id:                      "" => "<computed>"
  instance_state:               "" => "<computed>"
  instance_type:                "" => "t2.micro"
  ipv6_address_count:           "" => "<computed>"
  ipv6_addresses.#:             "" => "<computed>"
  key_name:                     "" => "<computed>"
  network_interface.#:          "" => "<computed>"
  network_interface_id:         "" => "<computed>"
  password_data:                "" => "<computed>"
  placement_group:              "" => "<computed>"
  primary_network_interface_id: "" => "<computed>"
  private_dns:                  "" => "<computed>"
  private_ip:                   "" => "<computed>"
  public_dns:                   "" => "<computed>"
  public_ip:                    "" => "<computed>"
  root_block_device.#:          "" => "<computed>"
  security_groups.#:            "" => "<computed>"
  source_dest_check:            "" => "true"
  subnet_id:                    "" => "<computed>"
  tenancy:                      "" => "<computed>"
  volume_tags.%:                "" => "<computed>"
  vpc_security_group_ids.#:     "" => "<computed>"
aws_instance.example: Still creating... (10s elapsed)
aws_instance.example: Still creating... (20s elapsed)
aws_instance.example: Still creating... (30s elapsed)
aws_instance.example: Creation complete after 32s (ID: i-07f27d006d8748204)

Apply complete! Resources: 1 added, 0 changed, 1 destroyed.
```

## Destroy
Resources can be destroyed using the `terraform destroy` command:
```
$ terraform destroy
```
Just like with `apply`, Terraform determines the order in which things must be destroyed.
