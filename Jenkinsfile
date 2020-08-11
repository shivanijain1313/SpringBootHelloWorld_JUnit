pipeline {
    agent any

    stages {
        stage ('Build') {
		    steps {
			        withMaven(maven: 'maven',jdk: 'jdk8') {
                    bat 'mvn clean install'
                  }
			}
			

            post {
                success {
                    junit 'target/surefire-reports/**/*.xml' 
                }
            }
        }
    }
}