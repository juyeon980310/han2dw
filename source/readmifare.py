import binascii
import sys
import os
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

    conn = pymysql.connect(host='localhost', user='han1um', password='root',
                       db='han2um', charset='utf8')
    curs = conn.cursor(pymysql.cursors.DictCursor)

    curs.execute("select tag_id from key_table")
    tag = curs.fetchall()
    if {'tag_id': uid_hex} in tag:
		sql = "select tag_num from key_table where tag_id=%s"
		curs.execute(sql,uid_hex)
		tagNum = curs.fetchone()
		print(tagNum)
		sql = "select tag_num from current where tag_num=%s"
		curs.execute(sql, (tagNum['tag_num']))
		tagFlag = curs.fetchone()
		
    if not pn532.mifare_classic_authenticate_block(uid, 4, PN532.MIFARE_CMD_AUTH_B,
                                                   [0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF]):
        print('Failed to authenticate block 4!')
        continue
    data = pn532.mifare_classic_read_block(4)
    if data is None:
        print('Failed to read block 4!')
        continue
    print('Read block 4: 0x{0}'.format(binascii.hexlify(data[:4])))
