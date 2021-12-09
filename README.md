<h1 align="center">Infrastructure Automation <br/>with Terraform and GitHub Actions</h1>
<p align="center">
  <a href="https://github.com/ShinhyeongPark/Terraform-GitHubAction">
    <img alt="Version" src="https://img.shields.io/badge/version-1.0.0-blue.svg?cacheSeconds=2592000" />
  </a> 
  <a href="https://github.com/ShinhyeongPark/Terraform-GitHubAction/blob/main/LICENSE" target="_blank">
    <img alt="License: MIT" src="https://img.shields.io/badge/license-MIT-yellow.svg" />
  </a>
  <a href="https://github.com/ShinhyeongPark/Terraform-GitHubAction/actions/workflows/terraform.yml" target="_blank"><img src="https://github.com/ShinhyeongPark/Terraform-GitHubAction/actions/workflows/terraform.yml/badge.svg?branch=main">
  </a>
</p>

> Terraform을 사용하여 AWS에 Wordpress로 구축한 팀 블로그 PJT 입니다. <br/>또한 Terraform에서 지원하는 모듈들을 사용했으며,GitHub Actions로 CI/CD를 구성했습니다.

<br/>

## ⚙ AWS Infrastructure
![Untitled](https://user-images.githubusercontent.com/57867611/139794226-6c5399ec-570f-47cb-928c-1987240ed6b3.png)
1. 새로운 VPC 생성 (10.80.0.0/16)
2. VPC 내부에 Subnet 분리 (us-east-1a 3개, us-east-1b 3개)
3. 이중화 구성 (us-east-1a, us-east-1b)
4. 실제 App은 인터넷 게이트웨이와 통신을 못하도록 Private하게 구성하며, Bastion 서버를 통해서만 접근이 가능
5. NAT(Network Address Translation)를 통해 Bastion Public Server와 App Private Server 간 통신을 구현
6. RDS도 App과 같이 Private하게 구축하여 보안을 강화
7. Application(여기서는 Wordpress)이 구축이 완료되면, ALB(Application Load Balancer)를 통해 App Server와 인터넷 통신이 가능하도록 설정

<br/>

## 📌 Application Diagram
![image](https://user-images.githubusercontent.com/57867611/139794466-5802fd65-5201-4a04-992b-99e179729cf3.png)

> Docker Compose를 통해 Docker Container (Wordpress가 동작)를 관리 <br/>
> Wordpress, MySQL 이미지를 통해서 Wordpress 설치, RDS 연결

<br/>

## 📖 Learn
###  이 프로젝트를 수행하기 위해서 아래 사이트를 참고하고 실습을 진행했습니다.
1. [Terraform을 사용한 AWS 인프라 구축](https://learn.hashicorp.com/collections/terraform/aws-get-started)
2. [Terraform을 사용한 Docker 인프라 구축](https://learn.hashicorp.com/collections/terraform/docker-get-started)
3. [Terraform GitHub Actions 튜토리얼](https://learn.hashicorp.com/tutorials/terraform/github-actions)
4. [Terraform Documents](https://www.terraform.io/docs/index.html)
5. [Terraform Registry](https://registry.terraform.io/)
6. [Terraform Module Source Code](https://github.com/terraform-aws-modules)

<br/>

## ⭐️ Prerequisites
### 위의 학습 자료(튜토리얼)을 수행하면 Prereqisites를 충족시킬 수 있습니다.
1. Terraform CLI
2. [AWS Account](https://aws.amazon.com/ko/console/)
3. AWS CLI
4. AWS Credentials (IAM)
5. [Terraform Cloud Account](https://www.terraform.io/cloud)
6. Docker
7. Docker Compose
8. [GitHub Account](https://github.com/)

<br/>

## 💡 Reference
### Learn에서 수행한 실습과 Prerequisites를 준비하는 과정들을 노션에 정리했으니 참고해주세요.

- [Terraform으로 인프라 자동화](https://peppermint-waxflower-244.notion.site/Terraform-69f91597baa042f1a90a45e0b8dcf899)
- [Terraform GitHub Actions: CI/CD 구성](https://peppermint-waxflower-244.notion.site/Github-Actions-with-Terraform-730b8c97f9724fe498664070a7e675de)

<br/>

## Public Key 등록
**미리 말하자면, 생성한 키는 .gitignore에 반드시 등록**
<br/>
제가 작성한 [.gitignore](https://github.com/ShinhyeongPark/Terraform-GitHubAction/blob/main/.gitignore)을 보면 인스터스 키뿐만 아니라 .terraform도 추가했습니다. (용량 문제로 Push가 안되더라구요😨)
1. 먼저 키를 생성한다. (bastion, app, db)

    ```bash
    ssh-keygen -t rsa -b 4096 -N "" -f [이름]-key #이름-key 형식으로 지정
    ```
2. 키가 생성되면 cat 명령어로 키의 데이터를 복사(ctrl+c)한다.
3. [Terraform Cloud](https://www.terraform.io/cloud) 접속
4. 로그인 한 후 현재 작업중인 organization의 workspace로 이동한다.
5. Variables 메뉴로 가 Environment Variables에 이전에 복사한 데이터를 추가한다.
(**반드시 TF_VAR를 붙여야 한다.**)
![화면 캡처 2021-11-02 135943](https://user-images.githubusercontent.com/57867611/139789229-72071ed1-f44f-49a4-88a5-9fffb591bc15.png)
6. 키 등록 후 화면
![sdsdsd](https://user-images.githubusercontent.com/57867611/139789401-3ac10487-c07b-44d2-a92e-54224d1d9bc7.png)

<br/>

## 🦸‍♂️ Author

👤 **Shinhyeong Park**

* Github: https://github.com/ShinhyeongPark
* Velog: [@Shinhyeong Park](https://velog.io/@orpsh1941)
* Email: orpsh1941@gmail.com


***
_This README was generated with ❤️ by [readme-md-generator](https://github.com/kefranabg/readme-md-generator)_
