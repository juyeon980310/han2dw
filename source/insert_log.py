import pymysql


conn = pymysql.connect(host='localhost', user='han1um', password='root',
                       db='han2um', charset='utf8')
 
curs = conn.cursor(pymysql.cursors.DictCursor)

sql = "select tag_num from key_table where tag_id='99734356'"
curs.execute(sql)
tagNum = curs.fetchone()
#print(result['tag_num'])

sql = "select tag_num from current where tag_num=%s"
curs.execute(sql, (tagNum['tag_num']))
tagFlag = curs.fetchone()
print(tagFlag)


sql = """insert into log_DB(tag_num,date,time)
			values (%s, CURRENT_DATE(), CURRENT_TIME())"""
if tagFlag is None:
	curs.execute(sql, (tagNum['tag_num']))

sql = """insert into current(tag_num,date,time)
         values (%s, CURRENT_DATE(), CURRENT_TIME())"""

if tagFlag is None:
	curs.execute(sql, (tagNum['tag_num']))

conn.commit()

conn.close()
