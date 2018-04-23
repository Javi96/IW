-- INSERT INTO user(id,enabled,login,password,roles) VALUES (1, 1, 'a', 'aa', 'USER');
-- INSERT INTO user VALUES (2, 1, 'b', 'bb', 'USER,ADMIN');
INSERT INTO user(id,enabled,login,password,roles,name) VALUES (1, 1, 'a', '$2a$04$N78IYN6VzrWZzpsy6Xvz2uCdUm7Su9FDpAqhXjAcSzCgreVM2sUnC', 'USER','Pepe');
INSERT INTO user VALUES (2, 1, 'b', '$2a$04$NwYuA6rd/UbCs3H8mntvPuqyFuUsX8sTKI1WDYwqrXhncXWIklscW', 'USER,ADMIN');
INSERT INTO league (id,name,sport,gender) values (1,'Torneo Rector','Rugby','Masculino');
INSERT INTO team (id,name,school,sport,deputy) values (1,'Rugby Fisicas', 'Facultad de Fisicas', 'Rugby', 'Pepe');
INSERT INTO team (id,name,school,sport,deputy) values (2,'Rugby Matematicas', 'Facultad de Matematicas', 'Rugby', 'Pepito');