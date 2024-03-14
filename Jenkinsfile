pipeline {
    agent any
    options{
        //This is required if you want to clean before build
        skipDefaultCheckout(true)
    }
    tools {
        jdk 'java'
        maven 'maven_home'
    }

    environment {
        SCANNER_HOME = tool 'sonar-scanner'
        APP_NAME = "java-registration-app"
        RELEASE = "1.0.0"
        DOCKER_USER = "gustavepablo4"
        DOCKER_PASS = 'Docker-cred'
        IMAGE_NAME = "${DOCKER_USER}" + "/" + "${APP_NAME}"
        IMAGE_TAG = "${RELEASE}-${BUILD_NUMBER}"
	
    }

    stages{

        stage("Checkout from SCM"){
            steps{
                git branch: 'main', credentialsId: 'gitgustave', url: 'https://github.com/gitgustave/CI-CD-Project3'
            }
        }

        stage("Build Application "){
            steps{
                dir('project3') { 
                sh "mvn clean"
                }
            }
        }

        stage("Test Application"){
            steps{
                dir('project3'){ 
                sh "mvn test"
                }
            }
        }
        // Artifact start here
             stage ('Artifactory configuration') {
            steps {
                rtServer (
                    id: "jfrog-server",
                    url: "http://192.168.1.35:8082/artifactory",
                    credentialsId: "jfrog"
                )

                rtMavenDeployer (
                    id: "MAVEN_DEPLOYER",
                    serverId: "jfrog-server",
                    releaseRepo: "libs-release-local",
                    snapshotRepo: "libs-snapshot-local"
                )

                rtMavenResolver (
                    id: "MAVEN_RESOLVER",
                    serverId: "jfrog-server",
                    releaseRepo: "libs-release",
                    snapshotRepo: "libs-snapshot"
                )
            }
         }
      //   stage ('Deploy Artifacts') {
        //    steps { 
         //       dir ('project3'){ 
           //     rtMavenRun (
           //         tool: "maven_home", 
           //         pom: 'pom.xml',
           //         goals: 'clean install',
           //         deployerId: "MAVEN_DEPLOYER",
           //         resolverId: "MAVEN_RESOLVER"
            //    )
             //   }
            
         //}
         //stage ('Publish build info') {
         //   steps {
           //     rtPublishBuildInfo (
            //        serverId: "jfrog-server"
             //)


          stage("Build & Push Docker Image") {
             steps {
                 script {
                     docker.withRegistry('',DOCKER_PASS) {
                         docker_image = docker.build "${IMAGE_NAME}"
                     }
                     docker.withRegistry('',DOCKER_PASS) {
                         docker_image.push("${IMAGE_TAG}")
                         docker_image.push('latest')
                     }
                 }
             }
         }               
    }
}
            
// Artifact done
    


