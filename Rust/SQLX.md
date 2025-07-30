.envsetup sqlx on server
https://codevoweb.com/rust-build-a-crud-api-with-sqlx-and-postgresql/
https://www.shuttle.dev/blog/2023/10/04/sql-in-rust

Prepare SQLX on a dev server with offline environment:
1) Make sure `sqlx-cli` is installed
2) Create migration files `sqlx migrate add -r init`
3) Create the database file manually (database.sqlite)
4) Add path of database file as an environment variable
		`export DATABASE_URL='sqlite:/path/to/db/db.sqlite'`
5) Run `sqlx migrate run`
6) Run `cargo sqlx prepare` and make sure a `.sqlx` directory is created
7) Remove the `DATABASE_URL` environment value
