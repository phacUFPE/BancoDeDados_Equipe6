CREATE TABLE paciente(
    CPF INT PRIMARY KEY,
    nome VARCHAR(255),
    data_nascimento DATE,
    CPF_responsavel INT,
    paciente_TIPO INT
);

CREATE TABLE prontuario(
    cod_paciente INT PRIMARY KEY,
    informacoes VARCHAR(500),
    foto_paciente BLOB
);

CREATE TABLE ambulatorio(
    cod_ambulatorio INT PRIMARY KEY,
    nome VARCHAR(255)
);

CREATE TABLE hospital(
    CNPJ VARCHAR(18) PRIMARY KEY,
    nome VARCHAR(255)
);

CREATE TABLE funcionario(
    CPF INT PRIMARY KEY,
    nome VARCHAR(255),
    endereco VARCHAR(255),
    data_nascimento DATE,
    data_contratacao DATE,
    COREN VARCHAR(9) UNIQUE,
    cod_tarefas INT,
    CRM VARCHAR(13) UNIQUE,
    funcionario_tipo VARCHAR(255)
);

CREATE TABLE telefone_paciente(
    cod_paciente INT PRIMARY KEY,
    telefone VARCHAR(14),
    CONSTRAINT fk_tel_pac FOREIGN KEY (cod_paciente) REFERENCES paciente(CPF) ON DELETE CASCADE
);

CREATE TABLE telefone_funcionario(
    cod_funcionario INT PRIMARY KEY,
    telefone VARCHAR(14),
    CONSTRAINT fk_tel_func FOREIGN KEY (cod_funcionario) REFERENCES funcionario(CPF) ON DELETE CASCADE
);

CREATE TABLE tarefas(
    cod_tarefa INT NOT NULL,
    tarefas VARCHAR(255),
    CONSTRAINT pk_tarefas PRIMARY KEY (cod_tarefa, tarefas)
);

CREATE TABLE hospital_ambulatorio(
    cod_ambulatorio INT,
    cod_hospital VARCHAR(18),
    CONSTRAINT pk_hosp_amb PRIMARY KEY (cod_ambulatorio, cod_hospital),
    CONSTRAINT hosp_amb_amb_fk FOREIGN KEY (cod_ambulatorio) REFERENCES ambulatorio(cod_ambulatorio) ON DELETE CASCADE,
    CONSTRAINT host_amb_hosp_fk FOREIGN KEY (cod_hospital) REFERENCES hospital(CNPJ) ON DELETE CASCADE
);

CREATE TABLE internado(
    cod_paciente INT,
    cod_hospital VARCHAR(18),
    data_internacao DATE,
    CONSTRAINT pk_internado PRIMARY KEY (cod_paciente, cod_hospital, data_internacao),
    CONSTRAINT hosp_inter_fk FOREIGN KEY (cod_hospital) REFERENCES hospital(CNPJ) ON DELETE CASCADE,
    CONSTRAINT pac_inter_fk FOREIGN KEY (cod_paciente) REFERENCES paciente(CPF) ON DELETE CASCADE
);

CREATE TABLE trabalha(
    cod_funcionario INT,
    cod_ambulatorio INT,
    CONSTRAINT pk_trabalha PRIMARY KEY (cod_funcionario, cod_ambulatorio),
    CONSTRAINT trab_func_fk FOREIGN KEY (cod_funcionario) REFERENCES funcionario(CPF) ON DELETE CASCADE,
    CONSTRAINT trab_amb_fk FOREIGN KEY (cod_ambulatorio) REFERENCES ambulatorio(cod_ambulatorio) ON DELETE CASCADE
);

CREATE TABLE cuida(
    cod_funcionario INT,
    cod_paciente INT,
    CONSTRAINT pk_cuida PRIMARY KEY (cod_funcionario, cod_paciente),
    CONSTRAINT cuida_func_fk FOREIGN KEY (cod_funcionario) REFERENCES funcionario(CPF) ON DELETE CASCADE,
    CONSTRAINT cuida_pac_fk FOREIGN KEY (cod_paciente) REFERENCES paciente(CPF) ON DELETE CASCADE
);

CREATE TABLE consulta(
    cod_funcionario INT,
    cod_paciente INT,
    CONSTRAINT pk_consulta PRIMARY KEY (cod_funcionario, cod_paciente),
    CONSTRAINT func_cons_fk FOREIGN KEY (cod_funcionario) REFERENCES funcionario(CPF) ON DELETE CASCADE,
    CONSTRAINT pac_cons_fk FOREIGN KEY (cod_paciente) REFERENCES paciente(CPF) ON DELETE CASCADE
);