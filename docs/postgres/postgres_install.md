https://postgresapp.com/ - PostgreSQL installation packaged

https://www.pgadmin.org/ - administration and development platform for PostgreSQL



### How to check DB
```
root@ee93f3d8e87f:/# psql -U postgres
psql (11.1 (Debian 11.1-1.pgdg90+1))
Type "help" for help.

postgres=# \l
                                    List of databases
      Name      |  Owner   | Encoding |   Collate   |    Ctype    |   Access privileges
----------------+----------+----------+-------------+-------------+-----------------------
 django.retries | deploy   | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =Tc/deploy           +
                |          |          |             |             | deploy=CTc/deploy
 postgres       | postgres | UTF8     | en_US.utf8  | en_US.utf8  |
 template0      | postgres | UTF8     | en_US.utf8  | en_US.utf8  | =c/postgres          +
                |          |          |             |             | postgres=CTc/postgres
 template1      | postgres | UTF8     | en_US.utf8  | en_US.utf8  | =c/postgres          +
                |          |          |             |             | postgres=CTc/postgres
(4 rows)

postgres=# \c django.retries
You are now connected to database "django.retries" as user "postgres".
django.retries=# \dt
Did not find any relations.
django.retries=# \q
```
