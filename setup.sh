#!/bin/bash

# Set parameters
STACK_NAME="my-flask-app-stack"
TEMPLATE_FILE="my-flask-app.yaml"
GIT_REPO_URL="https://github.com/goreliks/cc_play.git"

# Create CloudFormation stack
aws cloudformation create-stack \
  --stack-name $STACK_NAME \
  --template-body file://$TEMPLATE_FILE \
  --region $REGION \
  --parameters ParameterKey=GitRepoURL,ParameterValue=$GIT_REPO_URL

# Wait for stack to complete
echo "Waiting for stack to be created..."
aws cloudformation wait stack-create-complete \
  --stack-name $STACK_NAME \
  --region $REGION
echo "Stack created!"

# Get the public IP address of the web server
PUBLIC_IP=$(aws cloudformation describe-stacks \
  --stack-name $STACK_NAME \
  --query 'Stacks[0].Outputs[?OutputKey==`PublicIP`].OutputValue' \
  --output text)

echo "The URL for the web server is http://${PUBLIC_IP}:5000"
