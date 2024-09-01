#!/bin/bash

# Update packages and install Apache
sudo yum update -y
sudo yum install -y httpd

# Start and enable Apache
sudo systemctl start httpd
sudo systemctl enable httpd

# Configure the firewall to allow HTTP traffic
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --reload

# Create the HTML landing page
sudo tee /var/www/html/index.html > /dev/null <<EOL
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AWS Proof-of-Concept Environment with Terraform</title>
    <style>
        body {
            background-color: #5C4EE5;
            color: white;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
        }
        h1, h3 {
            text-align: center;
        }
        h1 {
            font-size: 48px;
            margin-top: 50px;
        }
        h3 {
            font-size: 36px;
            margin-top: 30px;
        }
        ul {
            font-size: 24px;
            margin: 20px auto;
            width: 80%;
            list-style-type: disc;
            line-height: 1.8; /* Adds more space between bullet points */
        }
        ul li {
            margin-bottom: 10px; /* Space between bullet points */
        }
    </style>
</head>
<body>
    <h1>AWS Proof-of-Concept Environment with Terraform</h1>
    <h3>Business Value of Terraform CLI</h3>
    <ul>
        <li>Consistency: Ensures that environments are consistent, reducing discrepancies between development, staging, and production.</li>
        <li>Automation: Reduces manual intervention and the risk of human errors.</li>
        <li>Scalability: Easily manage large-scale infrastructure with Terraform.</li>
        <li>Version Control: Enhances collaboration, version control, and efficiency through infrastructure as code practices.</li>
        <li>Cost Efficiency: Helps organizations achieve significant cost savings and operational agility.</li>
    </ul>
</body>
</html>
EOL

# Restart Apache to ensure changes are applied
sudo systemctl restart httpd
