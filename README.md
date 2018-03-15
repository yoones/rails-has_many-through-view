# POC goal

This proof-of-concept shows one way to create a `has_many through` relationship through multiple models.

This answers a question I asked on stackoverflow: (https://stackoverflow.com/questions/49284439/activerecord-has-many-through-two-models/)

# Selected solution

Create a **UNION SQL view** and use it to link `projects` and `investors`.

# Steps

- Create 4 models: `project`, `investor` and join tables `subscriptions` and `external_subscriptions` (with basic relationships)
- Make your app dump its database schema in sql format (https://github.com/yoones/rails-has_many-through-view/blob/master/config/application.rb#L14)
- Generate a migration that creates the view using an SQL query (https://github.com/yoones/rails-has_many-through-view/blob/master/db/migrate/20180315083812_create_project_investors.rb)
- Create a model for this new table (https://github.com/yoones/rails-has_many-through-view/blob/master/app/models/project_investor.rb)
- Then add `has_many through` relationships in models `project` and `investor`

# TODO

- Add specs for this POC.
