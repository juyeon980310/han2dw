import binascii
import sys
import time
import pymysql
import Adafruit_PN532 as PN532

CS   = 8
MOSI = 10
MISO = 9
SCLK = 11

pn532 = PN532.PN532(cs=CS, sclk=SCLK, mosi=MOSI, miso=MISO)
pn532.begin()
ic, ver, rev, support = pn532.get_firmware_version()
print('Found PN532 with firmware version: {0}.{1}'.format(ver, rev))
pn532.SAM_configuration()

print('Waiting for MiFare card...')
while True:
    uid = pn532.read_passive_target()
    if uid is None:
        continue
    uid_hex = format(binascii.hexlify(uid))
    print('Found card with UID: 0x{0}'+uid_hex)

    conn = pymysql.connect(host='localhost', user='han2dw', password='root',
                       db='han2um', charset='utf8')
    curs = conn.cursor(pymysql.cursors.DictCursor)

    curs.execute("select tag_id from key_table")
    tag = curs.fetchall()

    if {'tag_id': uid_hex} in tag:

      sql = "select tag_num from key_table where tag_id=%s"
      curs.execute(sql, uid_hex)
      tagNum = curs.fetchone()

      sql = "select tag_num from current where tag_num=%s"
      curs.execute(sql, (tagNum['tag_num']))
      tagFlag = curs.fetchone()
                    
      if tagFlag is None:
         sql = """insert into log_DB(tag_num,date,time)
			         values (%s, CURRENT_DATE(), CURRENT_TIME())"""
         curs.execute(sql, (tagNum['tag_num']))
         sql = """insert into current(tag_num,date,time)
						values (%s, CURRENT_DATE(), CURRENT_TIME())"""
         curs.execute(sql, (tagNum['tag_num']))
         print(tagNum['tag_num'], " Tag Flag ON")

      if tagFlag > 0:
         sql = """insert into log_DB(tag_num,date,time,status)
						values (%s, CURRENT_DATE(), CURRENT_TIME(), 0)"""
         curs.execute(sql, (tagNum['tag_num']))
         sql = "delete from current where tag_num=%s"
         curs.execute(sql, (tagNum['tag_num']))
         print(tagNum['tag_num'], " Tag Flag OFF")

      conn.commit()
      conn.close()
      time.sleep(2)
      print('Waiting for MiFare card...')
      continue
