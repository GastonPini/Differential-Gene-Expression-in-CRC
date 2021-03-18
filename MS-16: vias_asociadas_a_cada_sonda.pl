use List::MoreUtils qw(uniq);

@lista_archivos_result = ("result_sondas_N<Tx1,5.csv","result_sondas_N<Tx2.csv", "result_sondas_N<Tx2,5.csv");

@lista_archivos_sondas = ("sondas_metabolicas_N<Tx1,5.txt","sondas_metabolicas_N<Tx2.txt",
"sondas_metabolicas_N<Tx2,5.txt");

$cantidad_archivos = scalar @lista_archivos_result; # cantidad de archivos a procesar
print "Cantidad de archivos a procesar: $cantidad_archivos.\n\n";

for($x = 0; $x < $cantidad_archivos; $x++){

	@lista_result = ();
	my $archivo = @lista_archivos_result[$x];
	chomp $archivo;
	unless (open (FILEIN, $archivo)){
		print "No se puede abrir el archivo $archivo\n\n";
		exit;
	}
	@lista_result = <FILEIN>;
	close (FILEIN);
	$clave; $cantidad_result = 0;
	foreach my $line (@lista_result){ 
		chomp($line);
		$clave = $line;
		$cantidad_result++;
	} 

	@lista_sondas = ();
	my $archivo = @lista_archivos_sondas[$x];
	chomp $archivo;
	unless (open (FILEIN, $archivo)){
		print "No se puede abrir el archivo $archivo\n\n";
		exit;
	}
	@lista_sondas = <FILEIN>;
	close (FILEIN);
	$clave; $cantidad_sondas = 0;
	foreach my $line (@lista_sondas){ 
		chomp($line);
		$clave = $line;
		$cantidad_sondas++;
	}

	if($x == 0){
		open(FILEH, ">vias_por_sonda_N<Tx1,5.txt");
	}
	elsif($x == 1){
		open(FILEH, ">vias_por_sonda_N<Tx2.txt");
	}
	else{
		open(FILEH, ">vias_por_sonda_N<Tx2,5.txt");
	}



	$via = 0;
	for($i = 0; $i < $cantidad_sondas; ++$i){
		
		print FILEH "$lista_sondas[$i]	";
		print "$lista_sondas[$i]\n";
		
		for($j = 0; $j < $cantidad_result; $j++){
			my @result = split(',',@lista_result[$j]);
		
			if($result[14] =~ /$lista_sondas[$i]/){

				print "$result[1]\n";
				$via++;

			}

		}
		print FILEH "$via\n";
		print "\n";
		$via = 0;
	}	 

}