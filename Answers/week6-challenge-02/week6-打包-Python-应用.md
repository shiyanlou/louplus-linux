# 挑战：打包 Python 应用

1. 参考《Jenkins 入门》实验安装 Jenkins。

2. 执行命令 `sudo service jenkins start` 进行启动；然后登录 Jenkins，默认访问地址为 `http://localhost:8080/`。

3. 下载 jenkins-python-app 应用并解压缩：

```bash
curl https://labfile.oss.aliyuncs.com/courses/2657/jenkins-python-app.tar.gz -o jenkins-python-app.tar.gz
tar -zxf jenkins-python-app.tar.gz
```

在个人 GitHub 账号下新建一个仓库 `jenkins-python-app`，将应用代码提交到该仓库。

该项目的目录结构如下所示：

```text
jenkins-python-app
|----sources
|     |----add2vals.py
|     |----calc.py
|     |----test_calc.py
|----Jenkinsfile
```

对应的 Jenkinsfile 文件内容如下所示：

```groovy
pipeline {
    agent none
    stages {
        stage('Build') {
            agent {
                docker {
                    image 'registry.cn-hangzhou.aliyuncs.com/louplus-linux/python:2-alpine'
                }
            }
            steps {
                sh 'python -m py_compile sources/add2vals.py sources/calc.py'
            }
        }
        stage('Test') {
            agent {
                docker {
                    image 'registry.cn-hangzhou.aliyuncs.com/louplus-linux/qnib-pytest'
                }
            }
            steps {
                sh 'py.test --verbose --junit-xml test-reports/results.xml sources/test_calc.py'
            }
            post {
                always {
                    junit 'test-reports/results.xml'
                }
            }
        }
        stage('Deliver') {
            agent {
                docker {
                    image 'registry.cn-hangzhou.aliyuncs.com/louplus-linux/cdrx-pyinstaller-linux:python2'
                }
            }
            steps {
                sh 'pyinstaller --onefile sources/add2vals.py'
            }
            post {
                success {
                    archiveArtifacts 'dist/add2vals'
                }
            }
        }
    }
}
```

4. 单击左上角的 `New Item`。选择 `Pipeline`，输入任务名称 `jenkins-python-app`，然后点击左下角 `OK`。

5. 在 Pipeline 创建页面。

向下滚动到 `Pipeline` 部分，确保 `Definition` 选中的是 `Pipeline script from SCM`，然后 SCM 选择 `Git`。接下来在 `Repository URL` 中填写仓库地址 `git@github.com:xxxx/jenkins-python-app.git`（其中 `xxxx` 替换为你的 GitHub 用户名），然后在 `Branches to build` 中设置为 `*/main`，最后点击 `Save` 进行保存。

由于 Jenkins 用户与 GitHub 通过 ssh 通信，还需要设置在 GitHub 网页上添加 ssh 密钥才能访问。执行如下命令：

```bash
sudo su -s /bin/bash jenkins
# 一直按回车键
ssh-keygen -t rsa
cat /var/lib/jenkins/.ssh/id_rsa.pub
# 添加 /var/lib/jenkins/.ssh/known_hosts
git ls-remote -h git@github.com:xxxx/test_git.git HEAD
```

将 id_rsa.pub 文件中的密钥添加到 GitHub 中，在 GitHub 首页右上角个人设置 -> `Settings` 中找到 `SSH and GPG keys` 然后添加密钥。

6. 在终端执行命令 `sudo usermod -a -G docker jenkins` 将 jenkins 用户加入到 docker 组中。然后执行命令 `sudo service jenkins restart` 重启 Jenkins。

7. 在 Pipeline jenkins-python-app 详情页，单击左侧的 `Build Now` 以运行 Pipeline。

待构建完成后，在详情页面可以看到 `Last Successful Artifacts` 下有一个 `add2vals` 程序，下载该程序，然后执行验证程序是否能够正常运行，验证命令如下所示：

```bash
sudo chmod 777 add2vals

./add2vals

./add2vals 1 2

./add2vals hello 2
```



