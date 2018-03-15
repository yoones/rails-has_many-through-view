CREATE TABLE IF NOT EXISTS "schema_migrations" ("version" varchar NOT NULL PRIMARY KEY);
CREATE TABLE IF NOT EXISTS "ar_internal_metadata" ("key" varchar NOT NULL PRIMARY KEY, "value" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE IF NOT EXISTS "projects" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE IF NOT EXISTS "investors" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE IF NOT EXISTS "subscriptions" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "project_id" integer, "investor_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, CONSTRAINT "fk_rails_d0c8bda804"
FOREIGN KEY ("project_id")
  REFERENCES "projects" ("id")
, CONSTRAINT "fk_rails_6ec1b0a82d"
FOREIGN KEY ("investor_id")
  REFERENCES "investors" ("id")
);
CREATE INDEX "index_subscriptions_on_project_id" ON "subscriptions" ("project_id");
CREATE INDEX "index_subscriptions_on_investor_id" ON "subscriptions" ("investor_id");
CREATE TABLE IF NOT EXISTS "external_subscriptions" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "project_id" integer, "investor_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, CONSTRAINT "fk_rails_0cf95f76e4"
FOREIGN KEY ("project_id")
  REFERENCES "projects" ("id")
, CONSTRAINT "fk_rails_a8a0ce1051"
FOREIGN KEY ("investor_id")
  REFERENCES "investors" ("id")
);
CREATE INDEX "index_external_subscriptions_on_project_id" ON "external_subscriptions" ("project_id");
CREATE INDEX "index_external_subscriptions_on_investor_id" ON "external_subscriptions" ("investor_id");
CREATE VIEW project_investors AS
SELECT "investors"."id" AS "investor_id", "projects"."id" AS "project_id"
FROM "investors"
INNER JOIN "subscriptions" ON "investors"."id" = "subscriptions"."investor_id"
INNER JOIN "projects" ON "projects"."id" = "subscriptions"."project_id"
UNION
SELECT "investors"."id" AS "investor_id", "projects"."id" AS "project_id"
FROM "investors"
INNER JOIN "external_subscriptions" ON "investors"."id" = "external_subscriptions"."investor_id"
INNER JOIN "projects" ON "projects"."id" = "external_subscriptions"."project_id";
INSERT INTO "schema_migrations" (version) VALUES
('20180314163231'),
('20180314163243'),
('20180314163302'),
('20180314163309'),
('20180315083812');


