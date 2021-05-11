pipeline{
    agent {
        node {
            label 'hybrid'
        }
    }
    options {
        timeout(time: 10, unit: 'MINUTES')
    }
    environment {
        GITHUB_USERNAME = "mashapedeployment"
        GITHUB_USER_EMAIL = "mashapedeployment@konghq.com"
        GITHUB_TOKEN = credentials('BUMPER_GITHUB_TOKEN')
        DOCKERHUB_KONGCLOUD_PULL = credentials('DOCKERHUB_KONGCLOUD_PULL')
        KONG_DISTRIBUTIONS_OWNER_REPO = "jeremymv2/distributions"
    }
    stages {
        stage("Setup") {
            steps {
                script {
                    sh 'echo "$DOCKERHUB_KONGCLOUD_PULL_PSW" | docker login -u "$DOCKERHUB_KONGCLOUD_PULL_USR" --password-stdin || true'
                    sh 'git config --global user.name "$GITHUB_USERNAME"'
                    sh 'git config --global user.email "$GITHUB_USER_EMAIL"'
                }
            }
        }
        stage("Bump Version") {
            when {
                branch "main"
                not {
                    anyOf {
                        // to avoid an infinite loop, we only want to bump the version if
                        // the associated version files were not in the last changeset
                        changeset "**/*.rockspec"
                        changeset "CHANGELOG.md"
                        changeset "Jenkinsfile"
                    }
                }
            }
            steps {
                script {
                    sh 'docker image rm -f kongcloud/foundation-ci:latest || true'
                    sh 'docker run --env KONG_DISTRIBUTIONS_OWNER_REPO --env CHANGELOG_GITHUB_TOKEN=$GITHUB_TOKEN --env GITHUB_TOKEN --env GITHUB_USERNAME --env BUILD_NUMBER --volume $(pwd):/workspace kongcloud/foundation-ci:latest bash -c ". /foundation/modules/incl.sh && bump_repo \"/workspace\""'
                }
            }
        }
    }
}
