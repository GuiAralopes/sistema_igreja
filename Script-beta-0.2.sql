BEGIN;
-- Criação do usuário para administrar o BD.
CREATE USER administrador WITH PASSWORD '123456' CREATEDB;

COMMIT;

-- Criação do Banco de dados

CREATE DATABASE sistema_igreja
    WITH 
    OWNER = administrador
    TEMPLATE = template0
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.UTF-8'
    LC_CTYPE = 'en_US.UTF-8'
    CONNECTION LIMIT = -1;

--Conectando ao banco de dados
\c sistema_igreja administrador;

--Criação d schema elmasri e autorização para o usuário criado anteriormente.
CREATE SCHEMA igreja  AUTHORIZATION administrador;

--Tornando o Schema igreja como padrão.
SET SEARCH_PATH TO igreja, "\$user", public;
select current_schema();

CREATE TABLE igreja.doacao (
                codigo_doacao CHAR(10) NOT NULL,
                nome_doador VARCHAR(255) NOT NULL,
                data_doacao DATE NOT NULL,
                tipo_doacao VARCHAR(9) NOT NULL,
                identificacao_doador CHAR(10) NOT NULL,
                CONSTRAINT doacao_pk PRIMARY KEY (codigo_doacao)
);
COMMENT ON COLUMN igreja.doacao.codigo_doacao IS 'Codigo de identificação do doador';
COMMENT ON COLUMN igreja.doacao.nome_doador IS 'nome do doador';
COMMENT ON COLUMN igreja.doacao.data_doacao IS 'data da doação';
COMMENT ON COLUMN igreja.doacao.tipo_doacao IS 'Tipo da doação';
COMMENT ON COLUMN igreja.doacao.identificacao_doador IS 'Identificação do doador';


CREATE TABLE igreja.trabalhos (
                codigo_doacao CHAR(10) NOT NULL,
                tipo_de_trabalho VARCHAR(50) NOT NULL,
                nome_doador VARCHAR(255) NOT NULL,
                CONSTRAINT trabalhos_pk PRIMARY KEY (codigo_doacao)
);
COMMENT ON TABLE igreja.trabalhos IS 'Trabalhos';
COMMENT ON COLUMN igreja.trabalhos.codigo_doacao IS 'Codigo de identificação da doação';
COMMENT ON COLUMN igreja.trabalhos.tipo_de_trabalho IS 'Tipo de Trabalho Doado';
COMMENT ON COLUMN igreja.trabalhos.nome_doador IS 'Nome doador';


CREATE TABLE igreja.monetarios (
                codigo_doacao CHAR(10) NOT NULL,
                valor_monetario NUMERIC(10,2) NOT NULL CHECK(valor_monetario > 0),
                tipo_moeda VARCHAR(10) NOT NULL,
                CONSTRAINT monetarios_pk PRIMARY KEY (codigo_doacao)
);
COMMENT ON TABLE igreja.monetarios IS 'Monetarios';
COMMENT ON COLUMN igreja.monetarios.codigo_doacao IS 'Codigo de identificação da doação';
COMMENT ON COLUMN igreja.monetarios.valor_monetario IS 'Valor da doação';
COMMENT ON COLUMN igreja.monetarios.tipo_moeda IS 'Tipo da moeda';


CREATE TABLE igreja.bens (
                codigo_doacao CHAR(10) NOT NULL,
                descricao VARCHAR(255) NOT NULL,
                tipo VARCHAR(255) NOT NULL,
                CONSTRAINT bens_pk PRIMARY KEY (codigo_doacao)
);
COMMENT ON TABLE igreja.bens IS 'Bens';
COMMENT ON COLUMN igreja.bens.codigo_doacao IS 'Codigo de identificação da doação';


CREATE TABLE igreja.membros (
                codigo_membro CHAR(10) NOT NULL,
                nome_completo VARCHAR(255) NOT NULL,
                profissao VARCHAR(50),
                data_nascimento DATE NOT NULL,
                estado_civil VARCHAR(20) NOT NULL,
                sexo CHAR(1) NOT NULL CHECK (sexo = 'm' OR sexo = 'f' OR sexo = 'M' OR sexo = 'F'),
                codigo_membro_colaborador CHAR(10) NOT NULL,
                Parent_codigo_membro CHAR(10) NOT NULL,
                CONSTRAINT membros_pk PRIMARY KEY (codigo_membro)
);
COMMENT ON TABLE igreja.membros IS 'Tabela Membros';
COMMENT ON COLUMN igreja.membros.codigo_membro IS 'codigo de identificação dos membros';
COMMENT ON COLUMN igreja.membros.nome_completo IS 'Nome completo do Membro';
COMMENT ON COLUMN igreja.membros.profissao IS 'Profissão do membro';
COMMENT ON COLUMN igreja.membros.data_nascimento IS 'Data de nascimento do membro';
COMMENT ON COLUMN igreja.membros.estado_civil IS 'Estado civil do membro';
COMMENT ON COLUMN igreja.membros.sexo IS 'Sexo dos membros';
COMMENT ON COLUMN igreja.membros.codigo_membro_colaborador IS 'Codigo de indentificação do membro colaborador';
COMMENT ON COLUMN igreja.membros.Parent_codigo_membro IS 'codigo de identificação dos membros';


