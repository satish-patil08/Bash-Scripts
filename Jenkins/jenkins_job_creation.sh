#!/bin/bash

# Jenkins server details
JENKINS_URL="http://localhost:8080/"
JENKINS_USER="satishPatil"
JENKINS_TOKEN="112e938fd5761c1362a7c3bc55b5370c59"

# List of projects with their GitHub repository URLs
declare -A PROJECT_REPOS
PROJECT_REPOS["Backend-Clients"]="https://github.com/satish-patil08/Backend-Clients.git"
PROJECT_REPOS["Backend-Notifications"]="https://github.com/satish-patil08/Backend-Notification.git"
PROJECT_REPOS["Backend-Service-Registry"]="https://github.com/satish-patil08/Backend-Service-Registry.git"
PROJECT_REPOS["Backend-Shared-Utils"]="https://github.com/satish-patil08/Backend-Shared-Utils.git"
PROJECT_REPOS["Backend-Users"]="https://github.com/satish-patil08/Backend-Users.git"

# Loop through each project and create the job
for project in "${!PROJECT_REPOS[@]}"; do
    echo "Checking if job exists: $project"

    # Check if the job exists
    job_check=$(curl -s -o /dev/null -w "%{http_code}" "$JENKINS_URL/job/$project/api/json" --user "$JENKINS_USER:$JENKINS_TOKEN")

    if [ "$job_check" -eq 200 ]; then
        echo "Job $project already exists. Checking for any ongoing builds before deletion."

        # Check if the job is currently building
        build_status=$(curl -s "$JENKINS_URL/job/$project/lastBuild/api/json" --user "$JENKINS_USER:$JENKINS_TOKEN" | jq -r .building)

        if [ "$build_status" == "true" ]; then
            echo "Job $project is currently building. Waiting for it to finish."
            # Wait until the job is not building
            while [ "$build_status" == "true" ]; do
                sleep 5
                build_status=$(curl -s "$JENKINS_URL/job/$project/lastBuild/api/json" --user "$JENKINS_USER:$JENKINS_TOKEN" | jq -r .building)
            done
        fi

        echo "Deleting job: $project"
        # Use POST for deletion as Jenkins requires POST for job deletion
        curl -X POST "$JENKINS_URL/job/$project/doDelete" --user "$JENKINS_USER:$JENKINS_TOKEN"
    else
        echo "Job $project does not exist. Skipping deletion."
    fi

    echo "Creating job: $project"

    # Get the Git repository URL for the project
    REPO_URL="${PROJECT_REPOS[$project]}"

    # Create job configuration
    JOB_CONFIG=$(cat <<EOF
<?xml version='1.0' encoding='UTF-8'?>
<flow-definition plugin="workflow-job@2.41">
    <description>CI/CD Pipeline for ${project}</description>
    <keepDependencies>false</keepDependencies>
    <properties/>
    <definition class="org.jenkinsci.plugins.workflow.cps.CpsScmFlowDefinition" plugin="workflow-cps@2.94">
        <scm class="hudson.plugins.git.GitSCM" plugin="git@4.10.0">
            <configVersion>2</configVersion>
            <userRemoteConfigs>
                <hudson.plugins.git.UserRemoteConfig>
                    <url>${REPO_URL}</url>
                    <credentialsId></credentialsId>  <!-- Set credentialsId as empty to indicate 'none' credentials -->
                </hudson.plugins.git.UserRemoteConfig>
            </userRemoteConfigs>
            <branches>
                <hudson.plugins.git.BranchSpec>
                    <name>*/main</name>         <!-- branch name -->
                </hudson.plugins.git.BranchSpec>
            </branches>
        </scm>
        <scriptPath>Jenkinsfile</scriptPath>   <1-- Chanege your jenkins file name-->
        <lightweight>true</lightweight>
    </definition>
    <triggers>
        <hudson.triggers.SCMTrigger>
            <spec>* * * * *</spec> <!-- Poll every minute -->
        </hudson.triggers.SCMTrigger>
    </triggers>
</flow-definition>
EOF
)
    # Create the job using Jenkins API
    curl -X POST "$JENKINS_URL/createItem?name=$project" \
         --user "$JENKINS_USER:$JENKINS_TOKEN" \
         --header "Content-Type: application/xml" \
         --data-raw "$JOB_CONFIG"

    echo "Job $project created successfully."
done
