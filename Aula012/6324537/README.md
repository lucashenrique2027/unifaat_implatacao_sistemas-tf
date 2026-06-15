# Resolução TF12 - CI/CD Básico e Registro de Imagens (ECR)
**Aluno:** Lucas Henrique  
**RA:** 6324537  
**Disciplina:** Implementação de Servidor e Nuvem (Cloud)  
**Professor:** Tavares  

---

## Questão 1: Conceitos de CI/CD (Teórica)

a) **CI (Continuous Integration / Integração Contínua):** O objetivo principal é automatizar a fase de build e testes sempre que um desenvolvedor realiza um push de código para o repositório central (como o GitHub). O código é compilado, testado e empacotado em um artefato (no nosso caso, uma imagem Docker), garantindo a detecção precoce de bugs e a consistência do sistema.

b) **CD (Continuous Delivery ou Deployment / Entrega ou Implantação Contínua):** O objetivo principal é pegar o artefato validado na fase de CI (a imagem Docker armazenada no registro) e automatizar o seu deploy nos ambientes correspondentes. No *Continuous Delivery*, o deploy em produção exige aprovação manual; no *Continuous Deployment*, o artefato vai automaticamente para a produção assim que passa em todos os testes do pipeline.

---

## Questão 2: Ferramentas de Pipeline (Teórica)

Três ferramentas amplamente utilizadas para automatizar a fase de CI são:
1. **GitHub Actions** (Nativo do GitHub, baseado em arquivos YAML)
2. **Jenkins** (Ferramenta open-source clássica e altamente customizável)
3. **AWS CodeBuild** (Serviço gerenciado da AWS focado em compilar código e buildar imagens Docker)

---

## Questão 3: Amazon ECR (Teórica)

a) **Vantagem Principal:** A segurança e o controle de acesso granulares. Ao contrário de um repositório público no Docker Hub, o ECR integra-se nativamente com as políticas do **AWS IAM**, permitindo controlar exatamente quais usuários, serviços ou clusters (como o EKS) podem ler ou gravar imagens, além de criptografia automática e scanning nativo de vulnerabilidades.

b) **Escopo e Formato do URI:** O Amazon ECR é um serviço **Regional** (cada região possui seus próprios repositórios isolados).  
O formato padrão do URI de um repositório ECR é:  
`[ID_DA_CONTA_AWS].dkr.ecr.[REGIAO].amazonaws.com/[NOME_DO_REPOSITORIO]`

---

## Questão 4: Processo de Push (Prática Teórica)

1. **Passo de Autenticação:** É gerado um token temporário de acesso via **AWS CLI** que é repassado via pipeline para o cliente **Docker** se autenticar no servidor remoto da AWS (`docker login`).
2. **Passo de Tagging:** A imagem construída localmente é renomeada e marcada usando o cliente **Docker** (`docker tag`) para corresponder ao endereço exato (URI) do repositório de destino na AWS.
3. **Passo de Upload:** O cliente **Docker** executa o envio físico (`docker push`) das camadas da imagem para a infraestrutura do Amazon ECR.

---

## Questão 5: Tarefa Prática Integrada (Simulação)

Com base nos dados fornecidos:
* **AWS_ACCOUNT_ID:** `123456789012`
* **AWS_REGION:** `us-east-1`
* **REPO_NAME:** `web-app-repo`
* **IMAGE_TAG:** `v1`

### a) Criação do Repositório
```bash
aws ecr create-repository --repository-name web-app-repo --region us-east-1
eof
