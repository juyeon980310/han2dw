import pymysql


conn = pymysql.connect(host='localhost', user='han2um', password='root',
                       db='han2um', charset='utf8')
 
curs = conn.cursor(pymysql.cursors.DictCursor)

sql = "select tag_num from key_table where tag_id='45f2c6ef'"
curs.execute(sql)
result = curs.fetchone()
#print(result['tag_num'])

sql = """insert into log_DB(tag_num,date,time)
         values (%s, CURRENT_DATE(), CURRENT_TIME())"""

curs.execute(sql, (result['tag_num']))

sql = """insert into current(tag_num,date,time)
         values (%s, CURRENT_DATE(), CURRENT_TIME())"""

curs.execute(sql, (result['tag_num']))

conn.commit()

conn.close()
