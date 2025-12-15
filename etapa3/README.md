**Documentação de Pipeline CI/CD para ECS Fargate (Etapa 3)**

Baseado em um cenário ao qual temos uma
necessidade de ser realizado um CI/CD para uma
aplicação. Essa aplicação é um simples MVP ao qual
roda em um servidor WEB Apache2 ou Ngnix.
Portanto, é necessário que seja feito um CI/CD que
envolva a aplicação em Apache2 ou Ngnix sendo
feito o deploy em um custer em ECS
Fargate. Certifique-se de mencionar os arquivos e
recursos relevantes.

Esta etapa detalha a arquitetura de **CI/CD** para um MVP baseado em servidor web, com deploy em **AWS ECS Fargate**, utilizando **Terraform** para infraestrutura e **GitHub Actions** para a pipeline.

**Arquitetura e Fluxo de CI/CD**

O fluxo da solução é dividido em duas partes principais: **Infraestrutura como Código (IaC)**, gerenciada pelo Terraform, e **Pipeline de Entrega**, gerenciada pelo GitHub Actions.

1. **Terraform:** Provisiona todos os recursos da AWS (ECS Cluster, ECR, VPC, IAM, etc.).
2. **GitHub Actions:** Constrói a imagem da aplicação e a implanta no ECS.

**1. Estrutura de Diretórios e Componentes**

| Diretório/Arquivo | Propósito | Recursos Relevantes |
| :--- | :--- | :--- |
| **.github/workflows/deploy.yaml** | **Pipeline CI/CD (GitHub Actions)**. Responsável por: 1) Fazer o build da imagem Docker usando o Dockerfile em app/. 2) Enviar a imagem para o **ECR**. 3) Atualizar a **Task Definition** do ECS para apontar para a nova imagem. | docker/build-and-push, aws-actions/amazon-ecs-deploy-task-definition |
| **app/html/** | Contém o **HTML básico** da aplicação (MVP). | index.html (Conteúdo da aplicação). |
| **app/Dockerfile** | Instruções para construir a imagem Docker da aplicação, baseada em Nginx ou Apache2, incluindo o conteúdo de html/. | |
| **terraform/** | Raiz de toda a **Infraestrutura como Código (IaC)**. | Módulos e arquivos .tf. |

**2. Modularização da Infraestrutura (Terraform)**

O Terraform utiliza o conceito de **módulos (_modules)** para garantir que a criação de recursos sejabreutilizável:

* **ecs:** Cria o **cluster ECS**, o **Registry ECR** (onde as imagens são armazenadas), e a **Task Definition inicial** (usando Nginx de forma temporaria). Esta Task Definition é posteriormente atualizada pela pipeline, com a imagem da aplicação.
* **iam:** Define todas as **políticas e roles** (IAM Roles) necessárias, incluindo a Task Execution Role e a Task Role, garantindo permissões corretas para o ECS acessar outros serviços (como ECR e CloudWatch).
* **monitoring:** Provisiona recursos de **CloudWatch** para monitoramento das tasks. Atualmente monitora apenas uma task, conforme solicitado, mas pode ser escalado facilmente, com poucas alterações a nivel de código.
* **network:** Cria toda a infraestrutura de rede necessária: **VPC**, **Subnets**, **Route Tables** e **Security Groups**.

**3. Fluxo de Execução**

1. **Provisionar Infraestrutura (Terraform):** Rodar `terraform init`, `terraform plan`, e `terraform apply` no diretório `terraform/`.
2. **Primeiro Deploy (CI/CD):** Um push ou merge para o branch principal (`main`) dispara o workflow `deploy.yaml`, que constrói a imagem, envia ela para o ECR, e implanta a aplicação no ECS.