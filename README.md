[![Apache License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
# Apple Search Ads (Source) 

This package models Jira data from [Fivetran's connector](https://fivetran.com/docs/applications/apple-search-ads). It uses data in the format described by [this ERD](https://fivetran.com/docs/applications/apple-search-ads/#schemainformation).

This package enriches your Fivetran data by doing the following:
- Adds descriptions to tables and columns that are synced using Fivetran
- Adds column-level testing where applicable. For example, all primary keys are tested for uniqueness and non-null values.
- Models staging tables, which will be used in our transform package

## Models
This package contains staging models, designed to work simultaneously with our [Jira modeling package](https://github.com/fivetran/dbt_apple_search_ads).  The staging models:
- Remove any rows that are soft-deleted
- Name columns consistently across all packages:
    - Boolean fields are prefixed with `is_` or `has_`
    - Timestamps are appended with `_at`
    - ID primary keys are prefixed with the name of the table.  For example, the `issue` table's ID column is renamed `issue_id`.
    - Foreign keys include the table that they refer to. For example, an issue's `assignee` user ID column is renamed `assignee_user_id`.

## Installation Instructions
Add the following to your `packages.yml` file:
```yml
# packages.yml
packages:
  - package: fivetran/apple_search_ads_source
    version: [">=0.1.0", "<0.2.0"]
```

Check [dbt Hub](https://hub.getdbt.com/) for the latest installation instructions, or [read the dbt docs](https://docs.getdbt.com/docs/package-management) for more information on installing packages.

## Configuration
By default, this package looks for your Apple Search Ads data in the `apple_search_ads` schema of your [target database](https://docs.getdbt.com/docs/running-a-dbt-project/using-the-command-line-interface/configure-your-profile). If this is not where your Jira data is, add the following configuration to your `dbt_project.yml` file:

```yml
# dbt_project.yml

...
config-version: 2

vars:
    apple_search_ads_database: your_database_name
    apple_search_ads_schema: your_schema_name 
```

### Changing the Build Schema
By default this package will build the Apple Search Ads staging models within a schema titled (<target_schema> + `_stg_apple_search_ads`) in your target database. If this is not where you would like your Apple Search Ads staging data to be written to, add the following configuration to your `dbt_project.yml` file:

```yml
# dbt_project.yml

...
models:
    apple_search_ads_source:
      +schema: my_new_schema_name # leave blank for just the target_schema
```

## Contributions
Additional contributions to this package are very welcome! Please create issues
or open PRs against `main`. Check out 
[this post](https://discourse.getdbt.com/t/contributing-to-a-dbt-package/657) 
on the best workflow for contributing to a package.

## Database Support
This package has been tested on BigQuery, Snowflake, Redshift, and Postgres.

## Resources:
- Provide [feedback](https://www.surveymonkey.com/r/DQ7K7WW) on our existing dbt packages or what you'd like to see next
- Have questions or feedback, or need help? Book a time during our office hours [here](https://calendly.com/fivetran-solutions-team/fivetran-solutions-team-office-hours) or shoot us an email at solutions@fivetran.com.
- Find all of Fivetran's pre-built dbt packages in our [dbt hub](https://hub.getdbt.com/fivetran/)
- Learn how to orchestrate dbt transformations with Fivetran [here](https://fivetran.com/docs/transformations/dbt).
- Learn more about Fivetran overall [in our docs](https://fivetran.com/docs)
- Check out [Fivetran's blog](https://fivetran.com/blog)
- Learn more about dbt [in the dbt docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](http://slack.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the dbt blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
