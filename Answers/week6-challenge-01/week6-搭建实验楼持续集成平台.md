# 挑战：搭建实验楼持续集成平台

1. 参考《Jenkins 入门》实验安装 Jenkins。

2. 执行命令 `sudo service jenkins start` 进行启动；然后登录 Jenkins，默认访问地址为 `http://localhost:8080/`。

3. 在 Jenkins 主页中，单击左上角 `Manage Jenkins` -> `Configure Global Security`），禁用 `CSRF Protection`，然后点击 `Save` 保存。

4. 单击左上角的 `New Item`。选择 `Pipeline`，输入任务名称 `shiyanlou`，然后点击左下角 `OK`。

5. 在 Pipeline 创建页面。

打开触发远程构建 `Trigger builds remotely` 选项，身份证令牌 Authentication Token 填写为 `shiyanlou`。

向下滚动到 `Pipeline` 部分，确保 `Definition` 选中的是 `Pipeline script`，然后输入下面的内容：

```groovy
pipeline {
    agent any
    stages {
        stage('Download') {
            steps {
                sh 'wget http://labfile.oss.aliyuncs.com/courses/980/09/assets/flask-demo.tar.gz'
                sh 'tar zxvf flask-demo.tar.gz'
            }
        }
        stage('Build') {
            steps {
                sh 'pip3 install flask'
            }
        }
        stage('Run') {
            steps {
                withEnv(['JENKINS_NODE_COOKIE=dontKillMe']) {
                    sh 'cd flask-demo && LC_ALL=C.UTF-8 LANG=C.UTF-8 FLASK_APP=app.py nohup flask run >/dev/null 2>&1 &'
                }
            }
        }
    }
}
```

最后点击 `Save` 进行保存，然后进入 Pipeline shiyanlou 详情页。

6. 在终端命令行命令。

```bash
curl -X POST 'http://shiyanlou:shiyanlou@localhost:8080/job/shiyanlou/build?token=shiyanlou'
```

查看 Pipeline shiyanlou 详情页是否触发了构建。

构建完成，执行命令验证部署成功：

```bash
$ curl http://localhost:5000
Welcome to Shiyanlou!
```
