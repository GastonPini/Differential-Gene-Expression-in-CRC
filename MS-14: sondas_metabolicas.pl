use List::MoreUtils qw(uniq);

# lista de archivos con IDs de sondas correspondientes a cada gen metabólico
@lista_archivos_sondas = ("sondas_por_gen_N<Tx1,5.txt","sondas_por_gen_N<Tx2.txt",
"sondas_por_gen_N<Tx2,5.txt","sondas_por_gen_N>Tx1,5.txt");

# lista de archivos con IDs de genes metabólicos
@lista_archivos_genes = ("genes_asociados_N<Tx1,5.txt","genes_asociados_N<Tx2.txt",
"genes_asociados_N<Tx2,5.txt","genes_asociados_N>Tx1,5.txt");

$cantidad_archivos = scalar @lista_archivos_sondas; # cantidad de archivos a procesar
print "Cantidad de archivos a procesar: $cantidad_archivos.\n\n";

for($x = 0; $x < $cantidad_archivos; $x++){

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
	

	if($x == 0){ # generación de archivos con datos procesados
		open(FILEH, ">sondas_metabolicas_N<Tx1,5.txt");
	}
	elsif($x == 1){
		open(FILEH, ">sondas_metabolicas_N<Tx2.txt");
	}
	elsif($x == 2){
		open(FILEH, ">sondas_metabolicas_N<Tx2,5.txt");
	}
	else{
		open(FILEH, ">sondas_metabolicas_N>Tx1,5.txt");
	}


	@genes = (); @genes_asociados = (); @genes_id = ();
	$sondas_metabolicas = 0;

	for($i = 0; $i < $cantidad_genes; ++$i){ # separación de datos
#		my @gen = split(',',@lista_genes[$i]);
		
		for($j = 0; $j < $cantidad_sondas; $j++){
		
			my @sonda = split('	',@lista_sondas[$j]);
			
			if($sonda[0] =~ /$lista_genes[$i]/){
				
				print FILEH "$sonda[0]	@sonda[1]	@sonda[2]\n";
				$sondas_metabolicas += @sonda[2];
			}
		}
		
	
	}
	print "Cantidad de sondas asociadas a metabolismo: $sondas_metabolicas\n";
	print FILEH "\nCantidad de sondas asociadas a metabolismo: $sondas_metabolicas";
	@lista_sondas = (); @lista_genes = ();
	
}