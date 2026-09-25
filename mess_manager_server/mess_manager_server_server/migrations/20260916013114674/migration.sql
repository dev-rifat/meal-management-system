BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "bill_type" (
    "id" bigserial PRIMARY KEY,
    "messId" bigint NOT NULL,
    "name" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "bill_type_mess_name_idx" ON "bill_type" USING btree ("messId", "name");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "expense" (
    "id" bigserial PRIMARY KEY,
    "messId" bigint NOT NULL,
    "memberId" bigint NOT NULL,
    "title" text NOT NULL,
    "amount" double precision NOT NULL,
    "type" text NOT NULL,
    "date" timestamp without time zone NOT NULL,
    "details" text NOT NULL,
    "billTypeId" bigint,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "bill_type"
    ADD CONSTRAINT "bill_type_fk_0"
    FOREIGN KEY("messId")
    REFERENCES "mess"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "expense"
    ADD CONSTRAINT "expense_fk_0"
    FOREIGN KEY("messId")
    REFERENCES "mess"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "expense"
    ADD CONSTRAINT "expense_fk_1"
    FOREIGN KEY("memberId")
    REFERENCES "mess_member"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "expense"
    ADD CONSTRAINT "expense_fk_2"
    FOREIGN KEY("billTypeId")
    REFERENCES "bill_type"("id")
    ON DELETE SET NULL
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR mess_manager_server
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('mess_manager_server', '20260916013114674', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260916013114674', "timestamp" = now();

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
