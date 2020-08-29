pipeline {
    agent any
    tools {
        maven 'Maven3'
        jdk 'jdk8'
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
                    goals: 'clean install',
                    deployerId: 'MAVEN_DEPLOYER',
                )
				
				rtPublishBuildInfo (
                    serverId: 'ARTIFACTORY_SERVER'
                )
            }
			
		}
    }
}
