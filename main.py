import board
import busio
import pymysql
import time
#from digitalio import DigitalInOut
from adafruit_pn532.i2c import PN532_I2C
from tkinter import *
import paho.mqtt.client as mqtt

mqtt_username = "han2um"
mqtt_password = "root"
mqtt_topic = "esp8266"
mqtt_broker_ip = "192.168.1.5"
select_card = ""
select_info = ""

client = mqtt.Client()
client.username_pw_set(mqtt_username, mqtt_password)

index = 0

def on_connect(client, userdata, flags, rc):
    print ("Connected!", str(rc))
    client.subscribe(mqtt_topic)

def on_message(client, userdata, msg):
    print ("Topic: ", msg.topic + "\nMessage: " + str(msg.payload))

def on_publish(client, userdata, result):
    pass

def exitProgram():
    win.quit()
    win.destroy()

def upHighlight():
    global index
    index = mylistbox.curselection()[0]
    if index == 0:
        return
    index -= 1
    if index < mylistbox.size() and index != mylistbox.size():
        mylistbox.select_clear(index + 1)
        mylistbox.select_set(index)
        mylistbox.yview(index)
    elif index == mylistbox.size():
        mylistbox.select_set(index)
        mylistbox.yview(index)

def downHighlight():
    global index
    index = mylistbox.curselection()[0]
    if index == mylistbox.size() - 1:
        return
    index += 1
    if index == 0:
        mylistbox.select_set(index)
        mylistbox.yview(index)
    elif index < mylistbox.size() and index != 0:
        mylistbox.select_clear(index - 1)
        mylistbox.select_set(index)
        mylistbox.yview(index)

def CurSelet(evt):
    global select_info
    select_info=str((mylistbox.get(ANCHOR)))

def detail_frame(frame):
    global select_card
    number = False
    conn = pymysql.connect(host='localhost', user='han2um', password='root',db='mobile_type', charset='utf8')
    curs = conn.cursor(pymysql.cursors.DictCursor)
    for i in select_info:
        if i == '/':
            break
        elif number == True and i != '/':
            select_card += i
        elif i == ' ':
            number = True
    sql = "select * from tag_use where tag_id=%s"
    curs.execute(sql, select_card)
    tagInfo = curs.fetchone()
    conn.commit()
    conn.close()
    print(select_card)
    print(tagInfo)
    frame.tkraise()
    detailLabel.configure(text="""UserID=%s TagID=%s TagGcode=%s TagNumber=%s LastGcode=%s Direction=%s Date&Time=%s elapsedTime=%s
        """ % (tagInfo['u_id'],tagInfo['tag_id'],tagInfo['tag_gcode'],tagInfo['tag_count'],tagInfo['last_gcode'],tagInfo['direction'],tagInfo['datetime'],tagInfo['elapsed_time']))
def back_frame(frame):
    global select_card
    select_card = ""
    frame.tkraise()


client.on_connect = on_connect
client.on_publish = on_publish


currentCardList = ['d5ead2f','218c253b','12345678','87654321']
currentGcode =    ['37.815500 126.793500','37.815200 126.794000','37.815200 126.795000','37.815000 126.798000']
lastCardList = ['e57ec822','33332222']
lastGcode =    ['37.815500 126.793000','37.816163 126.801333']

i2c = busio.I2C(board.SCL, board.SDA)
pn532 = PN532_I2C(i2c, debug=False)
ic, ver, rev, support = pn532.get_firmware_version()
pn532.SAM_configuration()
print('Waiting for RFID/NFC card...')

