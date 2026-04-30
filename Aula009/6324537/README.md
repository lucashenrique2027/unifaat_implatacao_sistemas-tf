cat > 6324537/README.md << 'EOF'
# TF09 - Infraestrutura e Deploy de Portfólio na AWS
Estudante: Lucas Henrique Silva 
RA:6324537  
Disciplina: Implementação de Sistemas  
Instituição: UniFAAT

---

## 🎯 Objetivo do Projeto
Demonstrar a implementação de uma arquitetura segura na nuvem AWS, utilizando instâncias EC2 para hospedagem de uma aplicação Full Stack, isolada em uma VPC customizada com regras rígidas de segurança de rede.

## 🏗️ Arquitetura de Infraestrutura (VPC)
A rede foi planejada seguindo as boas práticas de segmentação:
 VPC: CIDR 10.0.0.0/16
 Subnet Pública: Destinada ao servidor de aplicação (Web/API), com acesso via Internet Gateway.
 Security Groups (Firewall):
     Entrada (Ingress): Portas 22 (SSH), 80 (HTTP) e 3000 (Node.js API).
     Saída (Egress): Tráfego livre para atualizações de pacotes.



## 🚀 Tecnologias Utilizadas
 Cloud: AWS (EC2, VPC, Security Groups).
 Backend: Node.js com Express.
 Frontend: Nginx servindo arquivos estáticos (HTML/CSS).
 Containerização: Docker e Docker Compose para orquestração dos serviços.

## 📂 Organização do Repositório
 `/application`: Contém o código fonte da aplicação e o `docker-compose.yml`.
 `/infrastructure`: Scripts `fake` (simulados) com a lógica de comandos AWS CLI para criação da rede.
 `/docs`: Documentação complementar e guias de troubleshooting.

## 🛠️ Como Executar (Ambiente AWS)
1. Configuração: Configurar credenciais via `aws configure`.
2. Rede: Executar o script em `/infrastructure/create-infrastructure.sh` para subir a VPC.
3. Deploy: - Acessar a instância EC2 via SSH.
   - Clonar este repositório.
   - Dentro da pasta `application`, executar:
     ```bash
     sudo docker-compose up -d --build
     ```

---
Nota: Este projeto foi desenvolvido como parte das atividades práticas da Aula 009. Os scripts de infraestrutura refletem a lógica necessária para o provisionamento via linha de comando (CLI).