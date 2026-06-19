<img src="https://cdn.prod.website-files.com/677c400686e724409a5a7409/6790ad949cf622dc8dcd9fe4_nextwork-logo-leather.svg" alt="NextWork" width="300" />

# Build a Virtual Private Cloud

**Project Link:** [View Project](http://learn.nextwork.org/projects/aws-networks-vpc)

**Author:** vcpo2023-2468-56682@bicol-u.edu.ph  
**Email:** vcpo2023-2468-56682@bicol-u.edu.ph

---

## Build a Virtual Private Cloud (VPC)

![Image](http://learn.nextwork.org/sincere_gray_heroic_red_currant/uploads/aws-networks-vpc_2facf927)

---

## Introducing Today's Project!

In this project, I will demonstrate making Virtual Private Cloud I'm doing this project to learn more about AWS Services and practice using Amazon Web Services

### What is Amazon VPC?

Amazon VPC is a foundational AWS service that lets us create a logically isolated, private network within the public AWS cloud. It gives us full control over our networking environment, including IP address ranges, subnets, route tables, and security gateways. and it is useful because it allows us to isolate our compute resources (like EC2 instances) from the rest of the AWS cloud and, define exactly how traffic flows.

In today's project, I used Amazon VPC to create a my own VPC, along with a public subnet and internet gateway

### Personal reflection

This project took me almost an hour to accomplish

One thing I didn't expect in this project was how easy it would be to accomplish, but also how complicated the basics of networking can be

---

## Virtual Private Clouds (VPCs)

### What I did in this step

In this step, I will make VPC to provide an isolated virtual network in the AWS cloud because this provides an isolated, secure, and customizable private network within a public cloud

### How VPCs work

VPCs are an AWS resources that gives you the ability to make isolated virtual networks in the cloud where users can launch AWS resources

### Why there is a default VPC in AWS accounts

There was already a default VPC in my account ever since my AWS account was created. This is because of providing a pre-configured network. This eliminates complex setup, letting anyone instantly launch resources with public internet access.

![Image](http://learn.nextwork.org/sincere_gray_heroic_red_currant/uploads/aws-networks-vpc_2facf927)

### Defining IPv4 CIDR blocks

To set up my VPC, I had to define an IPv4 CIDR block, which is a contiguous range of IP addresses that share a common network prefix and are allocated and routed as a single unit.

---

## Subnets

### What I did in this step

In this step, I will make a subnet so I can start planning where different resources will live and operate.

### Creating and configuring subnets

Subnets area segmented range of IP addresses within your Amazon Virtual Private Cloud (VPC). It acts as an isolated subdivision, allowing you to organize your network and group cloud resources based on security and connectivity needs. There are already subnets existing in my account, one for every Availability Zone

### Public vs private subnets

The difference between public and private subnets are, public subnets are connected to the internet while a private subnet has no direct access to the internet. For a subnet to be considered public, it has to be able to communicate with external networks

![Image](http://learn.nextwork.org/sincere_gray_heroic_red_currant/uploads/aws-networks-vpc_157c4219)

### Auto-assigning public IPv4 addresses

Once I created my subnet, I enabled auto-assign public IPv4 adresses. This setting makes sure any EC2 instance launched in that subnet will instantly get a public IP address so that I won't have to create one manually

---

## Internet gateways

### What I did in this step

In this step, I will attach my VPC with an internet gateway because this allow bidirectional traffic, enabling users to access your web apps and your internal resources (like EC2 instances) to download software updates or connect externally.

### Setting up internet gateways

Internet gateways are what bridges your isolated Virtual Private Cloud (VPC) and the public internet.

Attaching an internet gateway to a VPC means resources in my VPC can now access the internet. If I missed this step any resources that are in my VPC couldn't access the internet

![Image](http://learn.nextwork.org/sincere_gray_heroic_red_currant/uploads/aws-networks-vpc_4ae90410)

---

## Using the AWS CLI

### What I'm doing in this extension

In this project extension, I will use AWS CLI to make a VPC, subnet, and internet gateway because this is to figure out if it is a faster, more efficient way to do this project.

### Exploring CloudShell and CLI

VPC resources could also be created with CloudShell, which is a shell in my AWS Management Console, which means it's a space for us to run code. CLI is Command Line Interface and it's a software that lets us create, delete and update AWS resources with commands instead of using the AWS Dashboard

### Debugging my setup

To set up a VPC or a subnet, you can use the command aws ec2 create-vpc --cidr-block 10.0.0.0/24 --query Vpc.VpcId --output text - for making a VPC and aws ec2 create-subnet --vpc-id VPC-ID --cidr-block ADD-CIDR-BLOCK-HERE for making a subnet Make sure to avoid errors by including the --cidr-block command and making sure that our subnet CIDR block fall within our VPC's CIDR block

![Image](http://learn.nextwork.org/sincere_gray_heroic_red_currant/uploads/aws-networks-vpc_9b2465411)

### Comparing CloudShell vs AWS Console

Compared to using the AWS Console, an advantage of using commands is automation and speed. An advantage of using the Console is is its visual, user-friendly interface that simplifies exploration and management. Overall, I preferred either of these as depending on what project or what you need to get done either can grant you the speed and efficiency that you would need.

---

---
