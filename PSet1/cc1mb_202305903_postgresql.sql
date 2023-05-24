-- Tales Paiva Calvi
-- CC1Mb

-- Apaga o schema já existente
DROP SCHEMA IF EXISTS lojas
CASCADE;

-- Apaga o Banco de dados já existente
DROP DATABASE IF EXISTS uvv;

-- Apaga tabelas já existentes
DROP TABLE IF EXISTS clientes,
                     produtos,
                     estoques,
                     pedidos,
                     pedidos_itens,
                     lojas,
                     envios
CASCADE;

-- Apaga o usuário já existente
DROP USER IF EXISTS "tales";

-- Cria o Usuário
CREATE ROLE "tales" WITH
LOGIN
SUPERUSER
CREATEDB
CREATEROLE
PASSWORD '123';

-- Troca a conexão

-- Cria o Banco de dados
CREATE DATABASE uvv WITH
OWNER = "tales"
TEMPLATE = template0
ENCODING = 'UTF8'
LC_COLLATE = 'pt_BR.UTF-8'
LC_CTYPE = 'pt_BR.UTF-8'
ALLOW_CONNECTIONS = TRUE
CONNECTION LIMIT = -1;

-- Conecta ao banco de dados
\c uvv;

-- Cria o schema
CREATE SCHEMA lojas
AUTHORIZATION "tales";

-- Ajusta o schema de usuário
ALTER USER "tales"
SET SEARCH_PATH TO lojas, "$tales", public;

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

-- Comenta a tabela clientes e suas colunas
COMMENT ON TABLE  public.clientes            IS 'Tabela referente às lojas';
COMMENT ON COLUMN public.clientes.cliente_id IS 'id do cliente';
COMMENT ON COLUMN public.clientes.email      IS 'email dos clientes';
COMMENT ON COLUMN public.clientes.nome       IS 'nome dos clientes';
COMMENT ON COLUMN public.clientes.telefone1  IS 'número de telefone dos clientes';
COMMENT ON COLUMN public.clientes.telefone2  IS 'número de telefone dos clientes';
COMMENT ON COLUMN public.clientes.telefone3  IS 'número de telefone dos clientes';

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

-- Comenta a tabela produtos e suas colunas
COMMENT ON TABLE  public.produtos                    IS 'Tabela referente aos produtos';     
COMMENT ON COLUMN public.produtos.produto_id         IS 'id dos produtos';
COMMENT ON COLUMN public.produtos.nome               IS 'nome dos produtos';
COMMENT ON COLUMN public.produtos.preco_unitario     IS 'preço unitário dos produtos';
COMMENT ON COLUMN public.produtos.detalhes           IS 'detalhes dos produtos';
COMMENT ON COLUMN public.produtos.imagem             IS 'imagem dos produtos';
COMMENT ON COLUMN public.produtos.imagem_mime_type   IS 'imagens em MIME';
COMMENT ON COLUMN public.produtos.imagem_arquivo     IS 'arquivo das imagens';
COMMENT ON COLUMN public.produtos.imagem_charset            IS 'charset das imagens';
COMMENT ON COLUMN public.produtos.imagem_ultima_atualizacao IS 'última atualização das imagens';

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

-- Comenta a tabela lojas e suas colunas
COMMENT ON TABLE  public.lojas                          IS 'Tabela referentes às lojas';
COMMENT ON COLUMN public.lojas.loja_id                  IS 'id das lojas';
COMMENT ON COLUMN public.lojas.nome                     IS 'nome das lojas';
COMMENT ON COLUMN public.lojas.endereco_web             IS 'endereço web das lojas';
COMMENT ON COLUMN public.lojas.endereco_fisico          IS 'endereço físico das lojas';
COMMENT ON COLUMN public.lojas.latitude                 IS 'latitude das lojas';
COMMENT ON COLUMN public.lojas.longitude                IS 'longitude das lojas';
COMMENT ON COLUMN public.lojas.logo                     IS 'logo das lojas';
COMMENT ON COLUMN public.lojas.logo_mime_type           IS 'logos em MIME';
COMMENT ON COLUMN public.lojas.logo_arquivo             IS 'arquivo das logos';
COMMENT ON COLUMN public.lojas.logo_charset             IS 'charset das logos';
COMMENT ON COLUMN public.lojas.logo_ultima_atualizacao  IS 'última atualização das imagens';

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

-- Comenta a tabela envios e suas colunas
COMMENT ON TABLE  public.envios                   IS 'Tabela referente aos envios';
COMMENT ON COLUMN public.envios.envio_id          IS 'id de envio';
COMMENT ON COLUMN public.envios.loja_id           IS 'id da loja';
COMMENT ON COLUMN public.envios.cliente_id        IS 'id do cliente';
COMMENT ON COLUMN public.envios.endereco_entrega  IS 'endereço de envio';
COMMENT ON COLUMN public.envios.status            IS 'status do envio';

-- Cria a tabela estoques
CREATE TABLE public.estoques (
                estoque_id NUMERIC(38) NOT NULL,
                loja_id    NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,

-- Cria a primary key
  CONSTRAINT pk_estoques PRIMARY KEY (estoque_id)
);

-- Comenta a tabela estoques e suas colunas
COMMENT ON TABLE  public.estoques             IS 'Tabela referente aos estoques';
COMMENT ON COLUMN public.estoques.estoque_id  IS 'id do estoque';
COMMENT ON COLUMN public.estoques.loja_id     IS 'id da loja';
COMMENT ON COLUMN public.estoques.produto_id  IS 'id do produto';
COMMENT ON COLUMN public.estoques.quantidade  IS 'quantidade dentro dos estoques';

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

-- Comenta a tabela pedidos
COMMENT ON TABLE  public.pedidos             IS 'Tabela referente aos pedidos';
COMMENT ON COLUMN public.pedidos.pedido_id   IS 'id do pedido';
COMMENT ON COLUMN public.pedidos.data_hora   IS 'data e hora do pedido';
COMMENT ON COLUMN public.pedidos.cliente_id  IS 'id do cliente';
COMMENT ON COLUMN public.pedidos.status      IS 'status do pedido';
COMMENT ON COLUMN public.pedidos.loja_id     IS 'id da loja';

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

-- Comenta a tabela pedidos_itens
COMMENT ON TABLE  public.pedidos_itens                   IS 'Tabela referente aos itens pedidos';
COMMENT ON COLUMN public.pedidos_itens.pedido_id         IS 'id do pedido';
COMMENT ON COLUMN public.pedidos_itens.produto_id        IS 'id do produto pedido';
COMMENT ON COLUMN public.pedidos_itens.numero_da_linha   IS 'número da linha do pedido';
COMMENT ON COLUMN public.pedidos_itens.preco_unitario    IS 'preço unitário do produto pedido';
COMMENT ON COLUMN public.pedidos_itens.quantidade        IS 'quantidade do produto pedido';
COMMENT ON COLUMN public.pedidos_itens.envio_id          IS 'id do envio';

-- Cria as relações entre as tabelas
ALTER TABLE public.pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES  public.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES  public.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES  public.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES  public.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES  public.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES  public.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES  public.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES  public.envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES  public.pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
