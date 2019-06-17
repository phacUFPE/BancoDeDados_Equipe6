SELECT pac.nome as nome_responsavel, pac2.nome as nome_menor
FROM paciente pac 
INNER JOIN paciente pac2 ON pac.cpf = pac2.cpf_responsavel;

SELECT pac.nome, pront.informacoes FROM prontuario
INNER JOIN paciente pac ON pac.cpf = pront.cod_paciente
WHERE paciente_tipo = 2;

