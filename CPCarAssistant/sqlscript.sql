CREATE TABLE 'ConsumeRecord' ('id'  , 'type' CHAR(1), 'price' float, 'uptime' datetime);
CREATE TABLE 'MyCar' ('id'  integer, 'carNum' varchar(15), 'carModel' varchar(30), 'paytime' datetime, 'currentMileage' float);
CREATE TABLE 'Message' ('id' integer, 'Dealer' varchar(15), 'UDID' varchar(64), 'Message' varchar(300), 'Answer' varchar(300),'IsAnswer' bool, 'uptime' datetime);
CREATE TABLE 'Auto' ( 'AutoID' integer, 'SeriesID' integer, 'Name' varchar(20), 'AutoImg' varchar(100), 'MSRP' float,'IsTestDrive' integer, 'OrderNum' integer);
CREATE TABLE 'AutoSeries' ( 'SeriesID' integer, 'Name' varchar(20), 'SeriesImg' varchar(100), 'Describe' varchar(20), 'OrderNum' integer);
CREATE TABLE 'Images' ( 'ImageID' integer, 'AutoID' integer, 'Thumbnail' varchar(100), 'ImgURL' varchar(100), 'Describe' varchar(20), 'Name' varchar(20), 'SeriesImg' integer, 'OrderNum' integer);

