#!/bin/bash

# filepath: /c:/Users/matth/Documents/mlops-workshop/create_stacks.sh

# Path to the users.json file
# USERS_FILE="users.json"

# # Read the usernames from the JSON file
# USERNAMES=$(jq -r 'keys[]' $USERS_FILE)

USERS=(
  "prod MatthiasMurray"
  "mkuc GonGitNow"
  "eyil elifidc"
  "done doneill10"
  "lliz llizima"
  "cbar cbardalesm1"
  "atow atown1501"
  "jrio jriosrodas28"
  "mstr mike-str"
  "abar anthonybarrios1"
  "bkli bklingen"
)

# Iterate through each username and create a CloudFormation stack
for USER in "${USERS[@]}"; do
  # Split the USER variable into uid and githubprofile
  IFS=' ' read -r uid githubprofile <<< "$USER"
  echo "Creating stack for user: $uid with githubprofile: $githubprofile"
  aws cloudformation deploy \
    --stack-name "codebuild-codepipeline-connection-$uid" \
    --template-file user-pipelines.yaml \
    --parameter-overrides uid=$uid githubprofile=$githubprofile \
    --capabilities CAPABILITY_NAMED_IAM \
    --profile mmur-admin
done