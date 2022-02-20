program Lab13;
uses Tree;
var
  tr: PNode;
begin

//Вводим дерево из файла
tr:= Input(ParamStr(1));
Screen(tr);
writeln(' Содержимое файла ');

if Search(tr, 'r') <> nil then
tr:= AddToTree(tr, 'r');
Screen(tr);
writeln(' После добавления "b" ');

if Search(tr, 'r') <> nil then
tr:= AddToTree(tr, 'r');
Screen(tr);
writeln(' После добавления "r" ');

if Search(tr, 'c') <> nil then
DeleteSubTree(tr, 'c');
Screen(tr);
writeln(' После удаления "c" ');

if Search(tr, 't') <> nil then
DeleteSubTree(tr, 't');
Screen(tr);
writeln(' После удаления "t" ');

writeln(' Количество элементов "b" и "r" в дереве: ', Count(tr));

Delete(tr);

end.