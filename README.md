# task3_hybridcloud

Task Description:
1) Write a Infrastructure as code using terraform, which automatically create a VPC.

2) In that VPC we have to create 2 subnets:
    a)  public  subnet [ Accessible for Public World! ] 
    b)  private subnet [ Restricted for Public World! ]

3) Create a public facing internet gateway for connect our VPC/Network to the internet world and attach this gateway to our VPC.

4) Create  a routing table for Internet gateway so that instance can connect to outside world, update and associate it with public subnet.

5) Launch an ec2 instance which has Wordpress setup already having the security group allowing  port 80 so that our client can connect to our wordpress site.
Also attach the key to instance for further login into it.

6) Launch an ec2 instance which has MYSQL setup already with security group allowing  port 3306 in private subnet so that our wordpress vm can connect with the same.

Do have a look at my linkedin blog: https://www.linkedin.com/posts/asish-patnaik-3917a7193_righteducation-aws-terraform-activity-6688004647912927232-YjSY
