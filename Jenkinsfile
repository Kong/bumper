pipeline{
    agent {
        node {
            label 'bionic'
        }
    }
    options {
        timeout(time: 30, unit: 'MINUTES')
    }
    environment {
        GITHUB_USERNAME = "Jenkins"
        GITHUB_USER_EMAIL = "jenkins@notreal.fake"
        GITHUB_TOKEN = credentials('PR_GITHUB_TOKEN')
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
                    sh 'git clone git@github.com:Kong/foundation.git --branch feat/version_bump --depth 1 /tmp/foundation'
                    sh 'source /tmp/foundation/modules/common.sh && bump_version $WORKSPACE patch'
                }
            }
        }
    }
}
/*
vim: syntax=groovy
*/
