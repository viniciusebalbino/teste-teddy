# Documentação Geral do Projeto: Infraestrutura, Docker e CI/CD

Este repositório documenta as quatro etapas de um projeto que abrange desde a preparação inicial de um servidor Linux até o provisionamento de infraestrutura em nuvem (AWS) com Terraform e a implantação automatizada (CI/CD) de uma aplicação em ECS Fargate.

---

## Visão Geral das Etapas

O projeto está dividido em quatro fases progressivas, cada uma focada em uma camada diferente da solução:

| Etapa | Foco Principal | Ferramentas Chave | Produto Final |
| :--- | :--- | :--- | :--- |
| **Etapa 1** | Instalação e Configuração Local | Ubuntu Server, Script Shell (`.sh`), Docker Compose | Servidor Linux preparado com Docker e aplicação Nginx rodando. |
| **Etapa 2** | Provisionamento da Infraestrutura | **Terraform**, AWS EC2, `userdata.sh` | Servidor EC2 provisionado na AWS, com Docker instalado via `userdata.sh`. |
| **Etapa 3** | CI/CD e Orquestração em Nuvem | **Terraform** (Módulos), AWS ECS Fargate, GitHub Actions | Pipeline CI/CD automatizada construindo e implantando a aplicação em um Cluster ECS Fargate. |
| **Etapa 4** | Monitoramento | AWS CloudWatch | Estrutura mínima de monitoramento para Tasks e Logs do ECS Fargate. |

---
Dentro de cada um dos diretórios, existe mais um README.md, com a documentação especifica e mais detalhada daquela etapa.

## 1. Etapa 1: Preparação e Configuração Local

Esta etapa inicial foca na preparação de um ambiente Linux local (Ubuntu Server) para hospedar contêineres Docker.

* **Ação:** Instalação do Docker Engine e Docker Compose.
* **Detalhe:** Um script Shell (`.sh`) automatiza a atualização do sistema e a instalação de todas as dependências do Docker.
* **Execução:** A aplicação (Nginx) é testada localmente via `docker compose up -d`, utilizando um mapeamento de volume para servir um arquivo `index.html` personalizado.

## 2. Etapa 2: Provisionamento de Infraestrutura (Terraform)

Esta etapa migra o conceito de servidor preparado para a nuvem AWS, utilizando a abordagem de **Infraestrutura como Código (IaC)** com Terraform.

* **Estrutura:** O código é modularizado (`_modules/`) para provisionar a rede (`networking`), a segurança (`security`) e a instância EC2 com Docker (`ec2_docker`).
* **Configuração Remota:** O script de instalação do Docker (da Etapa 1) é executado na EC2 através do `userdata.sh` no momento do *boot*.
* **Uso:** A infraestrutura é gerenciada através do fluxo padrão do Terraform: `terraform init`, `terraform plan`, `terraform apply`.

## 3. Etapa 3: CI/CD e Implantação em ECS Fargate

Esta etapa representa a arquitetura final de entrega contínua, utilizando serviços gerenciados da AWS para hospedagem escalável de contêineres.

* **Infraestrutura ECS:** O Terraform provisiona o Cluster ECS Fargate, o ECR (Registry de Imagens), e a Task Definition inicial.
* **Pipeline CI/CD:** O *workflow* no diretório `.github/workflows/deploy.yaml` (usando **GitHub Actions**) é o responsável pelo fluxo de CI/CD:
    1.  **Build:** Cria a imagem Docker da aplicação (`app/Dockerfile`).
    2.  **Push:** Envia a imagem para o ECR.
    3.  **Deploy:** Atualiza o Serviço ECS com a nova imagem, implantando a aplicação.

## 4. Etapa 4: Monitoramento Mínimo (CloudWatch)

A solução de monitoramento é um requisito fundamental que foi integrado diretamente na fase de provisionamento da Etapa 3.

* **Solução:** O monitoramento é implementado utilizando o **AWS CloudWatch**, que coleta métricas nativas das tasks que rodam dentro do ECS Fargate.
* **Localização:** O módulo Terraform `terraform/_modules/monitoring` é o responsável por garantir que as tasks e serviços tenham a configuração necessária para:
    * Enviar logs dos contêineres para o **CloudWatch**.
    * Disponibilizar **Métricas de CPU e Memória e tabém uma que monitora se o serviço está up ou down, de acordo com a task** para observabilidade básica.

---

Para acessar a documentação detalhada de cada etapa, navegue pelos respectivos diretórios do repositório.