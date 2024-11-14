resource "aws_security_group" "tf-SG" {
  name   = "Terraform-SG"
  vpc_id = aws_vpc.main.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Tf-security_group"
  }
}

# EC2 Instance in the Public Subnet
resource "aws_instance" "web" {
  ami                    = data.aws_ami.linux_ami.id # Replace with a preferred AMI ID
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.tf-SG.id]
  key_name               = var.key_name

  # User data to configure instance on launch
  user_data = <<-EOF
#!/bin/bash
# Update packages
yum update -y

# Install and start HTTP server (Apache)
yum install -y httpd

# Create HTML file with the interactive content
cat <<EOT > /var/www/html/index.html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Interactive Magic Page</title>
  <style>
    /* Basic styling */
    body, html {
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
      font-family: Arial, sans-serif;
      transition: background 0.5s ease;
    }

    /* Color-changing button */
    .magic-button {
      padding: 15px 30px;
      font-size: 1.5rem;
      border: none;
      border-radius: 10px;
      cursor: pointer;
      background: linear-gradient(45deg, #ff6ec4, #7873f5);
      color: white;
      box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.2);
      animation: pulse 1.5s infinite alternate;
      transition: transform 0.3s ease;
    }

    /* Button hover effect */
    .magic-button:hover {
      transform: scale(1.1);
    }

    /* Confetti effect */
    .confetti {
      position: fixed;
      width: 10px;
      height: 10px;
      background: gold;
      border-radius: 50%;
      opacity: 0;
      pointer-events: none;
      animation: fall 1s ease-in forwards;
    }

    /* Button pulse animation */
    @keyframes pulse {
      0% {
        transform: scale(1);
      }
      100% {
        transform: scale(1.1);
      }
    }

    /* Confetti falling animation */
    @keyframes fall {
      0% {
        opacity: 1;
        transform: translateY(-50px) rotate(0deg);
      }
      100% {
        opacity: 0;
        transform: translateY(300px) rotate(360deg);
      }
    }
  </style>
</head>
<body>
  <button class="magic-button" onclick="performMagic()">✨ Click for Magic ✨</button>

  <script>
    // Colors for background change
    const colors = ["#f7a9a8", "#f7d18a", "#8ae2f7", "#e3f78a", "#d28af7"];

    function performMagic() {
      // Change the background color
      document.body.style.background = colors[Math.floor(Math.random() * colors.length)];

      // Create confetti
      for (let i = 0; i < 30; i++) {
        const confetti = document.createElement("div");
        confetti.classList.add("confetti");
        confetti.style.left = Math.random() * window.innerWidth + "px";
        confetti.style.animationDelay = Math.random() + "s";
        confetti.style.background = \`hsl(\$${Math.random() * 360}, 70%, 50%)\`;
        document.body.appendChild(confetti);

        // Remove confetti after animation
        setTimeout(() => {
          confetti.remove();
        }, 1000);
      }
    }
  </script>
</body>
</html>
EOT

# Start the Apache server
systemctl start httpd
systemctl enable httpd
EOF


  tags = {
    Name = "Terraform-EC2"
  }

}