CREATE TABLE igreja.telefone_membros (
                codigo_membro CHAR(10) NOT NULL,
                telefones VARCHAR(14) NOT NULL,
                CONSTRAINT telefone_membros_pk PRIMARY KEY (codigo_membro)
);
COMMENT ON TABLE igreja.telefone_membros IS 'Telefone dos membros';
COMMENT ON COLUMN igreja.telefone_membros.codigo_membro IS 'codigo de identificação dos membros';
COMMENT ON COLUMN igreja.telefone_membros.telefones IS 'Telefone dos membros';


CREATE TABLE igreja.endereco_membros (
                codigo_membro CHAR(10) NOT NULL,
                logradouro VARCHAR(150) NOT NULL,
                numero VARCHAR(10) NOT NULL,
                complemento VARCHAR(50) NOT NULL,
                bairro VARCHAR(50) NOT NULL,
                cidade VARCHAR(50) NOT NULL,
                UF CHAR(2) NOT NULL,
                CEP VARCHAR(10) NOT NULL,
                CONSTRAINT endereco_membros_pk PRIMARY KEY (codigo_membro)
);
COMMENT ON TABLE igreja.endereco_membros IS 'endereço dos membros';
COMMENT ON COLUMN igreja.endereco_membros.codigo_membro IS 'codigo de identificação dos membros';
COMMENT ON COLUMN igreja.endereco_membros.logradouro IS 'Logradouro';
COMMENT ON COLUMN igreja.endereco_membros.numero IS 'Número';
COMMENT ON COLUMN igreja.endereco_membros.complemento IS 'Complemento';
COMMENT ON COLUMN igreja.endereco_membros.bairro IS 'Bairro';
COMMENT ON COLUMN igreja.endereco_membros.cidade IS 'Cidade';
COMMENT ON COLUMN igreja.endereco_membros.UF IS 'Estado';
COMMENT ON COLUMN igreja.endereco_membros.CEP IS 'CEP';


CREATE TABLE igreja.imagens (
                codigo_imagem VARCHAR(10) NOT NULL,
                nome_imagem VARCHAR(10) NOT NULL,
                descricao_imagem VARCHAR(255) NOT NULL,
                data_registro DATE NOT NULL,
                codigo_comunidade CHAR(10) NOT NULL,
                CONSTRAINT imagens_pk PRIMARY KEY (codigo_imagem)
);
COMMENT ON COLUMN igreja.imagens.codigo_imagem IS 'Codigo de identificação da imagem';
COMMENT ON COLUMN igreja.imagens.nome_imagem IS 'nome da imagem';
COMMENT ON COLUMN igreja.imagens.descricao_imagem IS 'descrição da imagem';
COMMENT ON COLUMN igreja.imagens.codigo_comunidade IS 'codigo de identificação da comunidade';


CREATE TABLE igreja.destinacoes (
                codigo_recebedor CHAR(10) NOT NULL,
                data DATE NOT NULL,
                recebedor VARCHAR(255) NOT NULL,
                observacoes VARCHAR(100),
                imagem VARCHAR(10) NOT NULL,
                CONSTRAINT destinacoes_pk PRIMARY KEY (codigo_recebedor)
);
COMMENT ON TABLE igreja.destinacoes IS 'Tabela Destinações';
COMMENT ON COLUMN igreja.destinacoes.codigo_recebedor IS 'Codigo de identificação do recebedor';
COMMENT ON COLUMN igreja.destinacoes.data IS 'Data das Destinações';
COMMENT ON COLUMN igreja.destinacoes.recebedor IS 'Nome do Recebedor';
COMMENT ON COLUMN igreja.destinacoes.imagem IS 'Imagens';


