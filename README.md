# BoxBilling on Docker - how to :

- Download [BoxBilling](https://github.com/boxbilling/boxbilling/releases/)
- Make a folder named `boxbilling` and extract downloaded BoxBilling into public folder inside
- Create `bb-config.php`
- Create `.env` file inside public folder and fill with

```
    DB_HOST=db
    DB_NAME=boxbilling
    DB_USER=root
    DB_PASS=
```

- Mkdir `docker-config` folder on the project root, and add `nginx`, `php`, and `mysql` folders inside. These folders willl contains regular config files for Nginx, PHP, and mySQL. Some config files will be copied to docker image and other will be read anytime Docker Compose started up.
- Create `docker-compose.yml`, this is the server configuration file that will define containers and network configuration for our docker stack.
- Create `docker-compose-nginx-dockerfile` for Nginx image builder.
- Create `docker-compose-php-dockerfile` for PHP image builder.
- Create `docker-compose-mysql-dockerfile` for mySQL image builder.
- Create `01.sql` file inside `docker-config/mysql/init` that will contain initial seeder for the database. This file will be run when we build our `mysql` container.

- Now run `docker-compose up` and let docker build images and containers.
- Once containers up and ready go to (http://localhost:8004/install/).
- On preparation tab, ensure if all prerequisites are labeled with green, check agree and press NEXT.
- On database tab enter all fields with all of our credetials above.
- On Administrator tab fill in all fields. For example, our installation values are:

```
    NAME : taraz14
    Email : bonave.dimas@gmail.com
    Password : cobain123
```

- To check on installation go to `http://localhost:8004/bb-admin/staff/login` for administrator login or to `http://localhost/` to enter client area.

##

- To reset mysql docker databases and inject a new one, you can use command `docker-compose down -v`

## Thank You
