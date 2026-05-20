# Análise de Custos

## Custo Local (mensal estimado)
- Hardware: estimativa de R$ 200,00 a R$ 300,00
- Energia: estimativa de R$ 50,00 a R$ 100,00
- Manutenção: estimativa de R$ 50,00
- Total estimado: R$ 300,00 a R$ 450,00

## Custo RDS (mensal real)
- Instância: `db.t3.micro` (Free Tier ou pequeno custo)
- Storage: 20GB gp3
- Backup: incluído no RDS com retenção de 7 dias
- Total estimado: a calcular com a AWS Pricing Calculator

## ROI e Recomendações
- O RDS reduz esforço operacional, aumenta disponibilidade e automatiza backups.
- Para cargas leves, manter `db.t3.micro` e 20GB é uma boa opção de custo-benefício.
- Recomenda-se desligar ou excluir instâncias de teste após avaliação para evitar custos residuais.
