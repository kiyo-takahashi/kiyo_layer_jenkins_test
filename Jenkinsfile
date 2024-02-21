pipeline { // Declarative pipelineであることを宣言する
    agent { label 'master' } // 環境の指定（anyの場合、指定無しとなる）
    environment {
        TD_API_KEY = credentials('TD_API_KEY')
    }
    stages {
        stage('Build') {
            steps {
                echo "Building"
                dir ('/var/jenkins_home/workspace/kiyo_layer_jenkins_test_pipeline') {
                    sh "echo y | td -e https://api.treasuredata.co.jp wf push kiyo_layer_jenkins_test"
                    //sh "td -e https://api.treasuredata.co.jp db:create kiyo_s3_jenkins_test"
                    //sh "td -e https://api.treasuredata.co.jp table:create kiyo_s3_jenkins_test fei_city_s3"
                    // sh "td -e https://api.treasuredata.co.jp wf secrets --project load_s3_jenkins_test --set "
                    sh "td -e https://api.treasuredata.co.jp wf start kiyo_layer_jenkins_test kiyo_layer_test --session now > session_attempt_exec_log.txt"
                    
                    script {
                      def attempt_id = sh (
                        script: "python3.11 get_attempt_id.py",
                        //returnStatus: true
                        returnStdout: true
                      )

                      echo "${attempt_id}"

                      // タスクが一定以上進む間、ウェイト
                      // sleep(time:30, unit:"SECONDS")

                      sh (
                        script: "td -e https://api.treasuredata.co.jp wf log ${attempt_id}"
                      )

                      sh (
                        script: "td -e https://api.treasuredata.co.jp wf task ${attempt_id} > tasks_status_log.txt"
                      )

                      def wf_status = True
                      while (wf_status = True) {
                          wf_status = sh (
                            script: "python3.11 get_task_status_end.py",
                            returnStdout: true
                          )

                          sleep(time:60, unit:"SECONDS")
                      }
                    }
                }
            }
            // ステップ終了処理
            post {
                // 常に実行
                always {
                    echo "========End build!========"
                }
                // 成功時
                success {
                    echo "========Success!!========"
                }
                // 失敗時
                failure {
                    error "========Build NG...========"
                }
            }
        }
        stage('Test') {
            steps {
                echo "Testing"
                dir('/var/jenkins_home/workspace/kiyo_layer_jenkins_test_pipeline') {
                    // Not NULLテスト
                    sh "td -e https://api.treasuredata.co.jp query -d kiyo_layer1_sample_db -q test/sql/test_not_null__l1_attribute_summary.sql -w -f csv -o ./test/result/test_not_null.csv -T presto"
                    script {
                        //File f = new File("./test/result/test_not_null.csv")
                        def f = readFile "./test/result/test_not_null.csv"   
                        
                        //def line_count = file_texts.size()
                        def lines = f.readLines() 
                        println lines;

                        def line_count = lines.size()
                        println line_count;
                        
                        if (line_count > 0) {
                            error 'NULL exists!'
                        }
                    }
                }
            }
            // ステップ終了処理
            post {
                // 常に実行
                always {
                    echo "========End test!========"
                }
                // 成功時
                success {
                    echo "========Success!!========"
                }
                // 失敗時
                failure {
                    error "========Test NG...========"
                }
            }
        }
        stage('Deploy') {
            steps {
                echo "Deploying"
            }
        }
        stage('Release') {
            steps {
                echo "Releasing"
            }
        }
    }
    post {
        always {
            echo "========Finish========"
        }
    }
}


