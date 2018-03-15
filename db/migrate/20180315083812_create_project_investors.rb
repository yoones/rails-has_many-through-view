class CreateProjectInvestors < ActiveRecord::Migration[5.1]
  def up
        execute <<-SQL
CREATE VIEW project_investors AS
SELECT "investors"."id" AS "investor_id", "projects"."id" AS "project_id"
FROM "investors"
INNER JOIN "subscriptions" ON "investors"."id" = "subscriptions"."investor_id"
INNER JOIN "projects" ON "projects"."id" = "subscriptions"."project_id"
UNION
SELECT "investors"."id" AS "investor_id", "projects"."id" AS "project_id"
FROM "investors"
INNER JOIN "external_subscriptions" ON "investors"."id" = "external_subscriptions"."investor_id"
INNER JOIN "projects" ON "projects"."id" = "external_subscriptions"."project_id"
SQL
  end

  def down
    execute 'DROP VIEW project_investors'
  end
end
