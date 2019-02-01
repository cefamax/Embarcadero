TRESTRequest
Problema invio file in post in multipart formdata

PROBLEMA:	Il problema riguarda l'invio di parametri con il content-type=multipart/formdata.
		   	Se si inviano solo parametri stringa il body è del tipo:
		   	par1=valore1&par2=valore2....
		   	Se si inviano parametri di tipo file oppure file e stringa contemporaneamente il body diventa del tipo
			-----------Embt-Boundary--6AB1E718516A677C
			Content-Disposition: form-data; name="fileupd"; filename="cafcenterAPItest.txt"
			Content-Type: application/octet-stream			

			<file content>

			---------Embt-Boundary--6AB1E718516A677C
			Content-Disposition: form-data; name="uiddwn"
			Content-Type: text/plain
			Content-Transfer-Encoding: quoted-printable

			<string content>
			---------Embt-Boundary--6AB1E718516A677C--
			Il problema come si può notare è che la stringa di bondary che suddivide ogni parametro non sono uguali, 
			nella prima sono presenti 2 caratteri "-" in più; il server in questo caso riesce a leggere solo il primo parametro e non gli altri.


SOLUZIONE:	file  System.Net.Mime
			funzione: TMultipartFormData.AdjustLastBoundary;
			modificare 
			FStream.Position := FStream.Size - (Length(FBoundary) + 4);
			in
			FStream.Position := FStream.Size - (Length(FBoundary) + 6);
			in questo modo tutte le stringhe bondary sono uguali ed il server carica tutti i parametri.


AGGIORNAMENTO: 
			1. chiudere l'IDE; 
			2. eseguire un backup delle cartelle "Lib" e "Bin" in "<prog files>\Embarcadero\Studio\20.0"
			3. sovrascrivere le cartelle "Lib" e "Bin" in "<prog files>\Embarcadero\Studio\20.0"
			4. avviare l'IDE

Author:
Massimo Petrolati
