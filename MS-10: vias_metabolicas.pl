#!/usr/bin/perl
use List::MoreUtils qw(uniq);

# archivo con todas las relaciones entre vías metabólicas
my $archivo = "ReactomePathwaysRelation.txt";
chomp $archivo;
unless (open (FILEIN, $archivo)){
	print "No se puede abrir el archivo $archivo\n\n";
	exit;
}
@lista_relaciones = <FILEIN>;
close (FILEIN);
$clave; $cantidad_relaciones = 0;
foreach my $line (@lista_relaciones){ 
	chomp($line);
	$clave = $line;
	$cantidad_relaciones++;
}

for($i = 0; $i < $cantidad_relaciones; ++$i){ # separación de datos
	my @samples = split("	",@lista_relaciones[$i]);
	$duo[$i][0] = @samples[0];
	$duo[$i][1] = @samples[1];
}

##########################################################################

# lista con resultados obtenidos de Reactome
@lista_results = ("result_N<Tx1,5.csv","result_N<Tx2.csv","result_N<Tx2,5.csv","result_N>Tx1,5.csv");
$archivos = scalar @lista_results;

for($a = 0; $a < $archivos; $a++){
	
	my $archivo = $lista_results[$a];
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

#############################################################
	
	# detalles de vía "Metabolismo"
	@ids_metabolicos[0] = ("R-HSA-1430728");
	@nombres[0] = ("Metabolism");
	$padres = scalar @ids_metabolicos;

	for($i = 0; $i < $cantidad_vias; $i++){
		@valor = split(",",@lista_vias[$i]);
		if(@valor[1] =~ /"Metabolism"/){
			@pvalues[0] = @valor[7];
		}
	}

	$ids = 0;
	while($ids != $padres){
		$ids = $padres;
		for($i = 0; $i < $cantidad_vias; $i++){
			$aux = $padres;
			@valor = split(",",@lista_vias[$i]);

			for($j = 0; $j < $cantidad_relaciones; $j++){
				
				if($valor[0] =~ /$duo[$j][1]/){
					
					for($n = 0; $n < $padres; $n++){

						if($duo[$j][0] =~ /$ids_metabolicos[$n]/){
														
							if(!(grep $_ eq $valor[0], @ids_metabolicos)){
								print "$duo[$j][0]\t$valor[0]\t$valor[1]\t$valor[7]\n";
								push @ids_metabolicos, $valor[0];
								push @nombres, $valor[1];
								push @pvalues, $valor[7];
								$padres = scalar @ids_metabolicos;
								
							}
						}
					}
				}
			}
		}
		if($ids != $padres){
			print "\nCantidad de vias: $padres\n";
			print "\n";
		}
	}
	if(ids != $padres){
		if($a == 0){ # generación de archivos con datos procesados
			open(FILEH, ">vias_metabolicas_N<Tx1,5.txt");
		}
		elsif($a == 1){
			open(FILEH, ">vias_metabolicas_N<Tx2.txt");
		}
		elsif($a == 2){
			open(FILEH, ">vias_metabolicas_N<Tx2,5.txt");
		}
		else{
			open(FILEH, ">vias_metabolicas_N>Tx1,5.txt");
		}
		for($i = 0; $i < $padres; $i++){
			print FILEH "@ids_metabolicos[$i]\t@nombres[$i]\t@pvalues[$i]\n";
		}
	}

	@lista_vias = (); @ids_metabolicos = (); @nombres = (); @pvalues = ();
}