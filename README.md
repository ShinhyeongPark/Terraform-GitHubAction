<h1 align="center">Infrastructure Automation with Terraform and GitHub Action 👋</h1>
<p>
  <a href="#" target="_blank">
    <img alt="License: MIT" src="https://img.shields.io/badge/License-MIT-yellow.svg" />
  </a>
</p>

> Terraform을 사용하여 AWS에 Wordpress 구축하는 Side Project입니다. 또한 테라폼에서 지원하는 모듈들을 사용했으며, GitHub Actions로 CI/CD를 구성했습니다.

## Learn
> 이 프로젝트를 수행하기 위해서 아래 사이트를 참고하고 실습을 진행했습니다.
1. [Terraform을 사용한 AWS 인프라 구축](https://learn.hashicorp.com/collections/terraform/aws-get-started)
2. [Terraform을 사용한 Docker 인프라 구축](https://learn.hashicorp.com/collections/terraform/docker-get-started)
3. [Terraform GitHub Actions 튜토리얼](https://learn.hashicorp.com/tutorials/terraform/github-actions)
4. [Terraform Documents](https://www.terraform.io/docs/index.html)

## Prerequisites
위의 학습 자료(튜토리얼)을 수행하면 Prereqisites를 충족시킬 수 있습니다.
1. Terraform CLI
2. AWS Account
3. AWS CLI
4. AWS Credentials (IAM)
5. Terraform Cloud Account
6. Docker
7. Docker Compose
8. GitHub Account

## Reference
> Learn에서 수행한 실습과 Prerequisites를 준비하는 과정들을 노션에 정리했으니 참고해주세요.

- [Terraform으로 인프라 자동화](https://www.notion.so/Terraform-69f91597baa042f1a90a45e0b8dcf899)
## Public Key 등록
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

## Author

👤 **Shinhyeong Park**

* Website: https://github.com/ShinhyeongPark
* Github: [@Shinhyeong Park](https://github.com/Shinhyeong Park)

## Show your support

Give a ⭐️ if this project helped you!

***
_This README was generated with ❤️ by [readme-md-generator](https://github.com/kefranabg/readme-md-generator)_