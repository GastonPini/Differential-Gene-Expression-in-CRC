use List::MoreUtils qw(uniq);

# lista con resultados obtenidos de Reactome
@lista_archivos_result = ("result_N<Tx1,5.csv","result_N<Tx2.csv",
"result_N<Tx2,5.csv");

# lista de archivos con IDs de genes metabólicos
@lista_archivos_genes = ("genes_metabolicos_N<Tx1,5.txt","genes_metabolicos_N<Tx2.txt",
"genes_metabolicos_N<Tx2,5.txt");

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

	@lista_genes = ();
	my $archivo = @lista_archivos_genes[$x];
	chomp $archivo;
	unless (open (FILEIN, $archivo)){
		print "No se puede abrir el archivo $archivo\n\n";
		exit;
	}
	@lista_genes = <FILEIN>;
	close (FILEIN);
	$clave; $cantidad_genes = 0;
	foreach my $line (@lista_genes){ 
		chomp($line);
		$clave = $line;
		$cantidad_genes++;
	}

	if($x == 0){
		open(FILEH, ">vias_por_gen_N<Tx1,5.txt");
	}
	elsif($x == 1){
		open(FILEH, ">vias_por_gen_N<Tx2.txt");
	}
	else{
		open(FILEH, ">vias_por_gen_N<Tx2,5.txt");
	}



	$via = 0;
	for($i = 0; $i < $cantidad_genes; ++$i){
		
		print FILEH "$lista_genes[$i]	";
		
		for($j = 0; $j < $cantidad_result; $j++){
			my @result = split(',',@lista_result[$j]);
		
			if($result[14] =~ /$lista_genes[$i]/){
				$via++;
			}

		}
		print FILEH "$via\n";
		$via = 0;
	}	 

}