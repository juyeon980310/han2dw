#include <ESP8266WiFi.h>
#include <PubSubClient.h>
#include <EEPROM.h>
#include <DNSServer.h>
#include <ESP8266WebServer.h>
#include <WiFiManager.h> 
const char* mqttServer = "192.168.1.7";    // IP adress Raspberry Pi
const int mqttPort = 1883;
const char* mqttUser = "han2um";      // if you don't have MQTT Username, no need input
const char* mqttPassword = "root";  // if you don't have MQTT Password, no need input

//eeprom function
void writeString(char add,String data);
String read_String(char add);

WiFiClient espClient;
PubSubClient client(espClient);

void setup() {

  Serial.begin(115200);
  WiFiManager wifiManager;
  wifiManager.autoConnect("AutoConnectAP");
  Serial.println("connected...yeey :)");
  //EEPROM Setting
  EEPROM.begin(512);

  client.setServer(mqttServer, mqttPort);
  client.setCallback(callback);

  while (!client.connected()) {
    Serial.println("Connecting to MQTT...");

    if (client.connect("ESP8266Client", mqttUser, mqttPassword )) {

      Serial.println("connected");

    } else {

      Serial.print("failed with state ");
      Serial.print(client.state());
      delay(2000);

    }
  }

//  client.publish("esp8266", "Hello Raspberry Pi");
//  client.subscribe("esp8266");

}

void callback(char* topic, byte* payload, unsigned int length) {
  
  String gpsCode = "";
  Serial.print("Message arrived in topic: ");
  Serial.println(topic);

  Serial.print("Message:");
  for (int i = 0; i < length; i++) {
    Serial.print((char)payload[i]);
      gpsCode += (char)payload[i];
  }
  
  if(read_String(10) != gpsCode){
    writeString(10, gpsCode);  //Address 10 and String type data
  }
  else
    writeString(10,"");
  
  delay(10);

  Serial.println();
  Serial.println("-----------------------");

}

void loop() {
    String recivedData;
    //client.publish("esp8266", "This test transmit message");
    client.subscribe("esp8266");
    recivedData = read_String(10);
    //Serial.print("Read Data:");
    //Serial.println(recivedData);
    delay(300);
  client.loop();
}

void writeString(char add,String data)
{
  int _size = data.length();
  int i;
  for(i=0;i<_size;i++)
  {
    EEPROM.write(add+i,data[i]);
  }
  EEPROM.write(add+_size,'\0');   //Add termination null character for String Data
  EEPROM.commit();
}


String read_String(char add)
{
  int i;
  char data[100]; //Max 100 Bytes
  int len=0;
  unsigned char k;
  k=EEPROM.read(add);
  while(k != '\0' && len<500)   //Read until null character
  {    
    k=EEPROM.read(add+len);
    data[len]=k;
    len++;
  }
  data[len]='\0';
  return String(data);
}
