# TF10 - Migração para Amazon RDS

## Visão Geral
Este trabalho entrega a migração de um banco de dados PostgreSQL local para Amazon RDS PostgreSQL, seguindo as exigências de alta disponibilidade, backup automático e monitoramento.

## Arquitetura
### Antes
- Banco de dados local em container Docker Compose
- PostgreSQL rodando em ambiente local
- Backup manual e não automatizado

### Depois
- Amazon RDS PostgreSQL com Multi-AZ
- Segurança através de Security Groups e subnets privadas
- Monitoramento CloudWatch e Performance Insights

## Como Executar a Migração
1. Configure credenciais AWS no ambiente local.
2. Ajuste variáveis em `migration/create-rds.sh` e `migration/migrate-data.sh`.
3. Execute:
   - `bash migration/create-rds.sh`
   - `bash migration/migrate-data.sh`
   - `bash migration/validate-migration.sh`
4. Após testes, use `bash migration/cleanup.sh` para remover recursos temporários.

## Resultados Obtidos
- Estrutura de banco migrada para RDS
- Plano de rollback documentado
- Scripts de criação, migração, validação e limpeza
- Monitoramento inicial configurado com arquivos JSON de dashboard e alertas

## Custos e ROI
- Custo local estimado com hardware, energia e manutenção
- Custo RDS estimado com instância, storage e backup
- Recomendações para uso de Free Tier e desligamento após avaliação
