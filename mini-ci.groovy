//node("master") {
//    ws("workspace/" + env.BUILD_TAG) {
//        stage("Checkout") {
//            checkout(
//                    [$class: 'GitSCM',
//                     branches: [[name: '*/master']],
//                     doGenerateSubmoduleConfigurations: false,
//                     extensions: [],
//                     submoduleCfg: [],
//                     userRemoteConfigs: [[url: 'https://github.com/ittiel/jenkins.git']]
//                    ])
//
//        }
//        dir("vanilla-maven") {
//            stage("Build") {
//                sh("""
//                    """)
//            }
//            stage("Run tests") {
//                try {
//                    // Run tests
//                    withEnv(["PATH+MVN=/usr/share/maven/bin", "M3_HOME=${env.WORKSPACE}/.m2"]) {
//                        sh("mvn -Dmaven.repo.local='${env.WORKSPACE}/.m2/repository' -B clean verify")
//                    }
//                }
//                catch(Throwable e) {
//                    // Set build status
//                    currentBuild.result = "UNSTABLE"
//                }
//            }
//            stage("Publish test results") {
//                // Publish results
//                junit 'target/surefire-reports/*.xml'
//            }
//        }
//        deleteDir()
//    }
//}
