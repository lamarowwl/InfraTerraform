# Terraform com Azure - Projeto de Criação de Infraestrutura Gratuita

Este projeto foi criado como exercício de aprendizado para usar o Terraform com a Azure, com foco em criar recursos gratuitos e reutilizáveis.

## ✅ Objetivo

Criar uma infraestrutura simples usando o plano gratuito do Azure, incluindo:

- Resource Group
- Virtual Network
- Subnet
- Network Interface
- Máquina Virtual Linux (Ubuntu)

---

## 📁 Estrutura de Arquivos

- `main.tf`: contém todos os recursos definidos com Terraform
- `variables.tf`: armazena as variáveis utilizadas no projeto
- `terraform.tfvars`: define os valores das variáveis
- `README.md`: este arquivo de documentação

---

## 🧠 Conceitos aprendidos

### 🔹 Recursos criados com Terraform

- `azurerm_resource_group`: cria um grupo de recursos
- `azurerm_virtual_network`: cria uma VNet
- `azurerm_subnet`: cria uma subnet
- `azurerm_network_interface`: conecta a VM à rede
- `azurerm_linux_virtual_machine`: cria uma VM Linux

### 🔹 Uso de variáveis (`variables.tf` + `terraform.tfvars`)
Aprendemos a separar os valores dos parâmetros sensíveis ou reutilizáveis usando arquivos `.tfvars`.

Exemplo:
```hcl
# variables.tf
variable "admin_password" {
  type        = string
  sensitive   = true
  description = "Senha de admin da VM"
}

# terraform.tfvars
admin_password = "SenhaForte123!"