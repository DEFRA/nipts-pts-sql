# nipts-pts-sql
The "nipts-pts-sql" repository contains the SQL scripts and database schema definitions used to support backend data operations for the NIPTS service.

## Prerequisites
SQL Server Management Studio (SSMS)
Access to a SQL Server instance (local or cloud-hosted)
Git installed and configured
Permissions to execute scripts on the target database

## Setup
1. Clone the repository:
```
git clone https://github.com/DEFRA/nipts-pts-sql.git
cd nipts-pts-sql
```

2. Open the solution: Open Defra.PTS.Sql.sln in SSMS or Azure Data Studio.

3.  Restore dependencies:
```
dotnet restore
```

4. Configure your database connection: Ensure your SQL Server instance is running and accessible. Update connection strings or script targets as needed.

5. Run initial scripts: Execute the scripts in the src/Defra.PTS.Sql directory to create or update the database schema.

### Development
During development, you can:

- Modify stored procedures, views, and table definitions in the src/Defra.PTS.Sql folder.
- Use version control to track changes to SQL scripts.
- Test changes against a local before deploying to development and test environments.

### Test
To validate your changes:

Use SSMS or Azure Data Studio to run test queries.
Ensure all stored procedures and views compile successfully.


## Running in development
- Ensure your local SQL Server instance is running.
- Apply schema changes by executing the relevant scripts.
- Use test data to validate functionality.

## Contributing to this project

Please read the [contribution guidelines](/CONTRIBUTING.md) before submitting a pull request.

## Licence

THIS INFORMATION IS LICENSED UNDER THE CONDITIONS OF THE OPEN GOVERNMENT LICENCE found at:

<http://www.nationalarchives.gov.uk/doc/open-government-licence/version/3>

The following attribution statement MUST be cited in your products and applications when using this information.

>Contains public sector information licensed under the Open Government licence v3

### About the licence

The Open Government Licence (OGL) was developed by the Controller of Her Majesty's Stationery Office (HMSO) to enable information providers in the public sector to license the use and re-use of their information under a common open licence.

It is designed to encourage use and re-use of information freely and flexibly, with only a few conditions.
