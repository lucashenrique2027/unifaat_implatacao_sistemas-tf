# Plano de Migração

## Análise do Estado Atual
- Banco local: PostgreSQL em container `docker-compose`
- Banco alvo: Amazon RDS PostgreSQL Multi-AZ
- Tamanho estimado do banco: análise manual baseada em `db/northwind.sql`
- Queries críticas: relatórios de vendas, consultas de clientes e pedidos

## Estratégia de Migração
- Engine escolhida: PostgreSQL
- Classe de instância: `db.t3.micro` (Free Tier / custo reduzido)
- Storage: 20 GB gp3
- Multi-AZ: Sim, para alta disponibilidade
- Backup retention: 7 dias

## Processo de Migração
1. Criar instância RDS com configuração básica e segurança mínima.
2. Exportar schema e dados do banco local para dump SQL.
3. Importar o dump no RDS.
4. Validar contagens de tabelas e integridade de dados.

## Plano de Rollback
- Se a migração falhar, manter o banco local ativo até correção.
- Voltar ao banco local removendo configurações temporárias do RDS.
- Se necessário, restaurar a instância RDS de snapshot manual.
