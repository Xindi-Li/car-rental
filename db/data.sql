BEGIN TRANSACTION;
INSERT INTO "cars" VALUES(3,'456','abc','abc',12,'abc','abc','abc','2017-09-22 23:32:44.639046','2017-09-22 23:34:42.526054',NULL);
INSERT INTO "cars" VALUES(5,'567','123','123',12,'123','123','Reserved','2017-09-23 20:02:15.448317','2017-09-23 20:18:12.296989','homepage4.jpg');
INSERT INTO "cars" VALUES(6,'234','123','123',12,'123','123','Reserved','2017-09-23 20:03:33.395555','2017-09-23 20:21:10.704692','homepage3.jpg');
INSERT INTO "cars" VALUES(8,'123','123','123',123,'123','123','Checkout','2017-09-23 20:33:30.645310','2017-09-25 15:03:41.623786','homepage.jpg');
INSERT INTO "cars" VALUES(9,'1234','123','123',123,'123','123','Available','2017-09-23 23:22:18.621576','2017-09-25 12:15:07.126936',NULL);
INSERT INTO "cars" VALUES(10,'12345','123','123',0.1,'123','123','Available','2017-09-23 23:28:04.127500','2017-09-24 23:07:37.436135',NULL);
INSERT INTO "cars" VALUES(11,'135','21','123',12,'12','12','Available','2017-09-24 15:43:16.301703','2017-09-25 11:59:31.891187',NULL);
INSERT INTO "reservations" VALUES(50,'abc@abc','123','1999-09-09 05:09:00','2017-09-25 11:56:51.275711','2000-09-09 05:09:00','2017-09-25 11:59:09.046247','Returned',NULL,'2017-09-24 14:10:42.455224','2017-09-25 11:59:09.047462');
INSERT INTO "reservations" VALUES(53,'abc@abc','1234','1999-09-09 05:08:00','2017-09-24 16:43:28.096200','2001-09-09 05:09:00','2017-09-24 23:00:49.331250','Returned',NULL,'2017-09-24 14:33:25.179740','2017-09-24 23:00:49.337430');
INSERT INTO "reservations" VALUES(54,'abc@abc','12345','1222-08-08 03:08:00','2017-09-24 16:41:07.596759','1999-09-09 05:09:00','2017-09-24 23:07:37.409337','Returned',NULL,'2017-09-24 15:17:34.532705','2017-09-24 23:07:37.420135');
INSERT INTO "reservations" VALUES(55,'abc@abc','135','1999-09-09 05:08:00','2017-09-24 16:59:38.508669','2002-09-09 05:09:00','2017-09-25 11:59:31.878350','Returned',NULL,'2017-09-24 16:59:20.503024','2017-09-25 11:59:31.884111');
INSERT INTO "reservations" VALUES(60,'abc@abc','123','2000-09-09 05:09:00','2017-09-25 11:58:26.358646','2001-09-09 05:09:00','2017-09-25 12:01:02.300083','Returned',NULL,'2017-09-25 11:51:20.313709','2017-09-25 12:01:02.308244');
INSERT INTO "reservations" VALUES(61,'abc@abc','1234','1991-09-09 05:09:00','2017-09-25 12:15:03.287612','1998-09-09 05:09:00','2017-09-25 12:15:07.109932','Returned',NULL,'2017-09-25 12:14:28.462233','2017-09-25 12:15:07.117334');
INSERT INTO "reservations" VALUES(62,'abc@abc','123','2017-08-31 21:00:00','2017-09-25 15:03:41.592398','2017-09-06 09:00:00',NULL,'Checkout',NULL,'2017-09-25 13:44:51.317408','2017-09-25 15:03:41.599382');
COMMIT;
