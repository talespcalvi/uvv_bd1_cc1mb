-- Tales Paiva Calvi
-- CC1Mb

-- Apaga o Banco de dados já existente
DROP DATABASE IF EXISTS uvv;

-- Apaga o usuário já existente
DROP USER IF EXISTS tales;

-- Cria o Usuário
CREATE USER tales WITH
SUPERUSER
CREATEDB
CREATEROLE
REPLICATION
BYPASSRLS;

-- Cria o Banco de dados
CREATE DATABASE uvv WITH
TEMPLATE = template0
ENCODING = 'UTF8'
LC_COLLATE = 'pt_BR.UTF-8'
LC_CTYPE = 'pt_BR.UTF-8'
ALLOW_CONNECTIONS = TRUE;

-- Troca a conexão

-- Apaga o schema já existente
DROP SCHEMA IF EXISTS lojas;

-- Cria o schema
CREATE SCHEMA lojas;

-- Ajusta o schema de usuário
ALTER USER tales
SET SEARCH_PATH TO lojas, "$user", public;

-- Apaga tabelas já existentes
DROP TABLE IF EXISTS clientes,
                     produtos,
                     estoques,
                     pedidos,
                     pedidos_itens,
                     lojas,
                     envios
CASCADE;

-- Cria a tabela clientes
CREATE TABLE public.clientes (
                cliente_id NUMERIC(38)   NOT NULL,
                email      VARCHAR(255)  NOT NULL,
                nome       VARCHAR(255)  NOT NULL,
                telefone1  VARCHAR(20),
                telefone2  VARCHAR(20),
                telefone3  VARCHAR(20),

-- Cria a primary key
  CONSTRAINT pk_clientes PRIMARY KEY (cliente_id)
);

-- Cria a tabela produtos
CREATE TABLE public.produtos (
                produto_id                NUMERIC(38)  NOT NULL,
                nome                      VARCHAR(255) NOT NULL,
                preco_unitario            NUMERIC(10,2),
                detalhes                  BYTEA,
                imagem                    BYTEA,
                imagem_mime_type          VARCHAR(512),
                imagem_arquivo            VARCHAR(512),
                imagem_charset            VARCHAR(512),
                imagem_ultima_atualizacao DATE,

-- Cria a primary key
  CONSTRAINT pk_produtos PRIMARY KEY (produto_id)
);

-- Cria a tabela lojas
CREATE TABLE public.lojas (
                loja_id                 NUMERIC(38)  NOT NULL,
                nome                    VARCHAR(255) NOT NULL,
                endereco_web            VARCHAR(100),
                endereco_fisico         VARCHAR(512),
                latitude                NUMERIC,
                longitude               NUMERIC,
                logo                    BYTEA,
                logo_mime_type          VARCHAR(512),
                logo_arquivo            VARCHAR(512),
                logo_charset            VARCHAR(512),
                logo_ultima_atualizacao DATE,

-- Cria a primary key
  CONSTRAINT pk_lojas PRIMARY KEY (loja_id)
);

-- Cria a tabela envios
CREATE TABLE public.envios (
                envio_id         NUMERIC(38)  NOT NULL,
                cliente_id       NUMERIC(38)  NOT NULL,
                loja_id          NUMERIC(38)  NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                status           VARCHAR(15)  NOT NULL,
                
-- Cria a primary key
  CONSTRAINT pk_envios PRIMARY KEY (envio_id)
);

-- Cria a tabela estoques
CREATE TABLE public.estoques (
                estoque_id NUMERIC(38) NOT NULL,
                loja_id    NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,

-- Cria a primary key
  CONSTRAINT pk_estoques PRIMARY KEY (estoque_id)
);

-- Cria a tabela pedidos
CREATE TABLE public.pedidos (
                pedido_id  NUMERIC(38) NOT NULL,
                data_hora  TIMESTAMP   NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                status     VARCHAR(15) NOT NULL,
                loja_id    NUMERIC(38) NOT NULL,
                
-- Cria a primary key
  CONSTRAINT pk_pedidos PRIMARY KEY (pedido_id)
);

-- Cria a tabela pedidos_itens
CREATE TABLE public.pedidos_itens (
                pedido_id       NUMERIC(38)   NOT NULL,
                produto_id      NUMERIC(38)   NOT NULL,
                numero_da_linha NUMERIC(38)   NOT NULL,
                preco_unitario  NUMERIC(10,2) NOT NULL,
                quantidade      NUMERIC(38)   NOT NULL,
                envio_id        NUMERIC(38)   NOT NULL,

-- Cria a primary key
  CONSTRAINT pk_pedidos_itens PRIMARY KEY (pedido_id, produto_id)
);

-- Cria as relações entre as tabelas
ALTER TABLE public.pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES public.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES public.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES public.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES public.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES public.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES public.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES public.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES public.envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES public.pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
