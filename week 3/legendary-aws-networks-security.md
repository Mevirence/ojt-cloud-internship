<img src="https://cdn.prod.website-files.com/677c400686e724409a5a7409/6790ad949cf622dc8dcd9fe4_nextwork-logo-leather.svg" alt="NextWork" width="300" />

# VPC Traffic Flow and Security

**Project Link:** [View Project](http://learn.nextwork.org/projects/aws-networks-security)

**Author:** vcpo2023-2468-56682@bicol-u.edu.ph  
**Email:** vcpo2023-2468-56682@bicol-u.edu.ph

---

## VPC Traffic Flow and Security

![Image](http://learn.nextwork.org/sincere_gray_heroic_red_currant/uploads/aws-networks-security_92b0b0b4)

---

## Introducing Today's Project!

### What is Amazon VPC?

Amazon VPC is allows users to create a private and isolated network within the AWS cloud where they can launch and manage resources such as virtual servers, databases, and applications and it is useful because it gives users full control over their network configuration, including IP address ranges, subnets, routing, and security settings, helping them securely organize resources, control access to the internet, and protect sensitive systems.

### How I used Amazon VPC in this project

In today's project, I used Amazon VPC as the private virtual network that hosted all networking components in the project. Within the VPC, I configured a route table to control traffic routing, a security group to manage instance-level access, and a Network ACL to filter traffic at the subnet level. These configurations helped secure and control communication between resources and external networks within the AWS environment.

### One thing I didn't expect in this project was...

One thing I didn't expect in this project was that a Network ACL was used to define inbound and outbound traffic for a set of subnets.

### This project took me...

This project took me almost an hour to finish

---

## Route tables

Route tables are a set of rules (called routes) that act as a traffic controller for your Virtual Private Cloud (VPC). It determines where network traffic from your subnets is directed

Routes tables are needed to make a subnet public because it is required to provide the subnet with a specific instruction (a route) to send internet-bound traffic out to an Internet Gateway (IGW)

![Image](http://learn.nextwork.org/sincere_gray_heroic_red_currant/uploads/aws-networks-security_0a07b191)

---

## Route destination and target

Routes are defined by their destination and target, which means the destination is the intended final address for your data, while the target (or "next hop") is the gateway or connection used as the next step to get there.

The route in my route table that directed internet-bound traffic to my internet gateway had a destination of 0.0.0.0/0 and a target of the Internet Gateway

![Image](http://learn.nextwork.org/sincere_gray_heroic_red_currant/uploads/aws-networks-security_0a07b191)

---

## Security groups

Security groups are virtual firewalls that control inbound and outbound traffic for your resources, such as Amazon EC2 instances or Amazon VPCs

### Inbound vs Outbound rules

Inbound rules are control the data that can enter the resources in our security group. I configured an inbound rule that opens port 80 to all incoming traffic from the internet, allowing anyone to view your web server

Outbound rules are rules that control the data that our resources can send out. By default, my security group's outbound rule allow all outbound traffic.

![Image](http://learn.nextwork.org/sincere_gray_heroic_red_currant/uploads/aws-networks-security_92b0b0b4)

---

## Network ACLs

Network ACLs are what act as a virtual firewall for your subnets, controlling inbound and outbound traffic at the boundary

### Security groups vs. network ACLs

The difference between a security group and a network ACL is that the latter is used to set broad traffic rules that apply to an entire subnet

---

## Default vs Custom Network ACLs

### Similar to security groups, network ACLs use inbound and outbound rules

By default, a network ACL's inbound and outbound rules will automatically allows all inbound and outbound traffic

In contrast, a custom ACL’s inbound and outbound rules are automatically set to deny all inbound and outbound traffic until you explicitly add rules to permit it

![Image](http://learn.nextwork.org/sincere_gray_heroic_red_currant/uploads/aws-networks-security_4faeb056)

---

## Tracking VPC Resources

---

---
