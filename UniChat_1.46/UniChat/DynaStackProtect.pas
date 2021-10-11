unit DynaStackProtect;

interface

uses classes;

type
  TStackProtect = class(TObject)
  private
    FPacketsList: TList;
    GStackSize: integer;

//    function FGetStackSize: integer;
    procedure FClearStack;
  public

    constructor Create;
    destructor Destroy; override;

    function PushPacket(const DynaKey: integer): boolean;

    procedure SetStackSize(i: integer);

  protected

  end;

implementation

uses SysUtils;

constructor TStackProtect.Create;
begin
  GStackSize:=3;
  FPacketsList := TList.Create;
  inherited Create;
end;

destructor TStackProtect.Destroy;
var
  i: integer;
begin

  for i := 0 to FPacketsList.Count - 1 do
    FreeMem(FPacketsList.Items[i]);

  FPacketsList.Free;
  inherited Destroy;
end;

procedure TStackProtect.FClearStack;
var
  i: integer;
begin
  for i := 0 to FPacketsList.Count - 1 do
  begin
    FreeMem(FPacketsList.Items[i]);
    FPacketsList.Clear;
  end;
end;

function TStackProtect.PushPacket(const DynaKey: integer): boolean;
var
  i: integer;
  p: PInteger;
begin
  Result := False;

  for i := 0 to FPacketsList.Count - 1 do
    if integer(FPacketsList.Items[i]^) = DynaKey then
    begin
      Result := True;
      FPacketsList.Exchange(0, i);
    end;

  if not result then
  begin
    if FPacketsList.Count = GStackSize then
    begin
      FreeMem(FPacketsList.Items[FPacketsList.Count - 1]);
      FPacketsList.Delete(FPacketsList.Count - 1);
    end;
    p:=AllocMem(4);
    
    if p <> nil then
    begin
    move(DynaKey, p^, 4);
    FPacketsList.add(p);
    end;
//    p:=nil;

//    FreeMem(p);
  end;

end;

procedure TStackProtect.SetStackSize(i: integer);
begin
  if GStackSize > i then FClearStack;
  GStackSize := i;
end;

end.

