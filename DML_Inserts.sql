/*
 * SCRIPT DML - INSERÇÃO DE DADOS (POPULANDO O BANCO)
 * Projeto: ONG Conectar & Ajudar
 */

USE ong_conectar_ajudar;

-- 1. Inserindo DOADORES
INSERT INTO DOADOR (nome, cpf_cnpj, email, telefone) VALUES 
('João Silva', '111.222.333-00', 'joao@email.com', '(11) 99999-1111'),
('Empresa Tech Solutions', '12.345.678/0001-90', 'contato@techsol.com', '(11) 3030-4040'),
('Maria Oliveira', '222.333.444-55', 'maria.o@email.com', '(21) 98888-2222');

-- 2. Inserindo VOLUNTARIOS
INSERT INTO VOLUNTARIO (nome, cpf, email, telefone, habilidades) VALUES 
('Ana Souza', '333.444.555-66', 'ana.volunt@email.com', '(11) 97777-3333', 'Enfermagem, Primeiros Socorros'),
('Carlos Pereira', '444.555.666-77', 'carlos.p@email.com', '(11) 96666-4444', 'Cozinha, Logística'),
('Beatriz Lima', '555.666.777-88', 'bia.lima@email.com', '(31) 95555-5555', 'Recreação Infantil, Pintura');

-- 3. Inserindo BENEFICIARIOS
INSERT INTO BENEFICIARIO (nome, cpf, situacao_social, endereco) VALUES 
('José Santos', '666.777.888-99', 'Desempregado, 3 filhos', 'Rua da Esperança, 10'),
('Lucia Mendes', '777.888.999-00', 'Idosa sem renda', 'Av. Paz, 500'),
('Família Rocha', '888.999.000-11', 'Vítimas de enchente', 'Abrigo Municipal');

-- 4. Inserindo ITEM_ESTOQUE
INSERT INTO ITEM_ESTOQUE (nome_item, descricao, unidade_medida, quantidade_atual) VALUES 
('Cesta Básica', 'Arroz, feijão, óleo, sal, açúcar', 'Unidade', 50),
('Leite em Pó', 'Leite integral 400g', 'Lata', 100),
('Cobertor', 'Cobertor de casal térmico', 'Unidade', 30),
('Kit Higiene', 'Sabonete, pasta, escova', 'Kit', 40);

-- 5. Inserindo PROJETOS
INSERT INTO PROJETO (nome, descricao, data_inicio, status) VALUES 
('Sopa Solidária', 'Distribuição de sopa no centro', '2023-01-10', 'Ativo'),
('Natal Feliz', 'Entrega de brinquedos e cestas', '2023-12-01', 'Planejamento'),
('Inverno Quente', 'Doação de cobertores', '2023-06-01', 'Concluido');

-- --- AGORA AS TABELAS QUE DEPENDEM DAS OUTRAS ---

-- 6. Inserindo DOACOES (Depende de Doador e Projeto)
INSERT INTO DOACAO (id_doador, id_projeto, data_doacao, valor, tipo_doacao, status_confirmacao) VALUES 
(1, 1, '2023-02-15 10:00:00', 150.00, 'Dinheiro', TRUE),
(2, 2, '2023-11-20 14:30:00', 5000.00, 'Dinheiro', TRUE),
(1, 3, '2023-06-05 09:00:00', 200.00, 'Dinheiro', TRUE),
(3, 1, '2023-02-16 11:00:00', NULL, 'Alimento', TRUE);

-- 7. Inserindo DESPESAS (Depende de Projeto)
INSERT INTO DESPESA (id_projeto, descricao, valor, data_despesa, categoria) VALUES 
(1, 'Compra de legumes e carne', 350.00, '2023-02-14', 'Alimentação'),
(1, 'Gás de cozinha', 120.00, '2023-02-14', 'Infraestrutura'),
(3, 'Combustível para entrega', 80.00, '2023-06-10', 'Transporte');

-- 8. Inserindo ALOCACAO_VOLUNTARIO (Depende de Projeto e Voluntário)
INSERT INTO ALOCACAO_VOLUNTARIO (id_projeto, id_voluntario, data_alocacao, funcao_desempenhada) VALUES 
(1, 2, '2023-01-10', 'Cozinheiro'),
(1, 1, '2023-01-10', 'Auxiliar de Cozinha'),
(2, 3, '2023-11-25', 'Recreadora');

-- 9. Inserindo ATENDIMENTO (Depende de Beneficiário e Projeto)
INSERT INTO ATENDIMENTO (id_beneficiario, id_projeto, data_atendimento, observacoes) VALUES 
(1, 1, '2023-02-20 19:00:00', 'Recebeu 2 pratos de sopa'),
(2, 1, '2023-02-20 19:15:00', 'Recebeu 1 prato de sopa'),
(3, 3, '2023-06-15 08:00:00', 'Receberam 4 cobertores');

-- 10. Inserindo SAIDA_INSUMO (Depende de Atendimento e Estoque)
INSERT INTO SAIDA_INSUMO (id_atendimento, id_item, quantidade) VALUES 
(3, 3, 4);