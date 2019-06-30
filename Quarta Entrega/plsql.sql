-- ESTA PODE NÃO ESTAR CERTA
CREATE OR REPLACE TRIGGER funcionario_tarefas BEFORE INSERT ON tarefas FOR EACH ROW
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

CREATE OR REPLACE PROCEDURE list_pacientes(tipo paciente.paciente_tipo%type)
AS
    CURSOR pac IS SELECT * FROM paciente;
    pac_r pac%ROWTYPE;
BEGIN
    OPEN pac;
    IF tipo = 1 THEN
        dbms_output.put_line('N�o depedentes:');
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

CREATE OR REPLACE TRIGGER verificaTipo
BEFORE INSERT OR UPDATE ON paciente
FOR EACH ROW
  BEGIN
    IF :NEW.tipo NOT IN (1, 2) THEN
        RAISE_APPLICATION_ERROR(-20015, 'Os tipos permitidos s�o 1 ou 2.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Opera��o realizada com sucesso.');
    END IF; 
  END verificaTipo;