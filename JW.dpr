program JW;
uses
  System.SysUtils,
  superobject;

//класс без использования доп. библиотеки
type
JsonWrapper1 = class
  function MakeJson(): string;
end;
function JsonWrapper1.MakeJson(): string;
var data: array [0..5] of string;
begin
  data[0] := '16842755';
  data[1] := '0';
  data[2] := '0';
  data[3] := '324665904';
  data[4] := '0';
  data[5] := '8.000';
  //один format пишет, что строка слишком длинная
  MakeJson := Format('{"spliceEventID":%s,"spliceEventCancelIndicator":0,'
  +'"outOfNetworkIndicator":1,"programSpliceFlag":1,"durationFlag":%s,'
  +'"spliceImmediateFlag":%s,"spliceTime":{"timeSpecifiedFlag":1,'
  +'"ptsTime":%s},"breakDuration":'
  +'{"autoReturn":0,"duration":%s,', [data[0], data[1], data[2], data[3], data[4]])
  + Format('"uniqueProgramID":256,"availNum":0,"availsExpected":0,'
  +'"prerollTime":%s,"arrivalTime":99074178.360}}', [data[5]]);
end;

//uses superobject
type
JsonWrapper2 = class
  function MakeJson(): string;
end;
function JsonWrapper2.MakeJson(): string;
var
  json, spliceTime, breakDuration: ISuperObject;
begin

  spliceTime := SO;
  spliceTime.I['timeSpecifiedFlag'] := 1;
  spliceTime.I['ptsTime'] := 324665904;

  breakDuration := SO;
  breakDuration.I['autoReturn'] := 0;
  breakDuration.I['duration'] := 0;

  json := SO;
  json.I['spliceEventID'] := 16842755;
  json.I['spliceEventCancelIndicator'] := 0;
  json.I['outOfNetworkIndicator'] := 1;
  json.I['programSpliceFlag'] := 1;
  json.I['durationFlag'] := 0;
  json.I['spliceImmediateFlag'] := 0;
  json.O['spliceTime'] := spliceTime;
  json.O['breakDuration'] := breakDuration;
  json.I['uniqueProgramID'] := 256;
  json.I['availNum'] := 0;
  json.I['availsExpected'] := 0;
  json.I['prerollTime'] := 8000;  ///
  json.D['arrivalTime'] := 99074178.360;

  MakeJson := json.AsString;
end;

//пример
var JW1: JsonWrapper1;
    JW2: JsonWrapper2;
begin
  writeln(JW1.MakeJson());
  writeln;
  writeln(JW2.MakeJson());
  readln;
end.
