/* * SCRIPT DML - CONSULTAS E MANIPULAÇÃO
 * Objetivo: Testar SELECT, UPDATE e DELETE
 */

USE ong_conectar_ajudar;
SET SQL_SAFE_UPDATES = 0;

-- === 1. CONSULTAS (SELECT) ===

-- A) Listar todos os doadores e seus e-mails (Consulta Simples)
SELECT nome, email FROM DOADOR;

-- B) Listar apenas os Projetos que estão com status "Ativo" (Uso do WHERE)
SELECT * FROM PROJETO 
WHERE status = 'Ativo';

-- C) Listar doações em Dinheiro maiores que R$ 100,00, do maior para o menor (ORDER BY)
SELECT * FROM DOACAO 
WHERE tipo_doacao = 'Dinheiro' AND valor > 100.00
ORDER BY valor DESC;

-- D) Quem doou o quê? (JOIN - Juntando duas tabelas)
-- Mostra o nome do doador ao lado do valor da doação
SELECT DOADOR.nome AS Nome_Doador, DOACAO.valor, DOACAO.data_doacao
FROM DOADOR
INNER JOIN DOACAO ON DOADOR.id_doador = DOACAO.id_doador;

-- === 2. ATUALIZAÇÕES (UPDATE) ===

-- A) O voluntário Carlos mudou de telefone. Vamos atualizar:
UPDATE VOLUNTARIO 
SET telefone = '(11) 99999-8888' 
WHERE nome = 'Carlos Pereira';

-- B) O projeto "Natal Feliz" agora está Ativo:
UPDATE PROJETO 
SET status = 'Ativo' 
WHERE nome = 'Natal Feliz';

-- C) Ganhamos mais 50 latas de Leite em Pó. Vamos somar no estoque:
UPDATE ITEM_ESTOQUE
SET quantidade_atual = quantidade_atual + 50
WHERE nome_item = 'Leite em Pó';

-- === 3. EXCLUSÕES (DELETE) ===

-- A) Vamos excluir a despesa de ID 2 (fingindo que foi lançada errada)
DELETE FROM DESPESA 
WHERE id_despesa = 2;

-- B) Excluir itens de estoque que acabaram (quantidade 0)
DELETE FROM ITEM_ESTOQUE 
WHERE quantidade_atual = 0;