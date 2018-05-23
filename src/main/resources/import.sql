-- INSERT INTO user(id,enabled,login,password,roles) VALUES (1, 1, 'a', 'aa', 'USER');
-- INSERT INTO user VALUES (2, 1, 'b', 'bb', 'USER,ADMIN');
INSERT INTO user(id,enabled,login,password,roles,name,id_card) VALUES (8, 1, 'b', '$2a$04$N78IYN6VzrWZzpsy6Xvz2uCdUm7Su9FDpAqhXjAcSzCgreVM2sUnC', 'ADMIN','Pepe8','123456589');
INSERT INTO user(id,enabled,login,password,roles,name,id_card,email) VALUES (1, 1, 'a', '$2a$04$N78IYN6VzrWZzpsy6Xvz2uCdUm7Su9FDpAqhXjAcSzCgreVM2sUnC', 'USER','Pepe1','123456789','example@correo1.es');
INSERT INTO user(id,enabled,login,password,roles,name,id_card,email) VALUES (2, 1, 'a2', '$2a$04$N78IYN6VzrWZzpsy6Xvz2uCdUm7Su9FDpAqhXjAcSzCgreVM2sUnC', 'USER','Pepe2','113456789','example@correo2.es');
INSERT INTO user(id,enabled,login,password,roles,name,id_card,email) VALUES (3, 1, 'a3', '$2a$04$N78IYN6VzrWZzpsy6Xvz2uCdUm7Su9FDpAqhXjAcSzCgreVM2sUnC', 'USER','Pepe3','122456789','example@correo3.es');
INSERT INTO user(id,enabled,login,password,roles,name,id_card,email) VALUES (4, 1, 'a4', '$2a$04$N78IYN6VzrWZzpsy6Xvz2uCdUm7Su9FDpAqhXjAcSzCgreVM2sUnC', 'USER','Pepe4','123456739','example@correo4.es');
INSERT INTO user(id,enabled,login,password,roles,name,id_card,email) VALUES (5, 1, 'a5', '$2a$04$N78IYN6VzrWZzpsy6Xvz2uCdUm7Su9FDpAqhXjAcSzCgreVM2sUnC', 'USER','Pepe5','123456559','example@correo5.es');
INSERT INTO user(id,enabled,login,password,roles,name,id_card,email) VALUES (6, 1, 'a6', '$2a$04$N78IYN6VzrWZzpsy6Xvz2uCdUm7Su9FDpAqhXjAcSzCgreVM2sUnC', 'USER','Pepe6','423456789','example@correo6.es');
INSERT INTO user(id,enabled,login,password,roles,name,id_card,email) VALUES (7, 1, 'a7', '$2a$04$N78IYN6VzrWZzpsy6Xvz2uCdUm7Su9FDpAqhXjAcSzCgreVM2sUnC', 'USER','Pepe7','423456799','example@correo7.es');
INSERT INTO user(id,enabled,login,password,roles,name,id_card,email) VALUES (9, 1, 'a9', '$2a$04$N78IYN6VzrWZzpsy6Xvz2uCdUm7Su9FDpAqhXjAcSzCgreVM2sUnC', 'USER','Pepe9','423499799','example@correo9.es');


INSERT INTO league (id,name,sport,category) values (1,'Torneo Rector','Rugby','Masculino');

INSERT INTO team (id,name,school,sport,deputy_id,category,training_schedule,next_match_schedule,next_match_facilities,league_id) values (1,'Rugby Fisicas', 'Facultad de Fisicas', 'Rugby', 1,'Masculino','Lunes y Miercoles 14:00h','Viernes 13:30h', 'Paraninfo',1);
INSERT INTO team (id,name,school,sport,deputy_id,category,training_schedule,next_match_schedule,next_match_facilities,league_id) values (2,'Rugby Matematicas', 'Facultad de Matematicas', 'Rugby', 2, 'Masculino','Lunes y Miercoles 14:00h','Viernes 13:30h', 'Cantarranas',1);
INSERT INTO team (id,name,school,sport,deputy_id,category,training_schedule,next_match_schedule,next_match_facilities) values  (3,'Futbol Matematicas', 'Facultad de Matematicas', 'Futbol', 3, 'Masculino', 'Lunes y Miercoles 18:00h','Viernes 20:30h', 'Paraninfo');
INSERT INTO team (id,name,school,sport,deputy_id,category,training_schedule,next_match_schedule,next_match_facilities) values  (4,'Balonmano Matematicas', 'Facultad de Matematicas', 'Balonmano', 4, 'Masculino', 'Lunes y Martes 16:00h','Jueves 18:30h', 'Polideportivo UCM');
INSERT INTO team (id,name,school,sport,deputy_id,category,training_schedule,next_match_schedule,next_match_facilities) values  (5,'Futbol Sala Mates', 'Facultad de Matematicas', 'Futbol Sala', 5, 'Femenino', 'Martes y Jueves 18:00h','Viernes 18:30h', 'Polideportivo UCM');
INSERT INTO team (id,name,school,sport,deputy_id,category,training_schedule,next_match_schedule,next_match_facilities) values  (6,'Futbol Sala Historia', 'Facultad de Historia', 'Futbol Sala', 6, 'Masculino', 'Lunes y Jueves 17:00h','Viernes 16:30h', 'Polideportivo UCM');

INSERT INTO match(home_team_id,away_team_id,home_team_points,away_team_points,match_date,record_checked) values (1,2,50,70,'2018-05-23',0);

INSERT INTO team_active_players(active_teams_id,active_players_id) values (1,5);
INSERT INTO team_active_players(active_teams_id,active_players_id) values (1,6);
INSERT INTO team_no_active_players(no_active_teams_id,no_active_players_id) values (1,4);
INSERT INTO team_active_players(active_teams_id,active_players_id) values (2,5);

INSERT INTO team_active_players(active_teams_id,active_players_id) values (3,5);

INSERT INTO team_active_players(active_teams_id,active_players_id) values (4,5);

INSERT INTO team_active_players(active_teams_id,active_players_id) values (5,5);

INSERT INTO team_active_players(active_teams_id,active_players_id) values (6,5);


INSERT INTO request_team(team_id,user_id) values (1,3);
INSERT INTO request_team(team_id,user_id) values (1,7);

INSERT INTO notification(email,message,name,deputy_id) values ('ejemplo@gmail.es','Hola me gustaria unirme a vuestro equipo.','Juan Pablo', 1);

