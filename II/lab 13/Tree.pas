unit Tree;
interface
type

TInfo = string[1];

PNode = ^TNode;

TNode = record
  info: TInfo;
  left, right: PNode;
 end;

procedure Screen (tree: PNode); //вывод элементов бинарного дерева на экран
function Input(name: string): PNode; //ввод элементов бинарного дерева из файла
procedure Delete (var root: PNode); //удаление дерева
function Count (tree: PNode): integer; //определение количества вершин дерева, удовлетворяющих условию
function Search (tree: PNode; info: TInfo): PNode; //поиск вершины, содержащей определённую информацию
procedure DeleteSubTree (var tree: PNode; info: TInfo); //удаление вершины и всех её подвершин
function AddToTree (var tree: PNode; info: TInfo): PNode; //добавление вершины в дерево

implementation

procedure Screen (tree: PNode);
procedure Screen (tree: PNode; n: integer);
begin
  if tree = nil then
    exit;
  Screen (tree^.right, n + 1);
  write(' ' * n);
  writeln(tree^.info);
  Screen(tree^.left, n + 1);
end;
begin
  Screen(tree, 0);
end;

function Input (name: string): PNode;
var f: TextFile;
    info: string;
function Input(): PNode;
begin
  readln(f, info); 
  if info = '*' then
    result := nil
    else
    begin
      new(result);
      result^.info:= info;
      result^.left:= Input();
      result^.right:= Input();
    end;
end;
begin
  AssignFile(f, name);
  Reset(f);
  result:= Input();
  CloseFile(f);
end;

procedure Delete (var root: PNode);
 begin
   if root <> nil then
   begin
     Delete(root^.left);
     Delete(root^.right);
     Dispose(root);
     root:= nil;
   end;
end;

function Count (tree: PNode): integer;
begin
  if tree = nil then
    result := 0
    else
      result:= Count(tree^.left) + ord(tree^.info = 'b') + ord(tree^.info = 'r') + Count(tree^.right);
end;

function Search (tree: PNode; info: TInfo): PNode;
begin
  if tree = nil then
    result := nil
  else if tree^.info = info then
    result := tree
  else
  begin
    result:= Search(tree^.left, info);
    if result = nil then
      result:= Search(tree^.right, info);
  end;
end;

procedure DeleteSubTree (var tree: PNode; info: TInfo);
begin
  if tree = nil then
    exit;
  if tree^.info = info then 
    Delete(tree)
  else
  begin
    if tree^.left <> nil then
      if tree^.left^.info = info then
      begin
        Delete(tree^.left);
        tree^.left:= nil;
      end
      else
      DeleteSubTree(tree^.left, info);
    if tree^.right <> nil then
      if tree^.right^.info = info then
      begin
        Delete(tree^.right);
        tree^.right:= nil;
      end
      else
        DeleteSubTree(tree^.right, info);
  end;
end;

function AddToTree (var tree: PNode; info: TInfo): PNode;
begin
  if tree = nil then
  begin
    new(tree);
    tree^.info:= info;
    tree^.left:= nil;
    tree^.right:= nil;
  end
  else
    if info < tree^.info then
      tree^.left:= AddToTree(tree^.left, info)
    else
      tree^.right:= AddToTree(tree^.right, info);
   result:= tree;
end;

end.



