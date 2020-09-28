CREATE DATABASE grupo4;
USE grupo4 ;

-- Tabela "SETOR" --
CREATE TABLE SETOR(
  SET_CODIGO INT NOT NULL,
  SET_NOME VARCHAR(45) NOT NULL,
  PRIMARY KEY (SET_CODIGO)
  );
 
 -- Tabela "SUBSETOR"--
  CREATE TABLE SUBSETOR(
  SUB_CODIGO INT NOT NULL,
  SUB_NOME VARCHAR(45) NOT NULL,
  SET_CODIGO INT NOT NULL,
  PRIMARY KEY (SUB_CODIGO),
  CONSTRAINT fk_SUBSETOR_SETOR
    FOREIGN KEY (SET_CODIGO)
    REFERENCES SETOR(SET_CODIGO)
);

-- Tabela "SEGMENTO"--
CREATE TABLE SEGMENTO(
  SEG_CODIGO INT NOT NULL,
  SEG_NOME VARCHAR(45) NOT NULL,
  SUB_CODIGO INT NOT NULL,
  PRIMARY KEY (SEG_CODIGO),
  CONSTRAINT fk_SEGMENTO_SUBSETOR
    FOREIGN KEY (SUB_CODIGO)
    REFERENCES SUBSETOR (SUB_CODIGO)
);

-- Tabela "GOVERNANCA--
CREATE TABLE GOVERNANCA(
  GOV_CODIGO VARCHAR(3) NOT NULL,
  GOV_NOME VARCHAR(45) NOT NULL,
  PRIMARY KEY (GOV_CODIGO)
  );

-- Tabela "EMPRESA"--  
CREATE TABLE EMPRESA(
  EMP_CODIGO VARCHAR(12) NOT NULL,
  EMP_NOME VARCHAR(45) NOT NULL,
  GOV_CODIGO VARCHAR(3) NULL,
  SEG_CODIGO INT NOT NULL,
  PRIMARY KEY (EMP_CODIGO),
  CONSTRAINT fk_EMPRESA_GORVERNANCA
    FOREIGN KEY (GOV_CODIGO)
    REFERENCES GOVERNANCA (GOV_CODIGO),
  CONSTRAINT fk_EMPRESA_ECONOMICO
    FOREIGN KEY (SEG_CODIGO)
    REFERENCES SEGMENTO (SEG_CODIGO)
);

-- Tabela "ACAO"-- 
CREATE TABLE ACAO(
  ACAO_CODIGO VARCHAR(12) NOT NULL,
  EMP_CODIGO VARCHAR(12) NOT NULL,
  PRIMARY KEY (ACAO_CODIGO),
  CONSTRAINT fk_ACAO_EMPRESA
    FOREIGN KEY (EMP_CODIGO)
    REFERENCES EMPRESA (EMP_CODIGO)
);

-- Tabela "TIPO INDICE"--  
CREATE TABLE TIPO_INDICE (
  TIND_CODIGO INT NOT NULL,
  TIND_NOME VARCHAR(45) NOT NULL,
  PRIMARY KEY (TIND_CODIGO)
  );

-- Tabela INDICE --
CREATE TABLE INDICE(
  IND_SIGLA VARCHAR(8) NOT NULL,
  IND_NOME VARCHAR(45) NOT NULL,
  TIND_CODIGO INT NOT NULL,
  PRIMARY KEY (IND_SIGLA),
    CONSTRAINT fk_INDICE_TINDICE
    FOREIGN KEY (TIND_CODIGO)
    REFERENCES TIPO_INDICE(TIND_CODIGO)
);

-- Tabela LISTAGEM--
CREATE TABLE LISTAGEM(
  ACAO_CODIGO VARCHAR(12) NOT NULL,
  IND_SIGLA VARCHAR(8) NOT NULL,
  LIST_QUADRIMESTRE INT(4) NOT NULL,
  LIST_QTD_ACOES INT NOT NULL,
  LIST_ANO YEAR(4) NOT NULL,
  LIST_PERCENT_ACOES DECIMAL(6,3) NOT NULL,
  PRIMARY KEY (ACAO_CODIGO, IND_SIGLA),
  --
  -- duvida sobre nome da restricao fk
  --
	CONSTRAINT fk_ACAO_has_INDICE_ACAO1
    FOREIGN KEY (ACAO_CODIGO)
    REFERENCES ACAO (ACAO_CODIGO),
	CONSTRAINT fk_ACAO_INDICE
    FOREIGN KEY (IND_SIGLA)
    REFERENCES 	INDICE (IND_SIGLA)
);


-- Tabela COTACAO--
CREATE TABLE COTACAO (
  COT_PREGAO DATE NOT NULL,
  ACAO_CODIGO VARCHAR(12) NOT NULL,
  COT_PREABE DECIMAL(13,2) NOT NULL,
  COT_PREMAX DECIMAL(13,2) NOT NULL,
  COT_PREMIN DECIMAL(13,2) NOT NULL,
  COT_PREULT DECIMAL(13,2) NOT NULL,
  COT_TOTNEG INT(5) NOT NULL,
  COT_QUATOT INT(18) NOT NULL,
  COT_VOLTOT DECIMAL(18,2) NOT NULL,
  PRIMARY KEY (COT_PREGAO, ACAO_CODIGO),
	CONSTRAINT fk_COTACAO_ACAO
    FOREIGN KEY (ACAO_CODIGO)
    REFERENCES ACAO (ACAO_CODIGO)
);