while True:
    uid = pn532.read_passive_target(timeout=0.5)
    cardID = ""         # tag_id
    userID = ""         # u_id
    readData = ""       # TagData
    current_gcode = ""
    last_gcode = ""
    isCurrent = False

    if uid is None:
        continue
    for i in uid:
        uid = str(hex(i))
        cardID = cardID + uid[2:]

    if (currentCardList.count(cardID) > 0):
        for i in currentCardList:
            if (cardID == currentCardList[currentCardList.index(i)]):
                isCurrent = True
                current_gcode = currentGcode[currentCardList.index(i)]
    elif (lastCardList.count(cardID) > 0):
        for i in lastCardList:
            if (cardID == lastCardList[lastCardList.index(i)]):
                last_gcode = lastGcode[lastCardList.index(i)]
    else:
        print("Can't find the card")

    if (isCurrent):
        client.connect(mqtt_broker_ip, 1883)
        client.publish("esp8266",current_gcode)
        client.disconnect()

    conn = pymysql.connect(host='localhost', user='han2um', password='root',db='rental', charset='utf8')
    curs = conn.cursor(pymysql.cursors.DictCursor)
    # Check userID
    curs.execute("select u_id from tag_rental where key_id='000001'")
    userID = curs.fetchone()['u_id']
    userID = str(userID)
    conn.commit()
    conn.close()
        
    conn = pymysql.connect(host='localhost', user='han2um', password='root',db='mobile_type', charset='utf8')
    curs = conn.cursor(pymysql.cursors.DictCursor)

    # Check First
    sql = "select no from mobile_current where u_id=%s"
    curs.execute(sql,userID)
    isFirst = curs.fetchone()

    # Check Second Tag
    sql = "select no from tag_use where tag_id=%s"
    curs.execute(sql,cardID)
    secondFlag = curs.fetchone()

    # Nothing Tag value and Current Tag
    if isFirst is None and isCurrent == True:
        # Insert mobile_current
        sql = """insert into mobile_current(u_id,last_gcode,current_gcode,datetime,direction)
                values (%s, %s, %s, CURRENT_TIMESTAMP(), 'UP')"""
        curs.execute(sql,(userID, lastGcode[0], current_gcode))

        # Insert tag_use table
        sql = """insert into tag_use(u_id, tag_id, tag_gcode, tag_count, last_gcode, direction, datetime)
                            values (%s,%s,%s,'1',%s,'UP', CURRENT_TIMESTAMP())"""
        curs.execute(sql,(userID,cardID,current_gcode,lastGcode[0]))

    # Next fix tag
    elif not (isFirst is None) and isCurrent == False:
        # Update state
        sql = "update mobile_current set current_gcode = %s, last_gcode = %s, datetime = CURRENT_TIMESTAMP() where u_id = %s"
        curs.execute(sql,(last_gcode, last_gcode, userID))

    # Next mobile tag
    elif secondFlag is None and not (isFirst is None) and isCurrent == True:

        # Calc elapsed_time
        curs.execute('select datetime from mobile_current')
        prevTime =  curs.fetchone()['datetime']
        curs.execute('select CURRENT_TIMESTAMP() as curtime')
        currentTime = curs.fetchone()['curtime']
        sql = "select TIMESTAMPDIFF(second, date_format(%s,'%%Y-%%m-%%d %%H:%%i:%%s'), date_format(%s,'%%Y-%%m-%%d %%H:%%i:%%s')) as time_diff"
        curs.execute(sql, (prevTime,currentTime))
        elapsedTime = curs.fetchone()['time_diff']

        # Calc coun
        curs.execute('select tag_count from tag_use order by tag_count limit 1')
        count = curs.fetchone()['tag_count']

        # Get last gcode
        sql = 'select last_gcode from mobile_current where u_id=%s'
        curs.execute(sql, userID)
        last_gcode = curs.fetchone()['last_gcode']

        # Update state
        sql = "update mobile_current set current_gcode = %s, datetime = CURRENT_TIMESTAMP() where u_id = %s"
        curs.execute(sql,(current_gcode, userID))

        # Insert tag_use table
        sql = """insert into tag_use(u_id, tag_id, tag_gcode, tag_count, last_gcode, direction, datetime ,elapsed_time)
                            values (%s,%s,%s,%s,%s,'UP',CURRENT_TIMESTAMP(),%s)"""
        curs.execute(sql,(userID, cardID, current_gcode, count + 1, last_gcode, elapsedTime))

    # Mobile tag retagging
    elif not (isFirst is None) and isCurrent == True and not (secondFlag is None):
        # delete tag
        sql = "delete from tag_use where tag_id=%s"
        curs.execute(sql, cardID)

        # check final
        sql = "select no from tag_use where u_id = %s" 
        curs.execute(sql, userID)
        isFinal = curs.fetchone()
        
        if isFinal is None:
            sql = "delete from mobile_current where u_id = %s"
            curs.execute(sql, userID)
        else:
            # Update state
            sql = "update mobile_current set current_gcode = %s, datetime = CURRENT_TIMESTAMP(), direction='DOWN' where u_id = %s"
            curs.execute(sql,(current_gcode, userID))

    # Data Read
    curs.execute("select tag_id, tag_gcode, datetime from tag_use")
    readData = curs.fetchall()

    # Write Data.txt File
    with open("data.txt",'w') as f:
        for row in readData:
            f.write("%s/%s/%s\n" % (row['tag_id'],row['tag_gcode'],str(row['datetime'])[:10]))
    # Read Data.txt File
    with open("data.txt",'r') as f:
        data = f.readlines()

    conn.commit()
    conn.close()

    win = Tk()
    win.title("GPS CODE")
    win.attributes('-fullscreen',True)
    win.geometry('320x240+0+0')

    f1 = Frame(win)
    f2 = Frame(win)
    f1.grid(row=0,column=0,sticky='news',ipadx=320, ipady=240)
    f2.grid(row=0,column=0,sticky='news',ipadx=320, ipady=240)

    mylistbox = Listbox(f1, width=42, height=12,font=('helvetica',10)) # Create a scrolledtext
    mylistbox.bind('<<ListboxSelect>>',CurSelet)
    mylistbox.place(x=10,y=10)
    mylistbox.yview()

    detailButton = Button(f1, text = "Detail", height =1, width = 6,  command =lambda:detail_frame(f2))
    detailButton.place(x=58,y=208)

    exitButton = Button(f1, text = "Exit",  command = exitProgram, height =1, width = 6)
    exitButton.place(x=168,y=208)

    # Insert Data to ListBox
    for i,value in enumerate(data):
        mylistbox.insert(END,"%s %s" %(i+1, value))
    
    detailLabel = Label(f2, text="Can't find about card", font=('helvetica',10),wraplength=240)
    detailLabel.place(x=10,y=10)

    Button(f2, text = "Back", height =1, width = 6,  command =lambda:back_frame(f1)).place(x=118,y=208)

    f1.tkraise()
    mainloop()