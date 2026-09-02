program challenge;

uses
  SysUtils;

function ClimbStairs(n: Integer): Int64;
var
  a, b, next: Int64;
  i: Integer;
begin
  a := 1;  // f(0)
  b := 1;  // f(1)

  for i := 1 to n do
  begin
    next := a + b;
    a := b;
    b := next;
  end;

  ClimbStairs := a;
end;

var
  n: Integer;

begin
  if ParamCount < 1 then
  begin
    WriteLn('Usage: challenge <n>');
    Halt(1);
  end;

  n := StrToInt(ParamStr(1));

  WriteLn(ClimbStairs(n));
end.
