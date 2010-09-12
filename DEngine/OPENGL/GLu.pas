{$IFDEF FLAG_FPC}
{$MACRO ON}
{$MODE Delphi}
{$IFDEF Windows}
  {$DEFINE extdecl := stdcall}
{$ELSE}
  {$DEFINE extdecl := cdecl}
{$ENDIF}
{$ENDIF}
unit GLu;

interface

uses
  GL;
 
const
  glu32 = 'glu32.dll';

function gluBuild2DMipmaps(target: GLenum; components, width, height: GLint; format, atype: GLenum; const data: Pointer): Integer; {$IFDEF FLAG_FPC}extdecl{$ELSE}stdcall{$ENDIF}; external glu32;
procedure gluPerspective(fovy, aspect, zNear, zFar: GLdouble); {$IFDEF FLAG_FPC}extdecl{$ELSE}stdcall{$ENDIF}; external glu32;

implementation

end.
