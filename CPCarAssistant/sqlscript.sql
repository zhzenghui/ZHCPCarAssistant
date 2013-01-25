CREATE TABLE 'ConsumeRecord' ('id'  , 'type' CHAR(1), 'price' float, 'uptime' datetime);
CREATE TABLE 'MyCar' ('id'  integer, 'carNum' varchar(15), 'carModel' varchar(30), 'paytime' datetime, 'currentMileage' float);
CREATE TABLE 'Message' ('id' integer, 'Dealer' varchar(15), 'UDID' varchar(64), 'Message' varchar(300), 'Answer' varchar(300),'IsAnswer' bool, 'uptime' datetime);

