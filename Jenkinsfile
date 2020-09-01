pipeline {

    agent any
    tools {
        maven 'Maven3'
        jdk 'jdk8'
    }
	
	environment {
		USERNAME = 'shivanijain01'
		DB_ENGINE    = 'sqlite'
    }
    stages {
        stage ('Build') {
            steps {
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
		    bat "docker build -t i_${USERNAME}_{BRANCH_NAME} --no-cache -f Dockerfile ."
			    }
            }
    }
}
