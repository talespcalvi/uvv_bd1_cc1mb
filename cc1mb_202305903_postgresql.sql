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
CREATE TABLE lojas.clientes (
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
CREATE TABLE lojas.produtos (
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
CREATE TABLE lojas.lojas (
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
CREATE TABLE lojas.envios (
                envio_id         NUMERIC(38)  NOT NULL,
                cliente_id       NUMERIC(38)  NOT NULL,
                loja_id          NUMERIC(38)  NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                status           VARCHAR(15)  NOT NULL,
                
-- Cria a primary key
  CONSTRAINT pk_envios PRIMARY KEY (envio_id)
);

-- Cria a tabela estoques
CREATE TABLE lojas.estoques (
                estoque_id NUMERIC(38) NOT NULL,
                loja_id    NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,

-- Cria a primary key
  CONSTRAINT pk_estoques PRIMARY KEY (estoque_id)
);

-- Cria a tabela pedidos
CREATE TABLE lojas.pedidos (
                pedido_id  NUMERIC(38) NOT NULL,
                data_hora  TIMESTAMP   NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                status     VARCHAR(15) NOT NULL,
                loja_id    NUMERIC(38) NOT NULL,
                
-- Cria a primary key
  CONSTRAINT pk_pedidos PRIMARY KEY (pedido_id)
);

-- Cria a tabela pedidos_itens
CREATE TABLE lojas.pedidos_itens (
                pedido_id       NUMERIC(38)   NOT NULL,
                produto_id      NUMERIC(38)   NOT NULL,
                numero_da_linha NUMERIC(38)   NOT NULL,
                preco_unitario  NUMERIC(10,2) NOT NULL,
                quantidade      NUMERIC(38)   NOT NULL,
                envio_id        NUMERIC(38)   NOT NULL,

-- Cria a primary key
  CONSTRAINT pk_pedidos_itens PRIMARY KEY (pedido_id, produto_id)
);

-- Comenta a tabela clientes e suas colunas
COMMENT ON TABLE lojas.clientes IS 'Tabela referente às lojas';
COMMENT ON COLUMN lojas.clientes.cliente_id IS 'id do cliente';
COMMENT ON COLUMN lojas.clientes.email IS 'email dos clientes';
COMMENT ON COLUMN lojas.clientes.nome IS 'nome dos clientes';
COMMENT ON COLUMN lojas.clientes.telefone1 IS 'número de telefone dos clientes';
COMMENT ON COLUMN lojas.clientes.telefone2 IS 'número de telefone dos clientes';
COMMENT ON COLUMN lojas.clientes.telefone3 IS 'número de telefone dos clientes';

-- Comenta a tabela produtos e suas colunas
COMMENT ON TABLE lojas.produtos IS 'Tabela referente aos produtos';
COMMENT ON COLUMN lojas.produtos.produtos_id IS 'id dos produtos';
COMMENT ON COLUMN lojas.produtos.nome IS 'nome dos produtos';
COMMENT ON COLUMN lojas.produtos.preco_unitario 'preço unitário dos produtos';
COMMENT ON COLUMN lojas.produtos.detalhes 'detalhes dos produtos';
COMMENT ON COLUMN lojas.produtos.imagem 'imagem dos produtos';
COMMENT ON COLUMN lojas.produtos.imagem_mime_type 'imagens em MIME';
COMMENT ON COLUMN lojas.produtos.imagem_arquivo 'arquivo das imagens';
COMMENT ON COLUMN lojas.produtos.charset 'charset das imagens';
COMMENT ON COLUMN lojas.produtos.ultima_atualizacao 'última atualização das imagens';

-- Comenta a tabela lojas e suas colunas
COMMENT ON TABLE lojas.lojas IS 'Tabela referentes às lojas';
COMMENT ON COLUMN lojas.lojas.loja_id IS 'id das lojas';
COMMENT ON COLUMN lojas.lojas.nome IS 'nome das lojas';
COMMENT ON COLUMN lojas.lojas.endereco_web IS 'endereço web das lojas';
COMMENT ON COLUMN lojas.lojas.endereco_fisico IS 'endereço físico das lojas';
COMMENT ON COLUMN lojas.lojas.latitude IS 'latitude das lojas';
COMMENT ON COLUMN lojas.lojas.longitude IS 'longitude das lojas';
COMMENT ON COLUMN lojas.lojas.logo IS 'logo das lojas';
COMMENT ON COLUMN lojas.lojas.logo_mime_type IS 'logos em MIME';
COMMENT ON COLUMN lojas.lojas.logo_arquivo IS 'arquivo das logos';
COMMENT ON COLUMN lojas.lojas.charset IS 'charset das logos';
COMMENT ON COLUMN lojas.lojas.logo_ultima_atualizacao IS 'última atualização das imagens';

-- Comenta a tabela envios e suas colunas
COMMENT ON TABLE lojas.envios IS 'Tabela referente aos envios';
COMMENT ON COLUMN lojas.envios.envio_id IS 'id de envio';
COMMENT ON COLUMN lojas.envios.loja_id IS 'id da loja';
COMMENT ON COLUMN lojas.envios.cliente_id IS 'id do cliente';
COMMENT ON COLUMN lojas.envios.endereco_entrega IS 'endereço de envio';
COMMENT ON COLUMN lojas.envios.status IS 'status do envio'; 

-- Cria as relações entre as tabelas
ALTER TABLE lojas.pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES lojas.envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES lojas.pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
