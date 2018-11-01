truncate table person;
insert into person values (0, 'Sarina');
insert into person values (1, 'Esvin');
insert into person values (2, 'Mateo');
select * from person;

select current_setting('log_statement');
show is_superuser;
select set_config('log_statement', 'all', false);