CREATE TABLE igreja.atendidos (
                codigo_comunidade CHAR(10) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                CPF VARCHAR(14),
                CNPJ VARCHAR(18),
                codigo_imagem VARCHAR(10) NOT NULL,
                CONSTRAINT atendidos_pk PRIMARY KEY (codigo_comunidade)
);
COMMENT ON COLUMN igreja.atendidos.codigo_comunidade IS 'Codigo de identificação da comunidade';
COMMENT ON COLUMN igreja.atendidos.nome IS 'Nome dos Atendidos';
COMMENT ON COLUMN igreja.atendidos.CPF IS 'CPF';
COMMENT ON COLUMN igreja.atendidos.CNPJ IS 'CNPJ';
COMMENT ON COLUMN igreja.atendidos.codigo_imagem IS 'Codigo de identificação da imagem';


CREATE TABLE igreja.Recebem (
                codigo_recebedor CHAR(10) NOT NULL,
                codigo_comunidade CHAR(10) NOT NULL,
                codigo_doacao CHAR(10) NOT NULL,
                CONSTRAINT recebem_pk PRIMARY KEY (codigo_recebedor, codigo_comunidade, codigo_doacao)
);
COMMENT ON COLUMN igreja.Recebem.codigo_recebedor IS 'Codigo de identificação do recebedor';
COMMENT ON COLUMN igreja.Recebem.codigo_comunidade IS 'Codigo de identificação da comunidade';
COMMENT ON COLUMN igreja.Recebem.codigo_doacao IS 'Codigo de identificação do doador';


CREATE TABLE igreja.comunidades (
                codigo_comunidade CHAR(10) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                email VARCHAR(100) NOT NULL,
                CONSTRAINT comunidades_pk PRIMARY KEY (codigo_comunidade)
);
COMMENT ON COLUMN igreja.comunidades.codigo_comunidade IS 'Codigo de identificação da comunidade';
COMMENT ON COLUMN igreja.comunidades.nome IS 'Nome da Comunidade';
COMMENT ON COLUMN igreja.comunidades.email IS 'Email da Comunidade';


CREATE TABLE igreja.telefone_comunidade (
                codigo_comunidade CHAR(10) NOT NULL,
                telefones VARCHAR(14) NOT NULL,
                CONSTRAINT telefone_comunidade_pk PRIMARY KEY (codigo_comunidade)
);
COMMENT ON TABLE igreja.telefone_comunidade IS 'Telefone da Comunidade';
COMMENT ON COLUMN igreja.telefone_comunidade.codigo_comunidade IS 'Codigo de identificação da comunidade';
COMMENT ON COLUMN igreja.telefone_comunidade.telefones IS 'Telefone dos membros';


CREATE TABLE igreja.endereco_comunidades (
                codigo_comunidade CHAR(10) NOT NULL,
                logradouro VARCHAR(150) NOT NULL,
                numero VARCHAR(10) NOT NULL,
                complemento VARCHAR(50) NOT NULL,
                bairro VARCHAR(50) NOT NULL,
                cidade VARCHAR(50) NOT NULL,
                UF CHAR(2) NOT NULL,
                CEP VARCHAR(10) NOT NULL,
                CONSTRAINT endereco_comunidades_pk PRIMARY KEY (codigo_comunidade)
);
COMMENT ON TABLE igreja.endereco_comunidades IS 'endereço da comunidade';
COMMENT ON COLUMN igreja.endereco_comunidades.codigo_comunidade IS 'codigo de identificação das comunidades';
COMMENT ON COLUMN igreja.endereco_comunidades.logradouro IS 'Logradouro';
COMMENT ON COLUMN igreja.endereco_comunidades.numero IS 'Número';
COMMENT ON COLUMN igreja.endereco_comunidades.complemento IS 'Complemento';
COMMENT ON COLUMN igreja.endereco_comunidades.bairro IS 'Bairro';
COMMENT ON COLUMN igreja.endereco_comunidades.cidade IS 'Cidade';
COMMENT ON COLUMN igreja.endereco_comunidades.UF IS 'Estado';
COMMENT ON COLUMN igreja.endereco_comunidades.CEP IS 'CEP';


CREATE TABLE igreja.telefone_atendidos (
                codigo_comunidade CHAR(10) NOT NULL,
                telefones VARCHAR(14) NOT NULL,
                CONSTRAINT telefone_atendidos_pk PRIMARY KEY (codigo_comunidade)
);
COMMENT ON TABLE igreja.telefone_atendidos IS 'Telefone dos Atendidos';
COMMENT ON COLUMN igreja.telefone_atendidos.codigo_comunidade IS 'Codigo de identificação da comunidade';
COMMENT ON COLUMN igreja.telefone_atendidos.telefones IS 'Telefone dos membros';


