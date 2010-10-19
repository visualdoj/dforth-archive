unit dgraph_quad;

interface

uses
  gl,
  dgraph,
  dtexture,
  dmath;

type
  PVertices2f = ^TVertices2f;
  TVertices2f = array[0..3] of TVec2f;
  PVertices4f = ^TVertices4f;
  TVertices4f = array[0..3] of TVec4f;

type
TQuad2f = class
 private
  _tex: TTex;
  _vertices: PVertices2f;
  _texcoords: PVertices2f;
  _colors: PVertices4f;
  _needdispose: Boolean;
 public
  constructor Create; overload;
  constructor Create(
        tex: TTex;
        vertices: PVertices2f;
        texcoords: PVertices2f;
        colors: PVertices4f;
      ); overload;
  destructor Destroy; override;
  class procedure Draw(
        graph: TGraph;
        tex: TTex;
        const vertices: TVertices2f;
        const texcoords: TVertices2f;
        const colors: TVertices4f;
      );
  procedure Draw(graph: TGraph); overload;
  property tex: TTex read _tex write _tex;
  property vertices: PVertices2f read _vertices;
  property texcoords: PVertices2f read _texcoords;
  property colors: PVertices4f read _colors;
end;

implementation

{$IFNDEF FLAG_FPC}{$REGION 'TQuad2f'}{$ENDIF}
constructor TQuad2f.Create;
begin
  _tex := nil;
  New(_vertices);
  New(_texcoords);
  New(_colors);
  _needdispose := True;
end;

constructor TQuad2f.Create(
      vertices: PVertices2f;
      texcoords: PVertices2f;
      colors: PVertices4f;
    );
begin
  _tex := tex;
  _vertices := vertices;
  _texcoords := texcoords;
  _colors := colors;
  _needdispose := false;
end;

destructor TQuad2f.Destroy;
begin
  if _needdispose then begin
    Dispose(_vertices);
    Dispose(_texcoords);
    Dispose(_colors);
  end;
end;

class procedure TQuad2f.Draw(
      graph: TGraph;
      tex: TTex;
      const vertices: TVertices2f;
      const texcoords: TVertices2f;
      const colors: TVertices4f;
    );
  var
    i: Integer;
begin
  tex.Bind;
  glBegin(GL_QUADS);
    for i := 0 to 3 do begin
      glTexCoord2fv(@texcoords[i]);
      glColor4fv(@colors[i]);
      glVertex2fv(@vertices[i]);
    end; 
  glEnd;
  tex.Unbind;
end;

procedure TQuad2f.Draw(graph: TGraph);
begin
  Draw(graph, _tex, _vertices, _texcoords, _colors);
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

end.
