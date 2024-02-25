This repo is useful for devops engineers for provisioning infrastructure via terraform. It covers infrastructre as :-
    a. VPC 
    b. IAM-Role

VPC - 1
3 Private subnet
3 Public Subnet
3 Rt (1 default , 1 pvt rt, 1 public rt)
1 IGW
1 NAT GW

Public rt => Public subent (3) + IGW attached for 0.0.0.0/0

Pvt rt => Pvt Subnet (3) + NAT GW attached for 0.0.0.0/0