USE ControleBancario;

INSERT INTO Agencia VALUES("Vitória da Conquista", 1),
                          ("São Paulo", 2),
                          ("Curitiba", 3),
                          ("Salvador", 4);

INSERT INTO Cliente VALUES(1, "Vitória da Conquista", "39520007695", "Raimundo Sebastião Caio Santos"),
                          (2, "Vitória da Conquista", "236219145", "Anthony Raul Rezende"),
                          (3, "Vitória da Conquista", "47580005797", "Olivia Agatha Peixoto"),
                          (4, "São Paulo", "43400008852", "Geraldo Yuri Manoel da Paz"),
                          (5, "São Paulo", "22130007296", "João Isaac Mário Figueiredo"),
                          (6, "São Paulo", "21570001372", "Mariana Kamilly da Mota"),
                          (7, "Curitiba", "40600045635", "Lúcia Joana Isabela Jesus"),
                          (8, "Curitiba", "25826000921", "Davi Iago da Cruz"),
                          (9, "Curitiba", "21584000386", "Francisco Samuel Freitas"),
                          (10, "Salvador", "32740007295", "Andreia Alessandra Monteiro"),
                          (11, "Salvador", "48517000595", "Débora Liz Melo"),
                          (12, "Salvador", "14179400033", "Raimundo Sebastião Caio Santos");

INSERT INTO Conta VALUES(10, 520.0),
                        (20, 860.0),
                        (30, 4020.0),
                        (40, 987.0),
                        (50, 1574.0),
                        (60, 764.0),
                        (70, 2489.0),
                        (80, 3587.0),
                        (90, 7052.0),
                        (100, 4658.0),                       
                        (110, 2054.0),
                        (120, 3874.0);

INSERT INTO ACC Values(10, 1, 1),
                      (20, 1, 2),                       
                      (30, 1, 3),
                      (40, 2, 4),
                      (50, 2, 5),
                      (60, 2, 6),
                      (70, 3, 7),
                      (80, 3, 8),
                      (90, 3, 9),
                      (100, 4, 10),
                      (110, 4, 11),
                      (120, 4, 12);