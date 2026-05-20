# Performance Analysis

## Comparação de Performance

### Antes (Local)
- Tempo médio de query: a ser medido com `pgbench` e consultas de relatório
- Throughput: a ser medido com `queries/sec`
- Disponibilidade: depende da infraestrutura local

### Depois (RDS)
- Tempo médio de query: a ser medido após importação e testes
- Throughput: a ser medido com a mesma carga de trabalho
- Disponibilidade: maior com Multi-AZ configurado

## Análise
- A latência pode aumentar devido ao acesso em rede à instância RDS, mas a disponibilidade e a replicação de leitura compensam.
- O RDS fornece monitoramento integrado e backup automático, reduzindo o esforço operacional.
- Gargalos esperados: CPU e conexões simultâneas em instância `db.t3.micro`.
