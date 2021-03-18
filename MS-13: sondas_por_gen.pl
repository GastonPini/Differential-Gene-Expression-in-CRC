#!/usr/bin/perl

# archivo con IDs de sondas y sus correspondientes genes
my $archivo = "id-id.txt";
chomp $archivo;
unless (open (FILEIN, $archivo)){
	print "No se puede abrir el archivo $archivo\n\n";
	exit;
}
@lista_relaciones = <FILEIN>;
close (FILEIN);
$clave1; $cantidad_relaciones = 0;
foreach my $linea1 (@lista_relaciones){ 
	chomp($linea1);
	$clave1 = $linea1;
	$cantidad_relaciones++;
}

# lista de archivos con IDs de genes sobreexpresados
@lista_archivos_genes = ("id_genes_sobreexpresados_N<Tx1,5.txt","id_genes_sobreexpresados_N<Tx2.txt", 
"id_genes_sobreexpresados_N<Tx2,5.txt","id_genes_sobreexpresados_N>Tx1,5.txt");

# lista de archivos con IDs de sondas sobreexpresadas
@lista_archivos_sondas = ("id_sondas_sobreexpresadas_N<Tx1,5.txt","id_sondas_sobreexpresadas_N<Tx2.txt", 
"id_sondas_sobreexpresadas_N<Tx2,5.txt","id_sondas_sobreexpresadas_N>Tx1,5.txt");

$cantidad_archivos = scalar @lista_archivos_genes; # cantidad de archivos a procesar
print "Cantidad de archivos a procesar: $cantidad_archivos.\n\n";

for($l = 0; $l < $cantidad_archivos; $l++){
	my $archivo = @lista_archivos_sondas[$l];
	chomp $archivo;
	unless (open (FILEIN, $archivo)){
		print "No se puede abrir el archivo $archivo\n\n";
	exit;
	}
	@lista_sondas = <FILEIN>;
	close (FILEIN);
	$indice2; $cantidad_sondas = 0;
	foreach my $linea2 (@lista_sondas){ 
		chomp($linea2);
		$indice2 = $linea2;
		$cantidad_sondas++;
	}
	
	my $archivo = @lista_archivos_genes[$l];
	chomp $archivo;
	unless (open (FILEIN, $archivo)){
		print "No se puede abrir el archivo $archivo\n\n";
	exit;
	}
	@lista_genes = <FILEIN>;
	close (FILEIN);
	$indice3; $cantidad_genes = 0;
	foreach my $linea3 (@lista_genes){ 
		chomp($linea3);
		$indice3 = $linea3;
		$cantidad_genes++;
	}

	print "Cantidad de sondas: $cantidad_sondas.\nCantidad de genes: $cantidad_genes\n\n";

	if($l == 0){ # generación de archivos con datos procesados
		open(FILEG, ">sondas_por_gen_N<Tx1,5.txt");
	}
	elsif($l == 1){
		open(FILEG, ">sondas_por_gen_N<Tx2.txt");
	}
	elsif($l == 2){
		open(FILEG, ">sondas_por_gen_N<Tx2,5.txt");
	}
	else{
		open(FILEG, ">sondas_por_gen_N>Tx1,5.txt");
	}
	
	$contador_sondas = 0;
	for($i = 0; $i < $cantidad_genes; ++$i){
		$sondas_por_gen = 0;
		print FILEG "@lista_genes[$i]	";
		for($k = 0; $k < $cantidad_relaciones; $k++){

			my @atributo = split("	",$lista_relaciones[$k]);

			for($j = 0; $j < $cantidad_sondas; ++$j){

				if($atributo[1] == $lista_genes[$i] && $atributo[0] == $lista_sondas[$j]){
					if($sondas_por_gen == 0){
						print FILEG "$lista_sondas[$j]";
					}
					else{
						print FILEG ",$lista_sondas[$j]";
					}
					$contador_sondas++;
					$sondas_por_gen++;
					last;
				}
			
			}
		
		}
		print FILEG "	$sondas_por_gen\n";
	}

	@lista_sondas = (); @lista_genes = (); @atributo = ();
}