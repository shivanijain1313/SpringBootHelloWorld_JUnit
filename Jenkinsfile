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
        stage ('Build') {
            steps {
		 echo 'Pulling...' + env.BRANCH_NAME
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

		stage('Pre Container Check') {
			steps {
				bat '''
				$containerId = docker ps -q -f name=c_shivanijain01_develop
                    if ($containerId){
		     docker container stop c_shivani
 docker container rm c_shivani
		    }
                   
                    '''
			}
		}
	    				        stage('Docker Image') {
            steps {
		    bat 'docker build -t i_%USER_NAME%:%BUILD_NUMBER% --no-cache -f Dockerfile .'
			    }
            }
    }
}
