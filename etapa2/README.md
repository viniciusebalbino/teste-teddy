Esta documentação explica os passos da etapa 2, provisionamento de infraestrutura na AWS usando Terraform, criação de um servidor Linux (EC2) pré-configurado com o Docker.

---

Objetivo e Arquitetura Modular

O objetivo é provisionar uma instância EC2 (Ubuntu) e sua infraestrutura de rede e segurança na AWS, utilizando a organização por módulos do Terraform para permitir a reutilização futura do código.

| Diretório/Módulo | Função Principal | Recursos AWS Provisionados |
| :--- | :--- | :--- |
| networking | Provisiona a infraestrutura de rede privada. | VPC, Subnets, Internet Gateway, Route Tables. |
| security | Define as regras de acesso à instância. | Security Group (Regras de entrada/saída, SSH e Porta 80). |
| ec2_docker | Provisiona a máquina virtual e instala o Docker. | EC2 Instance (Ubuntu), Key Pair. |
| userdata.sh | Script de post-configuration executado na EC2, contendo a lógica de instalação do Docker (o mesmo script da Etapa 1). | — |

> Nota de Melhoria: A configuração via userdata.sh é funcional, mas não é a melhor opção para gestão a longo prazo. A melhor prática seria utilizar uma ferramenta própria para post-configuration, como Ansible ou Chef.

---

1. Estrutura do Projeto Terraform (etapa2/)

O conceito de Módulos é utilizado para que o código seja reutilizável, isolando a lógica de provisionamento de recursos semelhantes.

etapa2/
├── _modules/
│   ├── ec2_docker/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── variables.tf
│   │   └── userdata.sh (Script de Instalação do Docker - O mesmo usado na etapa 1)
│   ├── networking/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── variables.tf
│   └── security/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── variables.tf
├── main.tf (Chama os módulos)
├── providers.tf (Define o provedor AWS)
└── README.md

---

2. Configuração e Fluxo de Dados

O arquivo main.tf na raiz chama os módulos definidos em _modules

O ec2_docker/userdata.sh é o script que prepara a máquina no momento do boot da instância.

---

3. Processo de Execução do Terraform

Para provisionar a infraestrutura, utilize os comandos padrão do Terraform, sempre executados a partir do diretório raiz (etapa2/):

é importante lembrar que a bucket definida para salvar o state do terraform em providers.tf deve estar criada dentro da conta da aws que será utilizada.

3.1. Inicialização

Baixa o plugin do provedor AWS e carrega as definições dos módulos:

terraform init

3.2. Planejamento

Cria um plano de execução, detalhando todos os recursos que serão criados.

terraform plan

3.3. Aplicação

Executa o plano, provisionando a infraestrutura na AWS:

terraform apply

Comando Útil: Para remover todos os recursos provisionados: terraform destroy