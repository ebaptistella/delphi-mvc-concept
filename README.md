# delphi-mvc-concept

MVC Framework Concept using Spring4D + DSharp +Delphi-OOP(SvBindings).

This concept was presented at Embarcadero Conference 2019 (Brazil).

# Libraries

For execute this project you need:
  - Spring4D `git clone https://bitbucket.org/sglienke/spring4d.git`
  - DSharp `git clone https://bitbucket.org/sglienke/dsharp.git`
  - Delphi-OOP `git clone https://github.com/azzazello/delphi-oop.git`

> For *spring4d* prefer the tag *1.2.1*
> For *DSharp* prefer the branch *spring-1.2.1*
> And for *Delphi-OOP* the *master* branch

# For runing project

Configure your Delphi IDE with libraries, This can be configured in Library Path, or Project Source Path.


# Database structure

For concept I using the database PostgreSQL, but you can adapt to others databases.

```sql
DROP TABLE IF EXISTS tb_marca;
DROP TABLE IF EXISTS tb_municipio;
DROP TABLE IF EXISTS tb_estado;
DROP TABLE IF EXISTS tb_pais;
DROP TABLE IF EXISTS tb_usuario;

CREATE TABLE tb_usuario (
    id_usuario integer NOT NULL PRIMARY KEY /*AUTOINCREMENT*/,
    tx_usuarionome varchar(40) NOT NULL,
    tx_email varchar(100) NOT NULL,
    tx_senha varchar(40) NOT NULL,
    dt_cadastro timestamp default CURRENT_TIMESTAMP NOT NULL,
    dt_manutencao timestamp default CURRENT_TIMESTAMP NOT NULL,
    dt_exclusao timestamp,
    cd_usuarioalt integer
);
CREATE INDEX usuario_idx001 ON tb_usuario (tx_email, tx_senha);
drop sequence if exists gen_usuario;
create sequence gen_usuario;
INSERT INTO tb_usuario values (nextval('gen_usuario'), 'user demo', 'demo@demo.com', 'e10adc3949ba59abbe56e057f20f883e', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, null, null);


CREATE TABLE tb_pais (
    id_pais integer NOT NULL PRIMARY KEY /*AUTOINCREMENT*/,
    tx_paisnome varchar(40) NOT NULL,
    dt_cadastro timestamp default CURRENT_TIMESTAMP NOT NULL,
    dt_manutencao timestamp default CURRENT_TIMESTAMP NOT NULL,
    dt_exclusao timestamp,
    cd_usuarioalt integer NOT NULL,
    CONSTRAINT pais_usuario_fk FOREIGN KEY (cd_usuarioalt) REFERENCES tb_usuario(id_usuario) ON UPDATE CASCADE ON DELETE CASCADE
);
insert into tb_pais values (nextval('gen_pais'), 'BRASIL', current_timestamp, current_timestamp, null, 1);
CREATE INDEX pais_idx001 ON tb_pais (tx_paisnome);
drop sequence if exists gen_pais;
create sequence gen_pais;


CREATE TABLE tb_estado (
    id_estado char(2) NOT NULL PRIMARY KEY,
    tx_estadonome varchar(30) NOT NULL,
    cd_pais integer,
    dt_cadastro timestamp default CURRENT_TIMESTAMP NOT NULL,
    dt_manutencao timestamp default CURRENT_TIMESTAMP NOT NULL,
    dt_exclusao timestamp,
    cd_usuarioalt integer NOT NULL,
    CONSTRAINT estado_pais_fk FOREIGN KEY (cd_pais) REFERENCES tb_pais(id_pais)  ON UPDATE CASCADE ON DELETE cascade,
    CONSTRAINT estado_usuario_fk  FOREIGN KEY (cd_usuarioalt) REFERENCES tb_usuario(id_usuario) ON UPDATE CASCADE ON DELETE CASCADE
);
CREATE INDEX estado_idx001 ON tb_estado (tx_estadonome);

CREATE TABLE tb_municipio (
    id_municipio integer NOT NULL PRIMARY KEY /*AUTOINCREMENT*/,
    tx_municipionome varchar(30) NOT NULL,
    tx_nomereduzido varchar(10) DEFAULT '',
    cd_estado char(2) DEFAULT '',
    dt_cadastro timestamp default CURRENT_TIMESTAMP NOT NULL,
    dt_manutencao timestamp default CURRENT_TIMESTAMP NOT NULL,
    dt_exclusao timestamp,
    cd_usuarioalt integer NOT NULL,
    CONSTRAINT municipio_estado_fk FOREIGN KEY (cd_estado) REFERENCES tb_estado(id_estado) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT municipio_usuario_fk FOREIGN KEY (cd_usuarioalt) REFERENCES tb_usuario(id_usuario) ON UPDATE CASCADE ON DELETE CASCADE
);
CREATE INDEX municipio_idx001 ON tb_municipio (tx_municipionome);
drop sequence if exists gen_municipio;
create sequence gen_municipio;


CREATE TABLE tb_marca (
    id_marca integer NOT NULL PRIMARY KEY /*AUTOINCREMENT*/,
    tx_marcanome varchar(30) NOT NULL,
    tx_nomereduzido varchar(10) NOT NULL,
    dt_cadastro timestamp default CURRENT_TIMESTAMP NOT NULL,
    dt_manutencao timestamp default CURRENT_TIMESTAMP NOT NULL,
    dt_exclusao timestamp,
    cd_usuarioalt integer NOT NULL,
    CONSTRAINT marca_usuario_fk FOREIGN KEY (cd_usuarioalt) REFERENCES tb_usuario(id_usuario) ON UPDATE CASCADE ON DELETE CASCADE
);
CREATE INDEX marca_idx001 ON tb_marca (tx_marcanome);
drop sequence if exists gen_marca;
create sequence gen_marca;
```