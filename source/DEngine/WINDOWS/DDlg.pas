unit DWTDlg;

interface

uses
  windows,
  DWinApi;

// ���������� ����� � ������ ext, ���������� ���� � �����
Function GetSaveFile(Window: TWindow; ext: string = '*'): string;
// �������� ����� ������� ext, ���������� ���� � �����
Function GetLoadFile(Window: TWindow; ext: string = '*'): string;

implementation

Const
  OFN_PATHMUSTEXIST = $00000800;
  OFN_HIDEREADONLY = $00000004;
  OFN_FILEMUSTEXIST = $00001000;

  commdlg32 = 'comdlg32.dll';

Type
  tagOFNA = packed record
    lStructSize: DWORD;
    hWndOwner: HWND;
    hInstance: HINST;
    lpstrFilter: PAnsiChar;
    lpstrCustomFilter: PAnsiChar;
    nMaxCustFilter: DWORD;
    nFilterIndex: DWORD;
    lpstrFile: PAnsiChar;
    nMaxFile: DWORD;
    lpstrFileTitle: PAnsiChar;
    nMaxFileTitle: DWORD;
    lpstrInitialDir: PAnsiChar;
    lpstrTitle: PAnsiChar;
    Flags: DWORD;
    nFileOffset: Word;
    nFileExtension: Word;
    lpstrDefExt: PAnsiChar;
    lCustData: LPARAM;
    lpfnHook: function(Wnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): UINT stdcall;
    lpTemplateName: PAnsiChar;
    pvReserved: Pointer;
    dwReserved: DWORD;
    FlagsEx: DWORD;
  end;
  tagOFNW = packed record
    lStructSize: DWORD;
    hWndOwner: HWND;
    hInstance: HINST;
    lpstrFilter: PWideChar;
    lpstrCustomFilter: PWideChar;
    nMaxCustFilter: DWORD;
    nFilterIndex: DWORD;
    lpstrFile: PWideChar;
    nMaxFile: DWORD;
    lpstrFileTitle: PWideChar;
    nMaxFileTitle: DWORD;
    lpstrInitialDir: PWideChar;
    lpstrTitle: PWideChar;
    Flags: DWORD;
    nFileOffset: Word;
    nFileExtension: Word;
    lpstrDefExt: PWideChar;
    lCustData: LPARAM;
    lpfnHook: function(Wnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): UINT stdcall;
    lpTemplateName: PWideChar;
    pvReserved: Pointer;
    dwReserved: DWORD;
    FlagsEx: DWORD;
  end;
  tagOFN = tagOFNA;
  TOpenFilenameA = tagOFNA;
  TOpenFilenameW = tagOFNW;
  TOpenFilename = TOpenFilenameA;

function GetSaveFileName(var OpenFile: TOpenFilename): Bool; stdcall; external commdlg32 name 'GetSaveFileNameA';
function GetOpenFileName(var OpenFile: TOpenFilename): Bool; stdcall; external commdlg32 name 'GetOpenFileNameA';

Function GetSaveFile(ext: string): string;
  Var
  SaveDialog: TOpenFilename;
begin
  ZeroMemory(@SaveDialog, SizeOf(SaveDialog));
    with SaveDialog do begin
    // ������ ���������
      lStructSize   := SizeOf(SaveDialog);
    // ������������ ���� (������� ���� ���������)
      hWndOwner     := Window.Handle;
    // ��������� �������� (��������� �����)
      lpstrFilter   := PAnsiChar('����� ' + '*.' + ext + #0 + '*.' + ext + #0#0);
    // ���� ��� ���������� �� ����� ������� ����������, �� ��������� ���...
      lpstrDefExt   := PAnsiChar(ext);
    // ���������� � ������� ��������� ������ ������������
    // �� ���������� ����� "������ ��� ������", �.�. ��������� � ��� �� ������� ;)
      Flags         := OFN_PATHMUSTEXIST or OFN_HIDEREADONLY;
    // ��������� ������������ ������ ����� ����� (����) � �������� �����
      nMaxFile      := 250;
      nMaxFileTitle := nMaxFile;
      GetMem(lpstrFile, nMaxFile);
      ZeroMemory(lpstrFile, nMaxFile);
    end;
    If GetSaveFileName(SaveDialog) then
      Result := SaveDialog.lpstrFile
    else
      Result := '';
  //FreeMem(SaveDialog.lpstrFile);
end;

Function GetLoadFile(ext: string = '*'): string;
  Var
  LoadDialog: TOpenFilename;
begin
  ZeroMemory(@LoadDialog, SizeOf(LoadDialog));
    with LoadDialog do begin
    // ������ ���������
      lStructSize   := SizeOf(LoadDialog);
    // ������������ ���� (������� ���� ���������)
      hWndOwner     := Window.Handle;
    // ��������� �������� (��������� �����)
      lpstrFilter   := PAnsiChar('����� ' + '*.' + ext + #0 + '*.' + ext + #0#0);
    // ���� ��� ���������� �� ����� ������� ����������, �� ��������� ���...
      lpstrDefExt   := PAnsiChar(ext);
    // ���������� � ������� ��������� ������ ������������
    // �� ���������� ����� "������ ��� ������", �.�. ��������� � ��� �� ������� ;)
      Flags         := OFN_PATHMUSTEXIST or OFN_HIDEREADONLY or OFN_FILEMUSTEXIST;
    // ��������� ������������ ������ ����� ����� (����) � �������� �����
      nMaxFile      := 250;
      nMaxFileTitle := nMaxFile;
      GetMem(lpstrFile, nMaxFile);
      ZeroMemory(lpstrFile, nMaxFile);
    end;
    If GetOpenFileName(LoadDialog) then
      Result := LoadDialog.lpstrFile
    else
      Result := '';
end;

end.
