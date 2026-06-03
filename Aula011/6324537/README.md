cat > Aula011/6324537/README.md << 'EOF'
# TF11 - Sistema de Portfólio com S3 e CloudFront

**Disciplina:** Implementação de Sistemas  
**Curso:** Análise e Desenvolvimento de Sistemas (5º Semestre) - UniFAAT  
**Aluno:** Lucas Henrique  
**RA:** 6324537  

## 📑 Visão Geral
Este projeto consiste na arquitetura e estruturação de um Portfólio Profissional focado em soluções Full Stack e DevOps, utilizando serviços serverless da AWS (Amazon S3 e CloudFront CDN) para garantir alta disponibilidade, segurança (HTTPS) e entrega de conteúdo de baixa latência global.

## 📐 Arquitetura do Sistema
A infraestrutura foi desenhada seguindo as melhores práticas de desacoplamento e segurança na nuvem:
- **Camada de Apresentação:** Hospedagem estática no Amazon S3 (Website Hosting).
- **Camada de Distribuição:** CloudFront integrado com políticas de cache otimizadas e redirecionamento obrigatório de HTTP para HTTPS.
- **Camada de Assets:** Bucket S3 secundário dedicado para armazenamento isolado de mídias e documentos.
- **Camada Backend (Serverless):** API Gateway gerenciando requisições do formulário e acionando funções AWS Lambda para persistência de dados no DynamoDB e notificações via SES.

## 🛠️ Tecnologias Utilizadas
- **Hospedagem:** Amazon S3 (Static Website Hosting)
- **Aceleração/CDN:** Amazon CloudFront
- **Backend:** AWS Lambda & API Gateway (Arquitetura Serverless)
- **Banco de Dados:** Amazon DynamoDB
- **Automação:** AWS CLI e Shell Scripting (`.sh`)
- **Frontend:** HTML5 Semântico, CSS3 (Flexbox/Grid) e JavaScript ES6+

## 🔗 URLs do Projeto (Planejadas)
- **Distribuição CloudFront:** `https://d1234567890f.cloudfront.net`
- **Endpoint S3 Website:** `http://lucas-portfolio-website-6324537.s3-website-us-east-1.amazonaws.com`

## ⚙️ Como Executar a Automação

1. Certifique-se de ter o AWS CLI instalado e configurado em seu ambiente:
   ```bash
   aws configure