CREATE TABLE igreja.programas (
                codigo_programa CHAR(10) NOT NULL,
                nome_programa VARCHAR(50) NOT NULL,
                descricao VARCHAR(300) NOT NULL,
                Objetivo VARCHAR(50) NOT NULL,
                data_inicio DATE NOT NULL,
                data_final_prevista DATE NOT NULL,
                codigo_comunidade CHAR(10) NOT NULL,
                codigo_membro CHAR(10) NOT NULL,
                codigo_imagem VARCHAR(10) NOT NULL,
                CONSTRAINT programas_pk PRIMARY KEY (codigo_programa)
);
COMMENT ON TABLE igreja.programas IS 'Tabela Programas';
COMMENT ON COLUMN igreja.programas.codigo_programa IS 'Código de identificação do Programa';
COMMENT ON COLUMN igreja.programas.nome_programa IS 'Nome do Programa';
COMMENT ON COLUMN igreja.programas.descricao IS 'Descrição do Programa';
COMMENT ON COLUMN igreja.programas.Objetivo IS 'Objetivo do Programa';
COMMENT ON COLUMN igreja.programas.data_final_prevista IS 'Previsão para o final';


ALTER TABLE igreja.Recebem ADD CONSTRAINT doacao_recebem_fk
FOREIGN KEY (codigo_doacao)
REFERENCES igreja.doacao (codigo_doacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE igreja.bens ADD CONSTRAINT doacao_bens_fk
FOREIGN KEY (codigo_doacao)
REFERENCES igreja.doacao (codigo_doacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE igreja.monetarios ADD CONSTRAINT doacao_monetarios_fk
FOREIGN KEY (codigo_doacao)
REFERENCES igreja.doacao (codigo_doacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE igreja.trabalhos ADD CONSTRAINT doacao_trabalhos_fk
FOREIGN KEY (codigo_doacao)
REFERENCES igreja.doacao (codigo_doacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE igreja.membros ADD CONSTRAINT membros_membros_fk
FOREIGN KEY (Parent_codigo_membro)
REFERENCES igreja.membros (codigo_membro)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE igreja.programas ADD CONSTRAINT membros_programas_fk
FOREIGN KEY (codigo_membro)
REFERENCES igreja.membros (codigo_membro)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE igreja.endereco_membros ADD CONSTRAINT membros_endereco_membros_fk
FOREIGN KEY (codigo_membro)
REFERENCES igreja.membros (codigo_membro)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE igreja.telefone_membros ADD CONSTRAINT membros_telefone_membros__fk
FOREIGN KEY (codigo_membro)
REFERENCES igreja.membros (codigo_membro)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE igreja.programas ADD CONSTRAINT imagens_programas_fk
FOREIGN KEY (codigo_imagem)
REFERENCES igreja.imagens (codigo_imagem)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE igreja.atendidos ADD CONSTRAINT imagens_atendidos_fk
FOREIGN KEY (codigo_imagem)
REFERENCES igreja.imagens (codigo_imagem)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE igreja.destinacoes ADD CONSTRAINT imagens_destinacoes_fk
FOREIGN KEY (imagem)
REFERENCES igreja.imagens (codigo_imagem)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE igreja.Recebem ADD CONSTRAINT destinacoes_recebem_fk
FOREIGN KEY (codigo_recebedor)
REFERENCES igreja.destinacoes (codigo_recebedor)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE igreja.telefone_atendidos ADD CONSTRAINT atendidos_telefone_atendidos_fk
FOREIGN KEY (codigo_comunidade)
REFERENCES igreja.atendidos (codigo_comunidade)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE igreja.comunidades ADD CONSTRAINT atendidos_comunidades_fk
FOREIGN KEY (codigo_comunidade)
REFERENCES igreja.atendidos (codigo_comunidade)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE igreja.Recebem ADD CONSTRAINT atendidos_recebem_fk
FOREIGN KEY (codigo_comunidade)
REFERENCES igreja.atendidos (codigo_comunidade)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE igreja.programas ADD CONSTRAINT comunidades_programas_fk
FOREIGN KEY (codigo_comunidade)
REFERENCES igreja.comunidades (codigo_comunidade)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE igreja.endereco_comunidades ADD CONSTRAINT comunidades_endereco_comunidades_fk
FOREIGN KEY (codigo_comunidade)
REFERENCES igreja.comunidades (codigo_comunidade)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE igreja.telefone_comunidade ADD CONSTRAINT comunidades_telefone_comunidade_fk
FOREIGN KEY (codigo_comunidade)
REFERENCES igreja.comunidades (codigo_comunidade)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE igreja.imagens ADD CONSTRAINT comunidades_imagens_fk
FOREIGN KEY (codigo_comunidade)
REFERENCES igreja.comunidades (codigo_comunidade)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
