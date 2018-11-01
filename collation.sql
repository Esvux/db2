select datname as database, 
       datcollate as collation
from pg_database;

select table_schema, 
       table_name, 
       column_name,
       collation_name
from information_schema.columns
where table_schema = 'public'
where collation_name is not null
order by table_schema,
         table_name,
         ordinal_position;