-- ESTA PODE NÃO ESTAR CERTA
CREATE OR REPLACE TRIGGER funcionario_tarefas ON tarefas BEFORE INSERT
AS
DECLARE
    max_trf INT NOT NULL DEFAULT 10;
    trf_count INT NOT NULL DEFAULT 0;
BEGIN
    SELECT COUNT(*) INTO trf_count FROM tarefas WHERE cod_funcionario = :new.cod_funcionario;
    IF trf_count > max_trf THEN
        dbms_output.put_line('Este funcionario nao pode ter mais tarefas!');
    END IF;
END;

----------------------------

CREATE OR REPLACE FUNCTION dependente (var_cpf IN paciente.cpf%type)
RETURN BOOLEAN
IS
   nome_paciente paciente.nome%type;
   var_tipo paciente.paciente_tipo%type;

BEGIN
    SELECT nome, paciente_tipo INTO nome_paciente, var_tipo FROM paciente WHERE cpf = var_cpf;
    IF var_tipo = 2 THEN
        RETURN TRUE;
    END IF;
    RETURN FALSE;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('Paciente nao encontrado!');
    WHEN OTHERS THEN
        dbms_output.put_line('Erro desconhecido!');
END;