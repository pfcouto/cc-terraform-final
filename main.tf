terraform {
  required_providers {
    vercel = {
      source  = "vercel/vercel"
      version = "0.11.4"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }

    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}


########################### AWS Provider - BD ###########################


provider "aws" {
  region     = "eu-west-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "cc-terraform" {
  vpc_id      = data.aws_vpc.default.id
  name        = "cc-terraform-name"
  description = "Allow all inbound for Postgres"
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "cc-terraform-db" {
  identifier             = "cc-terraform-db-id"
  db_name                = var.db_name
  instance_class         = "db.t2.micro"
  allocated_storage      = 5
  engine                 = "postgres"
  engine_version         = "12.7"
  skip_final_snapshot    = true
  publicly_accessible    = true
  vpc_security_group_ids = [aws_security_group.cc-terraform.id]
  username               = var.db_username
  password               = var.db_password
}



########################### Digital Ocean - API ###########################


provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_app" "golang-gin-api" {
  spec {
    name   = "golang-gin-api"
    region = "ams"

    # Build a Go project in the api/ directory that listens on port 3000
    # and serves it at https://foo.example.com/api
    service {
      name               = "api"
      instance_count     = 1
      instance_size_slug = "professional-xs"
      dockerfile_path    = "api/Dockerfile"

      github {
        branch         = "main"
        deploy_on_push = true
        repo           = "pfcouto/cc-terraform-final"
      }

      source_dir = "api/"
      http_port  = 8080

      env {
        key   = "DB_SOURCE"
        value = "postgresql://${var.db_username}:${var.db_password}@${aws_db_instance.cc-terraform-db.endpoint}/${var.db_name}"
      }

      routes {
        path = "/"
      }
    }
  }
}


########################### Vercel Provider - FrontEnd ###########################

provider "vercel" {
  # Or omit this for the api_token to be read
  # from the VERCEL_API_TOKEN environment variable
  api_token = var.vercel_api_token
}

data "vercel_project_directory" "frontend" {
  path = "frontend/"
}

resource "vercel_project_environment_variable" "frontend" {
  project_id = vercel_project.frontend.id
  key        = "VITE_Golang_API_URL"
  value      = digitalocean_app.golang-gin-api.live_url
  target     = ["production"]
}

resource "vercel_project" "frontend" {
  name             = "sveltekit-cloud-computing"
  output_directory = "build"
  # framework        = "sveltekit"
  git_repository = {
    type = "github"
    repo = "pfcouto/cc-terraform-final"
  }
  root_directory = "frontend/"
}

resource "vercel_deployment" "frontend" {
  project_id = vercel_project.frontend.id
  files      = data.vercel_project_directory.frontend.files
  # path_prefix = data.vercel_project_directory.frontend.path
  production = true
  project_settings = {
    # framework        = "sveltekit"
    output_directory = "build"
    install_command  = "npm install"
    build_command    = "npm run build"
  }
  environment = {
    "VITE_Golang_API_URL" = digitalocean_app.golang-gin-api.live_url
  }

}
