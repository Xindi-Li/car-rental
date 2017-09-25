BEGIN TRANSACTION;
INSERT INTO "users" VALUES(1,'123@123','123','$2a$10$euW62oA83Xuq2menIHnNZeCimNxgfb70W5/bmeAHucC/a1MosFDfe','super',NULL);
INSERT INTO "users" VALUES(2,'123@1234','123','$2a$10$fnW1UjEm7VYodLk70RCrFubTK8xhQ4aAZMB61EsW3SS6Hx/yFFQOG','super',,NULL);
INSERT INTO "users" VALUES(3,'abc@abc','james','$2a$10$M/b4G32NIyTVDcQICTDEweX8J22BIC/X.To/l.Y92PPWip2w7PKDu','customer',NULL,);
INSERT INTO "users" VALUES(4,'dsu@123','ddshfs','$2a$10$o5gcnrIgS9q5EcztSpALaO5i5D6zIW1DwvjpS16qLif66pcyZw/H2','customer',NULL,);
INSERT INTO "users" VALUES(5,'123@12345','123','$2a$10$e1PA4ZaHle./6pHTcYU96eABJY14AMJBhqzHgCxqLXIKvYxxG70LK','admin',NULL);
INSERT INTO "users" VALUES(6,'fghfhfg@11','234','$2a$10$tRqMTTHClkqWi.wizoeS0eVFAoa5lDf7RsUqe1LOViHI0GJptnIqC','admin',NULL);
COMMIT;
