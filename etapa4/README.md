**Documentação de Monitoramento Mínimo (ECS Fargate) - Etapa 4**

**Objetivo**

O objetivo da Etapa 4 — **montar uma estrutura mínima, porém funcional de monitoramento para as tasks do ECS Fargate** — foi integralmente atendido durante a execução da Etapa 3 (Infraestrutura como Código com Terraform).

**Solução de Monitoramento Implementada**

O monitoramento mínimo é baseado no **AWS CloudWatch**, que é o serviço nativo da AWS para observabilidade.

**Conclusão da Etapa 4**

A solução de monitoramento mínimo está provisionada via Terraform no módulo `monitoring` e é baseada nos serviços do **CloudWatch Metrics** para garantir a visibilidade sobre a saúde e a performance das tasks do ECS Fargate.