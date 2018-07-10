# In-development Penguin Chat emulator written in Node.js

<h1 align="left">Pseudo crypto code by me</h1>

<p align="left"><img src="https://i.imgur.com/X5wkBx5.png"></p>

# TODO

* createRoom system and packets.

```
[Sending]: <msg t='sys'><body action='verChk' r='0'><ver v='158' /></body></msg>

[ RECEIVED ]: <cross-domain-policy><allow-access-from domain='mpandanda.eu' to-ports='9718' /><allow-access-from domain='127.0.0.1' to-ports='9939' /><allow-access-from domain='*.mpandanda.eu' to-ports='9718' /><allow-access-from domain='127.0.0.1' to-ports='9718' /><allow-access-from domain='localhost' to-ports='9718' /></cross-domain-policy>, (len: 335)
[ RECEIVED ]: <msg t='sys'><body action='apiOK' r='0'></body></msg>, (len: 53)
[Sending]: <msg t='sys'><body action='login' r='0'><login z='pandanda_dev'><nick><![CDATA[DJFang]]></nick><pword><![CDATA[12345678]]></pword></login></body></msg>

[ RECEIVED ]: <msg t='sys'><body action='logOK' r='0'><login n='DJFang' id='76' mod='0'/></body></msg>, (len: 98)
[Sending]: <msg t='sys'><body action='getRmList' r='-1'></body></msg>

[ RECEIVED ]: <msg t='sys'><body action='rmList' r='0'><rmList><rm id='1' priv='0' temp='0' game='0' ucnt='0' maxu='50' maxs='0'><n><![CDATA[EN_village]]></n></rm></rmList></body></msg>
[Sending]: <msg t='sys'><body action='autoJoin' r='-1'></body></msg>

[ RECEIVED ]: <msg t='sys'><body action='joinOK' r='38'><pid id='0'/><vars /><uLs r='38'><u i='76' m='0'><n><![CDATA[DJFang]]></n><vars></vars></u></uLs></body></msg>
[Sending]: <msg t='xt'><body action='xtReq' r='38'><![CDATA[<dataObj><var n='cmd' t='s'>verify</var><var n='name' t='s'>verifyUserExt</var><obj t='o' o='param'><var n='cmd' t='s'>verify</var><var n='name' t='s'>DJFang</var><var n='pass' t='s'>robiebebe1</var></obj></dataObj>]]></body></msg>

[ RECEIVED ]: <msg t='xt'><body action='xtRes' r='-1'><![CDATA[<dataObj><var n='level' t='n'>9999</var><var n='isMember' t='n'>1</var><var n='_cmd' t='s'>loginSuccess</var><var n='info' t='s'>pandanda_dev,game1,127.0.0.1,9939,0,false,false,0,false</var></dataObj>]]></body></msg>
```
