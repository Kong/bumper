pipeline{
    agent any
    options {
        timeout(time: 30, unit: 'MINUTES')
    }
    environment {
        GITHUB_USERNAME = "Jenkins"
        GITHUB_USER_EMAIL = "jenkins@notreal.fake"
        GITHUB_TOKEN = credentials('BUMPER_GITHUB_TOKEN')
    }
    stages {
        stage("Setup") {
            steps {
                script {
                    sh 'git config --global user.name "$GITHUB_USERNAME"'
                    sh 'git config --global user.email "$GITHUB_USER_EMAIL"'
                }
            }
        }
        stage("Bump Version") {
            when {
                branch "main"
                not {
                    // to avoid an infinite loop, we only want to bump the version if
                    // the VERSION file wasn't in the last changeset
                    changeset "VERSION"
                }
            }
            steps {
                script {
                    // sh 'rm -rf /tmp/foundation && git clone https://$GITHUB_TOKEN@github.com/Kong/foundation.git --branch feat/version_bump --depth 1 /tmp/foundation'
                    // sh 'source /tmp/foundation/modules/common.sh && bump_version $WORKSPACE true'
                    sh 'docker run --env CHANGELOG_GITHUB_TOKEN=$GITHUB_TOKEN -v $(pwd):/workspace foundationci:latest bash -c ". /foundation/lib.sh && bump_repo \"/workspace\""'
                }
            }
        }
    }
}
