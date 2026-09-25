BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "meal_entry" (
    "id" bigserial PRIMARY KEY,
    "messId" bigint NOT NULL,
    "memberId" bigint NOT NULL,
    "date" timestamp without time zone NOT NULL,
    "mealType" text NOT NULL,
    "mealCount" double precision NOT NULL,
    "status" text NOT NULL DEFAULT 'pending'::text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "meal_entry_member_date_type_idx" ON "meal_entry" USING btree ("memberId", "date", "mealType");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "meal_entry"
    ADD CONSTRAINT "meal_entry_fk_0"
    FOREIGN KEY("messId")
    REFERENCES "mess"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "meal_entry"
    ADD CONSTRAINT "meal_entry_fk_1"
    FOREIGN KEY("memberId")
    REFERENCES "mess_member"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR mess_manager_server
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('mess_manager_server', '20260914162403392', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260914162403392', "timestamp" = now();

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
