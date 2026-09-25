BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "mess" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "inviteCode" text NOT NULL,
    "ownerAuthUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "mess_invite_code_idx" ON "mess" USING btree ("inviteCode");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "mess_member" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "messId" bigint NOT NULL,
    "role" text NOT NULL DEFAULT 'member'::text,
    "phone" text NOT NULL,
    "paymentStatus" text NOT NULL DEFAULT 'due'::text,
    "paymentDate" timestamp without time zone,
    "joiningDate" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "emergencyContact" text,
    "birthday" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "mess_member_auth_user_id_idx" ON "mess_member" USING btree ("authUserId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "mess_member"
    ADD CONSTRAINT "mess_member_fk_0"
    FOREIGN KEY("messId")
    REFERENCES "mess"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR mess_manager_server
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('mess_manager_server', '20260909171906527', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260909171906527', "timestamp" = now();

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
