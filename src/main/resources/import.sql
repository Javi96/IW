-- INSERT INTO user(id,enabled,login,password,roles) VALUES (1, 1, 'a', 'aa', 'USER');
-- INSERT INTO user VALUES (2, 1, 'b', 'bb', 'USER,ADMIN');
INSERT INTO user(id,enabled,login,password,roles,name) VALUES (1, 1, 'a', '$2a$04$N78IYN6VzrWZzpsy6Xvz2uCdUm7Su9FDpAqhXjAcSzCgreVM2sUnC', 'USER','Pepe1');
INSERT INTO user(id,enabled,login,password,roles,name) VALUES (2, 1, 'a2', '$2a$04$N78IYN6VzrWZzpsy6Xvz2uCdUm7Su9FDpAqhXjAcSzCgreVM2sUnC', 'USER','Pepe2');
INSERT INTO user(id,enabled,login,password,roles,name) VALUES (3, 1, 'a3', '$2a$04$N78IYN6VzrWZzpsy6Xvz2uCdUm7Su9FDpAqhXjAcSzCgreVM2sUnC', 'USER','Pepe3');
INSERT INTO user(id,enabled,login,password,roles,name) VALUES (4, 1, 'a4', '$2a$04$N78IYN6VzrWZzpsy6Xvz2uCdUm7Su9FDpAqhXjAcSzCgreVM2sUnC', 'USER','Pepe4');
INSERT INTO user(id,enabled,login,password,roles,name) VALUES (5, 1, 'a5', '$2a$04$N78IYN6VzrWZzpsy6Xvz2uCdUm7Su9FDpAqhXjAcSzCgreVM2sUnC', 'USER','Pepe5');
INSERT INTO user(id,enabled,login,password,roles,name) VALUES (6, 1, 'a6', '$2a$04$N78IYN6VzrWZzpsy6Xvz2uCdUm7Su9FDpAqhXjAcSzCgreVM2sUnC', 'USER','Pepe6');

INSERT INTO league (id,name,sport,gender) values (1,'Torneo Rector','Rugby','Masculino');

INSERT INTO team (id,name,school,sport,deputy_id,category,training_schedule,next_match_schedule,next_match_facilities) values (1,'Rugby Fisicas', 'Facultad de Fisicas', 'Rugby', '2','Masculino','Lunes y Miercoles 14:00h','Viernes 13:30h', 'Paraninfo');
INSERT INTO team (id,name,school,sport,deputy_id,category,training_schedule,next_match_schedule,next_match_facilities) values (2,'Rugby Matematicas', 'Facultad de Matematicas', 'Rugby', '1', 'Femenino','Lunes y Miercoles 14:00h','Viernes 13:30h', 'Cantarranas');
INSERT INTO team (id,name,school,sport,deputy_id,category,training_schedule,next_match_schedule,next_match_facilities) values  (3,'Futbol Matematicas', 'Facultad de Matematicas', 'Futbol', '3', 'Masculino', 'Lunes y Miercoles 18:00h','Viernes 20:30h', 'Paraninfo');
INSERT INTO team (id,name,school,sport,deputy_id,category,training_schedule,next_match_schedule,next_match_facilities) values  (4,'Balonmano Matematicas', 'Facultad de Matematicas', 'Balonmano', '4', 'Masculino', 'Lunes y Martes 16:00h','Jueves 18:30h', 'Polideportivo UCM');
INSERT INTO team (id,name,school,sport,deputy_id,category,training_schedule,next_match_schedule,next_match_facilities) values  (5,'Futbol Sala Mates', 'Facultad de Matematicas', 'Futbol Sala', '5', 'Femenino', 'Martes y Jueves 18:00h','Viernes 18:30h', 'Polideportivo UCM');
INSERT INTO team (id,name,school,sport,deputy_id,category,training_schedule,next_match_schedule,next_match_facilities) values  (6,'Futbol Sala Historia', 'Facultad de Historia', 'Futbol Sala', '6', 'Masculino', 'Lunes y Jueves 17:00h','Viernes 16:30h', 'Polideportivo UCM');