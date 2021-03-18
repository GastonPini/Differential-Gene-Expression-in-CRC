#!/usr/bin/perl

# archivo con IDs de sondas y sus correspondientes genes
my $archivo = "id-id.txt";
chomp $archivo;
unless (open (FILEIN, $archivo)){
	print "No se puede abrir el archivo $archivo\n\n";
	exit;
}
@lista_pares = <FILEIN>;
close (FILEIN);
$clave; $cantidad_pares = 0;
foreach my $linea (@lista_pares){ 
	chomp($linea);
	$clave = $linea;
	$cantidad_pares++;
}


# lista con nombres de archivos a procesar
@lista_archivos = ("sondas_sobreexpresadas_N<Tx1,5.txt","sondas_sobreexpresadas_N<Tx2.txt",
"sondas_sobreexpresadas_N<Tx2,5.txt","sondas_sobreexpresadas_N>Tx1,5.txt");

$cantidad_archivos = scalar @lista_archivos; # cantidad de archivos a procesar
print "Cantidad de archivos a procesar: $cantidad_archivos.\n\n";

for(my $l = 0; $l < $cantidad_archivos; $l++){

	my $archivo = @lista_archivos[$l];
	chomp $archivo;
	unless (open (FILEIN, $archivo)){
		print "No se puede abrir el archivo $archivo\n\n";
	exit;
	}
	@lista_sondas = <FILEIN>;
	close (FILEIN);
	$indice1; $cantidad_sondas = 0;
	foreach my $linea (@lista_sondas){ 
		chomp($linea);
		$indice1 = $linea;
		$cantidad_sondas++;
	}
	
	
	if($l == 0){ # generación de archivos con datos procesados
		open(FILEG, ">valores_expresion_genes_sobreexpresados_N<Tx1,5.txt");
	}
	elsif($l == 1){
		open(FILEG, ">valores_expresion_genes_sobreexpresados_N<Tx2.txt");
	}
	elsif($l == 2){
		open(FILEG, ">valores_expresion_genes_sobreexpresados_N<Tx2,5.txt");
	}
	else{
		open(FILEG, ">valores_expresion_genes_sobreexpresados_N>Tx1,5.txt");
	}
	
	
	$contador_sondas = 0;
	for($i = 0; $i < $cantidad_pares; ++$i){
		my @atributo1 = split("	",@lista_pares[$i]);

		for($j = 0; $j < $cantidad_sondas; ++$j){
			my @atributo2 = split("	",@lista_sondas[$j]);
			if (@atributo1[0] == @atributo2[0]){
				print FILEG "@atributo1[1]	@atributo2[1]	@atributo2[2]	@atributo2[3]	@atributo2[4]	@atributo2[5]	@atributo2[6]	@atributo2[7]	@atributo2[8]	@atributo2[9]	@atributo2[10]	@atributo2[11]	@atributo2[12]	@atributo2[13]	@atributo2[14]\n";
				$contador_sondas++;
				last;
			}
		}

	}
	
	print "Cantidad de sondas concatenadas: $contador_sondas.\n\n";
	@lista_sondas = (); @atributo1 = (); @atributo2 = ();
}