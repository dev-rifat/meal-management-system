BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "payment" (
    "id" bigserial PRIMARY KEY,
    "messId" bigint NOT NULL,
    "memberId" bigint NOT NULL,
    "amount" double precision NOT NULL,
    "date" timestamp without time zone NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "payment"
    ADD CONSTRAINT "payment_fk_0"
    FOREIGN KEY("messId")
    REFERENCES "mess"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "payment"
    ADD CONSTRAINT "payment_fk_1"
    FOREIGN KEY("memberId")
    REFERENCES "mess_member"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR mess_manager_server
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('mess_manager_server', '20260922143913086', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260922143913086', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260129180959368', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129180959368', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260213194423028', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260213194423028', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260129181112269', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129181112269', "timestamp" = now();


COMMIT;
