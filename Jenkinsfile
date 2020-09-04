pipeline {

    agent any
    tools {
        maven 'Maven3'
        jdk 'jdk8'
    }
	
	environment {
		USER_NAME = 'shivanijain01'
		DB_ENGINE    = 'sqlite'
    }
    stages {
	          stage("Start") {
            steps {
                //Initial message
             
                checkout scm

           }
        }

        stage ('Build') {
            steps {
		    checkout scm
		    echo 'Pulling...'+  %GIT_BRANCH%
                bat 'mvn clean install' 
            }
            post {
                success {
                    junit 'target/surefire-reports/**/*.xml' 
                }
            }
        }
		
        stage('Sonar') {
            steps {
                echo 'Sonar Scanner'
               	//def scannerHome = tool 'SonarQube Scanner 3.0'
			    withSonarQubeEnv('Test_Sonar') {
			    	bat 'mvn sonar:sonar'
			    }
            }
        }	

	    				        stage('Docker Image') {
            steps {
		    bat 'docker build -t i_%BRANCH_NAME%:%BUILD_NUMBER% --no-cache -f Dockerfile .'
			    }
            }
    }
}
