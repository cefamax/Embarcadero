# TRESTRequest
**Sending post files with content-type = multipart/formdata**


PROBLEM: Error on sending parameters with the "content-type=multipart/formdata".

 1. If only string parameters are sent, the body is of the type:

> params1 = value1 & params2 = value2...

the problem does not exist

 2. If you send file type parameters or file and string at the same time the body becomes the type



> -----------Embt-Boundary--6AB1E718516A677C
> Content-Disposition: form-data; name="fileupd"; filename="cafcenterAPItest.txt"
> Content-Type: application/octet-stream			
> 
> #file content
> 
> ---------Embt-Boundary--6AB1E718516A677C
> Content-Disposition: form-data; name="uiddwn"
> Content-Type: text/plain
> Content-Transfer-Encoding: quoted-printable
> #string content
> 
> ---------Embt-Boundary--6AB1E718516A677C--

The problem as we can see is that the bondary string that divides each parameter are not the same, in the first there are 2 characters "-" in more; in this case the server can read only the first parameter and not the others.

- - -

  - SOLUTION: in System.Net.Mime.pas 

function --> TMultipartFormData.AdjustLastBoundary;

modify 
  >FStream.Position := FStream.Size - (Length(FBoundary) + 4);

to
>FStream.Position := FStream.Size - (Length(FBoundary) + 6);


in this way all the bondary strings are the same and the server loads all the parameters.

- - -

 - HOW TO UPDATE:

          1. Close Rad Studio IDE; 
          2. Backup "Lib" folder in "<program files (x86)>\Embarcadero\Studio\20.0"
          3. Overwrite "Lib" folder in "<program files (x86)>\Embarcadero\Studio\20.0"
          4. Start Rad Studio IDE;
    
