unit UnitInputOutput;

interface

uses 
  UnitTypes;

var
  fin, fout: TextFile;

procedure Get(var x: matrix; var m, n: integer; var t: real; var f: TextFile);
procedure Put(const x: matrix; m, n: integer; name: string; t: real; var f: TextFile);

implementation
 
procedure Get(var x: matrix; var m, n: integer; var t: real; var f: TextFile);
var
  i, j: integer;
begin
  readln(f, m, n, t);
  for i := 1 to m do
  begin
    for j := 1 to n do
      read(f, x[i, j]);
    readln(f);
  end;
end;

procedure Put(const x: matrix; m, n: integer; name: string; t: real; var f: TextFile);
var
  i, j: integer;
begin
  writeln(f, 'Матрица ', name, ' размером ', m:2, ' на ', n:2, ' , её заданное число ', t:4);
  for i := 1 to m do
  begin
    for j := 1 to n do
      write(f, x[i, j]:8:2);
    writeln(f);
  end;
  writeln(f);
end;

initialization 
      AssignFile(fin, 'input.txt');
      Reset(fin);
      AssignFile(fout, 'output.txt');
      Rewrite(fout);  
finalization  
      CloseFile(fin);
      CloseFile(fout);
end.