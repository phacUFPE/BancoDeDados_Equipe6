CREATE OR REPLACE TRIGGER funcionario_tarefas BEFORE INSERT ON tarefas FOR EACH ROW
DECLARE
    max_trf INT NOT NULL DEFAULT 5;
    trf_count INT NOT NULL DEFAULT 0;
BEGIN
    SELECT COUNT(*) INTO trf_count FROM tarefas WHERE cod_funcionario = :new.cod_funcionario) > max_trf;
    IF trf_count >= max_trf THEN
        RAISE_APPLICATION_ERROR(-20343, 'Funcionarios nao podem ter mais de 5 tarefas.');
    END IF;
END;

CREATE OR REPLACE FUNCTION dependente(var_cpf paciente.cpf%type)
RETURN VARCHAR
IS
    var_tipo paciente.paciente_tipo%type;
    resultado VARCHAR(15);
BEGIN
    SELECT paciente_tipo INTO var_tipo FROM paciente WHERE cpf = var_cpf;
    IF var_tipo = 1 THEN
        resultado := 'Nao dependente';
    ELSE
        resultado := 'Dependente';
    END IF;
    RETURN resultado;
END;

SELECT dependente(11176654943) FROM dual;

CREATE OR REPLACE PROCEDURE listar_pacientes_tipo(tipo paciente.paciente_tipo%type)
AS
    CURSOR pac IS SELECT * FROM paciente;
    pac_r pac%ROWTYPE;
BEGIN
    OPEN pac;
    IF tipo = 1 THEN
        dbms_output.put_line('Nao depedentes:');
    ELSIF tipo = 2 THEN
        dbms_output.put_line('Depedentes:');
    ELSE
        RAISE_APPLICATION_ERROR(-20343, 'Numero fora do intervalo (1,2)');
    END IF;
    LOOP
        FETCH pac INTO pac_r;
        IF pac_r.paciente_tipo = tipo THEN
            dbms_output.put_line(pac_r.cpf || ' | ' || pac_r.nome);
        END IF;
        EXIT WHEN pac%NOTFOUND;
    END LOOP;
    CLOSE pac;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('Paciente nao encontrado!');
END;

EXEC listar_pacientes_tipo(1);

CREATE OR REPLACE TRIGGER verificar_paciente_tipo
BEFORE INSERT OR UPDATE ON paciente
FOR EACH ROW
BEGIN
    IF :new.paciente_tipo NOT IN (1, 2) THEN
        RAISE_APPLICATION_ERROR(-20015, 'Os tipos permitidos sao 1 ou 2.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Operacao realizada com sucesso.');
    END IF; 
END;

CREATE OR REPLACE TRIGGER verificar_funcionario_tipo
BEFORE INSERT OR UPDATE ON funcionario
FOR EACH ROW
BEGIN
    IF :new.funcionario_tipo NOT IN (1, 2) THEN
        RAISE_APPLICATION_ERROR(-20015, 'Os tipos permitidos sao 1 ou 2.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Operacao realizada com sucesso.');
    END IF; 
END;