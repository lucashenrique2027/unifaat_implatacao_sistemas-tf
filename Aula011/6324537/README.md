# TF11 - Sistema de Portfólio com S3 e CloudFront

**Disciplina:** Implementação de Sistemas  
**Curso:** Análise e Desenvolvimento de Sistemas - UniFAAT  
**Aluno:** Lucas Henrique  
**RA:** 6324537

## Visão Geral
Este projeto apresenta um portfólio profissional hospedado como site estático no Amazon S3 e distribuído via Amazon CloudFront. A solução inclui:
- Website responsivo e com navegação clara
- Formulário de contato serverless
- Scripts de infraestrutura para S3, CloudFront e políticas AWS
- Funções Lambda para backend de contato e processamento de imagens

## Estrutura do Projeto
- `website/` - arquivos do site estático
- `infrastructure/` - scripts AWS CLI para provisionamento
- `lambda/` - funções serverless para backend
- `docs/` - relatórios de performance, segurança e custo

## Como usar
1. Configure o AWS CLI:
   ```bash
   aws configure
   ```
2. Crie e configure os buckets S3:
   ```bash
   bash infrastructure/create-buckets.sh
   ```
3. Crie a distribuição CloudFront:
   ```bash
   bash infrastructure/setup-cloudfront.sh
   ```
4. Aplique políticas de bucket:
   ```bash
   bash infrastructure/configure-policies.sh
   ```
5. Opcionalmente, limpe os recursos:
   ```bash
   bash infrastructure/cleanup.sh
   ```

## Scripts de Infraestrutura
- `create-buckets.sh` - cria buckets S3 e publica o site estático
- `setup-cloudfront.sh` - cria distribuição CloudFront com redirecionamento HTTPS
- `configure-policies.sh` - aplica políticas de segurança nos buckets
- `cleanup.sh` - remove buckets S3 e objetos

## Notas importantes
- O formulário usa API Gateway + Lambda para envio e persistência de contatos.
- Os nomes de bucket foram prefixados com o RA para evitar colisões.
- O código pode ser adaptado para qualquer outro nome de bucket ou região da AWS.
