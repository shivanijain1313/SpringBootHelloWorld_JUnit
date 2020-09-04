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

        stage ('Upload to Artifactory') {
            steps {

                rtMavenDeployer (
                    id: 'MAVEN_DEPLOYER',
                    serverId: 'ARTIFACTORY_SERVER',
                    releaseRepo: 'jenkins-release',
                    snapshotRepo: 'jenkins-snapshot'
                )

                rtMavenRun (
                    pom: 'pom.xml',
                    goals: 'install -DgeneratePom=false -DuniqueVersion=false',
                    deployerId: 'MAVEN_DEPLOYER',
                )
				
				rtPublishBuildInfo (
                    serverId: 'ARTIFACTORY_SERVER'
                )
            }
			
		}
	    				        stage('Docker Image') {
            steps {
		    bat 'docker build -t i_%USER_NAME%:%BUILD_NUMBER% --no-cache -f Dockerfile .'
			    }
            }
    }
}
