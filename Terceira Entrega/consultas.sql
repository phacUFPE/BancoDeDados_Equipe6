SELECT pac.nome as nome_responsavel, pac2.nome as nome_dependente
FROM paciente pac
INNER JOIN paciente pac2 ON pac.cpf = pac2.cpf_responsavel;

SELECT pac.nome, pront.informacoes FROM prontuario
INNER JOIN paciente pac ON pac.cpf = pront.cod_paciente
WHERE paciente_tipo = 2;

SELECT pac.nome FROM paciente pac
WHERE NOT EXISTS
(SELECT * FROM internado inter
WHERE pac.cpf = inter.cod_paciente);

SELECT pac.nome as nome_paciente, func.nome as nome_funcionario
FROM paciente pac
INNER JOIN consulta cons ON cons.cod_paciente = pac.cpf
INNER JOIN funcionario func ON cons.cod_funcionario = func.cpf
WHERE func.cpf = 84758502975;

SELECT * FROM ambulatorio amb
WHERE NOT EXISTS
(SELECT * FROM funcionario func
INNER JOIN trabalha trab ON trab.cod_ambulatorio = amb.cod_ambulatorio);

SELECT func.nome, COUNT(trf.tarefas) FROM tarefas trf
INNER JOIN funcionario func ON func.cpf = trf.cod_funcionario
HAVING COUNT(trf.tarefas) >= 5;

SELECT hosp.nome FROM hospital hosp 
INNER JOIN hospital_ambulatorio ha ON ha.cod_hospital = hosp.CNPJ 
WHERE NOT EXISTS 
(SELECT * FROM ambulatorio amb WHERE amb.cod_ambulatorio = ha.cod_ambulatorio);