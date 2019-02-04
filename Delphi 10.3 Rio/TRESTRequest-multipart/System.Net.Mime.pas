[...]

procedure TMultipartFormData.AdjustLastBoundary;
begin
  if FLastBoundaryWrited then
  begin
    // original FStream.Position := FStream.Size - (Length(FBoundary) + 4);
    FStream.Position := FStream.Size - (Length(FBoundary) + 6);
    FLastBoundaryWrited := False;
  end;
end;

[...]