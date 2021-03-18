use List::MoreUtils qw(uniq);

# lista de archivos donde se encuentra la información de vías sobreactivadas
@lista_archivos_result = ("result_N<Tx1,5.csv","result_N<Tx2.csv",
"result_N<Tx2,5.csv","result_N>Tx1,5.csv");

# listas de vías asociadas a metabolismo
@lista_archivos_vias = ("vias_metabolicas_N<Tx1,5.txt","vias_metabolicas_N<Tx2.txt",
"vias_metabolicas_N<Tx2,5.txt","vias_metabolicas_N>Tx1,5.txt");

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

	@lista_vias = ();
	my $archivo = @lista_archivos_vias[$x];
	chomp $archivo;
	unless (open (FILEIN, $archivo)){
		print "No se puede abrir el archivo $archivo\n\n";
		exit;
	}
	@lista_vias = <FILEIN>;
	close (FILEIN);
	$clave; $cantidad_vias = 0;
	foreach my $line (@lista_vias){ 
		chomp($line);
		$clave = $line;
		$cantidad_vias++;
	}
	
	@genes = (); @genes_asociados = (); @genes_id = ();
	$k = 0;

	for($i = 0; $i < $cantidad_result; ++$i){
		my @result = split(',',@lista_result[$i]);
		
		for($j = 0; $j < $cantidad_vias; $j++){
		
			my @via = split('	',@lista_vias[$j]);
			if($via[0] =~ /$result[0]/){
				$genes_asociados[$k] = @result[14];

				my @genes_id = split(";",$genes_asociados[$k]);
				$cantidad_ids = scalar @genes_id;
				for($l = 0; $l < $cantidad_ids; ++$l){
					if($l == 0){
						@genes_id[$l] = substr(@genes_id[$l], 1);
					}
					if($l == $cantidad_ids-1){
						chop(@genes_id[$l]);
					}
					
					push @genes, @genes_id[$l];

					if($cantidad_ids > 1 && $l < $cantidad_ids-1){
					}
				}
				$k++;

			}
		
		}
	
	}

	if($x == 0){ # generación de archivos con datos procesados
		open(FILEH, ">genes_asociados_N<Tx1,5.txt");
	}
	elsif($x == 1){
		open(FILEH, ">genes_asociados_N<Tx2.txt");
	}
	elsif($x == 2){
		open(FILEH, ">genes_asociados_N<Tx2,5.txt");
	}
	else{
		open(FILEH, ">genes_asociados_N>Tx1,5.txt");
	}
	my @genes = uniq(@genes);
	$g = scalar @genes;
	for($i = 0; $i < $g; $i++){
		print FILEH "$genes[$i]\n";
	}

}