unit DEvents;

interface

uses
  DMath;

Type
{TEventID = (
                eiNo,
                eiKey,
                eiKeyUp,
                eiClick,
                eiClickUp,
                eiLevel
           );
TMouseButton = (
                        mbLeft,
                        mbMiddle,
                        mbRight,
                        mbDLeft
               ); }


{TEvent = record
  case ID: TEventID of
    eiNo: (S: ShortTString);
    eiKey, eiKeyUp: (Key: Integer);
    eiClick, eiClickUp: (Button: TMouseID;
                         Mouse: TVec2f);
    eiLevel: (FileName: ShortTString);
end;}
TEvent = class
  //  ID: TEventID;
  //  S: ShortTString;
  //  Key: Integer;
  //  Button: TMouseButton;
  //  Mouse: TVec2f;
  //  FileName: TString;
end;

// TOnEventObj = procedure (var Event: TEvent) of object; 
// function eTString(ID: TEventID; S: TString): TEvent; inline;

implementation

{function eTString(ID: TEventID; S: TString): TEvent; inline;
begin
  Result.ID := ID;
  Result.S := S;
end;}

end.
