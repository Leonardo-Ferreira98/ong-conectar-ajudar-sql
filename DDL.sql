/*
 * SCRIPT DDL - SISTEMA DE GESTÃO ONG CONECTAR & AJUDAR
 * DESCRIÇÃO: Criação das estruturas de dados normalizadas (3FN)
 */

CREATE DATABASE IF NOT EXISTS ong_conectar_ajudar;
USE ong_conectar_ajudar;

-- 1. Tabela de Doadores
CREATE TABLE DOADOR (
    id_doador INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf_cnpj VARCHAR(18) UNIQUE NOT NULL,
    email VARCHAR(100),
    telefone VARCHAR(20),
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 2. Tabela de Voluntários
CREATE TABLE VOLUNTARIO (
    id_voluntario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    email VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    data_nascimento DATE,
    habilidades TEXT
);

-- 3. Tabela de Beneficiários
CREATE TABLE BENEFICIARIO (
    id_beneficiario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE,
    data_nascimento DATE,
    endereco VARCHAR(255),
    situacao_social TEXT,
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 4. Tabela de Projetos
CREATE TABLE PROJETO (
    id_projeto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    data_inicio DATE NOT NULL,
    data_fim_prevista DATE,
    status ENUM('Planejamento', 'Ativo', 'Concluido', 'Cancelado') DEFAULT 'Planejamento'
);

-- 5. Tabela de Doações
CREATE TABLE DOACAO (
    id_doacao INT AUTO_INCREMENT PRIMARY KEY,
    id_doador INT NOT NULL,
    id_projeto INT,
    data_doacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    valor DECIMAL(10, 2),
    tipo_doacao ENUM('Dinheiro', 'Alimento', 'Roupa', 'Outros') NOT NULL,
    status_confirmacao BOOLEAN DEFAULT FALSE,
    CONSTRAINT fk_doacao_doador FOREIGN KEY (id_doador) REFERENCES DOADOR(id_doador),
    CONSTRAINT fk_doacao_projeto FOREIGN KEY (id_projeto) REFERENCES PROJETO(id_projeto)
);

-- 6. Tabela de Estoque
CREATE TABLE ITEM_ESTOQUE (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    nome_item VARCHAR(50) NOT NULL,
    descricao VARCHAR(200),
    unidade_medida VARCHAR(20) DEFAULT 'Unidade',
    quantidade_atual INT DEFAULT 0
);

-- 7. Tabela de Despesas
CREATE TABLE DESPESA (
    id_despesa INT AUTO_INCREMENT PRIMARY KEY,
    id_projeto INT NOT NULL,
    descricao VARCHAR(200) NOT NULL,
    valor DECIMAL(10, 2) NOT NULL,
    data_despesa DATE NOT NULL,
    categoria VARCHAR(50),
    CONSTRAINT fk_despesa_projeto FOREIGN KEY (id_projeto) REFERENCES PROJETO(id_projeto)
);

-- 8. Tabela Associativa: Alocação de Voluntários (N:N resolvida)
CREATE TABLE ALOCACAO_VOLUNTARIO (
    id_projeto INT NOT NULL,
    id_voluntario INT NOT NULL,
    data_alocacao DATE NOT NULL,
    funcao_desempenhada VARCHAR(50),
    PRIMARY KEY (id_projeto, id_voluntario),
    CONSTRAINT fk_aloc_projeto FOREIGN KEY (id_projeto) REFERENCES PROJETO(id_projeto),
    CONSTRAINT fk_aloc_voluntario FOREIGN KEY (id_voluntario) REFERENCES VOLUNTARIO(id_voluntario)
);

-- 9. Tabela Associativa: Atendimentos (N:N resolvida e Saída de Itens)
CREATE TABLE ATENDIMENTO (
    id_atendimento INT AUTO_INCREMENT PRIMARY KEY,
    id_beneficiario INT NOT NULL,
    id_projeto INT NOT NULL,
    data_atendimento DATETIME DEFAULT CURRENT_TIMESTAMP,
    observacoes TEXT,
    CONSTRAINT fk_atend_beneficiario FOREIGN KEY (id_beneficiario) REFERENCES BENEFICIARIO(id_beneficiario),
    CONSTRAINT fk_atend_projeto FOREIGN KEY (id_projeto) REFERENCES PROJETO(id_projeto)
);

-- 10. Tabela Associativa: Saída de Insumos por Atendimento
CREATE TABLE SAIDA_INSUMO (
    id_saida INT AUTO_INCREMENT PRIMARY KEY,
    id_atendimento INT NOT NULL,
    id_item INT NOT NULL,
    quantidade INT NOT NULL,
    CONSTRAINT fk_saida_atend FOREIGN KEY (id_atendimento) REFERENCES ATENDIMENTO(id_atendimento),
    CONSTRAINT fk_saida_item FOREIGN KEY (id_item) REFERENCES ITEM_ESTOQUE(id_item)
);