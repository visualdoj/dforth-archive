include(`blogspot.m4')dnl

���� ����� � ���� ������ �� ��������� �����������.

SUBHEADER(��� ����� ����������)

� ���� ������ ��� ������������ ��������������� �����, ��� ����������� ��������� �� �������� ��� ������������� ���������� ���� � �������� ���.

SUBHEADER(����� ��� ����� ����������)

LIST
  ITEM(����� �������� ����������. ����������� ������������� �� ���������� ����������� ����� ���� DEmbro.)
  ITEM(����� ������� �������. ������ ��� ������� ������� �� ����� ������� ������ �� �������, ���� ���������� �� � ���������� ������ � ����� ���������� ��������� �� ����� ����������, sTIRET ����� �� ����� ���������� ������������� ������������ ���, �������������� ��������� �� ��������� ����.)
  ITEM(������ ������ �������������.)
  ITEM(��������� �������� �� ����������. ����� ���� �����-������ ����� ����������� �����������.)
END

� �����-�� ������� ������� ���������� ����� ���� ���� � �� �����, ������� � ��� ����� �������. ���, ��������, ���������� ���������� ������� ������� � �������� ����� (Free Pascal):

{$APPTYPE CONSOLE}
type
  TFunc = function (A, B: Integer): Integer; register;
const
  Func_Add: Cardinal = $c3d001; // Result := A + B
  Func_Sub: Cardinal = $c3d029; // Result := A - B
  Func_Mul: Cardinal = $c3e2f7; // Result := A * B
  Func_Xor: Cardinal = $c3d031; // Result := A xor B
  Func_Lin: Cardinal = $c390048d; // Result := A + 4*B
begin
  Writeln('32 + 12 = ', TFunc(@Func_Add)(32, 12));
  Writeln('32 - 12 = ', TFunc(@Func_Sub)(32, 12));
  Writeln('32 * 12 = ', TFunc(@Func_Mul)(32, 12));
  Writeln('32 xor 12 = ', TFunc(@Func_Xor)(32, 12));
  Writeln('32 + 4*12 = ', TFunc(@Func_Lin)(32, 12));
end.

���� �� ������� ������ �� ����������, ���� ������� �������� �������� ���������� ������������� � ����� ����������� ����������.

SUBHEADER(������� ������, FreePascal+M4)

� ����� �� ��������� (���� �����, ���) �� ���� � �������� ������� ������� ������, ���������� ������������ ���. ���� �� ���� ������� �� ����� ��������, �� � �������� ��������� ������������� ���� �� ���� (��������, ���� ��� ����� ����� ��������� � ������ �������� ��������� ����������� �������).

� ����� ����������� ��������� �������������� ����������� ������� �������� ����� �������, ������������� ������� ���������� �� ������������� ����������. ����� ���������� ����� � ���������� �����-�� ��������� �������� ������. ��� ���� ����� �������� �����. ���������� �� ��������� ����� ���:

������ �����, ���������, � ��������. �� ����� ���� �� � ����, � � ���������� ��������� ���� ����������� i386, � ��� ������ ������������ ������� � ���, ��� ������� �������� � ����������. ������� ��������� ��������.

����� �� ����� ������� (� ����� ��������) �������� ������� MONO(mov). ��� �������� �� QUOTE(Intel 64 and IA-32 Architectures Software Developer's Manual):

IMG(...)

� ���� ������� ��������� ������������� ������� MONO(mov), ������� ����� �������������� � �������� ����. � ����� ����� ������� ������� ����� ������ ������������ ����������� ������������� � ����� ������� ������������ ���� �� ���������. ��������, MONO(+rd) ��������, ��� ��� �������� ����������� � ������ ���� �������, � MONO(/r) sTIRET ��� ������� ����� �������� � �������������� MONO(ModR/M) �����.

SUBHEADER(������� ������, DEmbro)

SUBHEADER(���������� ��������)

SUBHEADER(���������� ������ ������)

SUBHEADER(�������������� �����)

SUBHEADER(��������� ���������� ������)

SUBHEADER(��������� ���� ���������� � �������)

SUBHEADER(�����, ��������)

SUBHEADER(��������������� ��������� � ����, hello world ���������)

SUBHEADER(����� ������ �� ���������� � DEmbro)

SUBHEADER(��� �� �������� ������)

SUBHEADER(�����, ���� ����������� ��������)

SUBHEADER(������ ������ � ����������)
