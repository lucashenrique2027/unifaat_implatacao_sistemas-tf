# Troubleshooting

## Problemas comuns

### 1. Falha na conexão ao RDS
- Verifique se o `Security Group` permite acesso da sua rede ou do IP local.
- Confira se o endpoint e a porta estão corretos.
- Verifique se a instância está em estado `available`.

### 2. Erro de autenticação no `psql`
- Confirme usuário e senha.
- Verifique se a instância RDS aceita conexões na porta configurada.

### 3. Importação de dump falhando
- Valide se o dump foi gerado corretamente.
- Cheque permissões e codificação de caracteres.
- Remova objetos que possam conflitar com o schema existente.

### 4. Discrepância na contagem de linhas
- Compare tabelas críticas usando consultas `COUNT(*)`.
- Verifique se dados parciais foram importados.
- Refaça o dump e a importação se necessário.

## Dicas
- Use `aws rds describe-db-instances` para consultar o status da instância.
- Use CloudWatch Logs e Performance Insights para investigar lentidão.
- Mantenha logs e screenshots para documentar o processo.
