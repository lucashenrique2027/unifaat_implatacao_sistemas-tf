-- Consultas de performance para análise RDS PostgreSQL

-- 1. Top 10 queries por tempo total de execução
SELECT query, calls, total_time, mean_time
FROM pg_stat_statements
ORDER BY total_time DESC
LIMIT 10;

-- 2. Consultas mais lentas atualmente
SELECT pid, query, state, wait_event_type, wait_event, now() - query_start AS duration
FROM pg_stat_activity
WHERE state <> 'idle'
ORDER BY duration DESC
LIMIT 10;

-- 3. Tamanho das tabelas críticas
SELECT schemaname, relname, pg_size_pretty(pg_total_relation_size(relid)) AS total_size
FROM pg_catalog.pg_statio_user_tables
ORDER BY pg_total_relation_size(relid) DESC
LIMIT 10;
