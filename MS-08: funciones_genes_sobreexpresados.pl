#!/usr/bin/perl

# Carga de archivo con funciones caracterizadas por DAVID
my $archivo = "funciones_genes_DAVID.txt";
chomp $archivo;
unless (open (FILEIN, $archivo)){
	print "No se puede abrir el archivo $archivo\n\n";
	exit;
}
@lista_funciones = <FILEIN>;
close (FILEIN);
$clave; $cantidad_funciones = 0;
foreach my $linea (@lista_funciones){ 
	chomp($linea);
	$clave = $linea;
	$cantidad_funciones++;
}


# lista con nombres de archivos a procesar
@lista_archivos = ("valores_expresion_genes_sobreexpresados_N<Tx1,5.txt","valores_expresion_genes_sobreexpresados_N<Tx2.txt",
"valores_expresion_genes_sobreexpresados_N<Tx2,5.txt","valores_expresion_genes_sobreexpresados_N>Tx1,5.txt");

$cantidad_archivos = scalar @lista_archivos; # cantidad de archivos a procesar
print "Cantidad de archivos a procesar: $cantidad_archivos.\n\n";

for(my $l = 0; $l < $cantidad_archivos; $l++){
	my $archivo = @lista_archivos[$l];
	chomp $archivo;
	unless (open (FILEIN, $archivo)){
		print "No se puede abrir el archivo $archivo\n\n";
		exit;
	}
	@lista_genes = <FILEIN>;
	close (FILEIN);
	$indice1; $cantidad_genes = 0;
	foreach my $linea (@lista_genes){ 
		chomp($linea);
		$indice1 = $linea;
		$cantidad_genes++;
	}

	if($l == 0){ # generación de archivos con datos procesados
		open(FILEH, ">funciones_genes_sobreexpresados_N<Tx1,5.txt");
		open(FILEI, ">id_genes_sobreexpresados_N<Tx1,5.txt");
	}
	elsif($l == 1){
		open(FILEH, ">funciones_genes_sobreexpresados_N<Tx2.txt");
		open(FILEI, ">id_genes_sobreexpresados_N<Tx2.txt");
	}
	elsif($l == 2){
		open(FILEH, ">funciones_genes_sobreexpresados_N<Tx2,5.txt");
		open(FILEI, ">id_genes_sobreexpresados_N<Tx2,5.txt");
	}
	else{
		open(FILEH, ">funciones_genes_sobreexpresados_N>Tx1,5.txt");
		open(FILEI, ">id_genes_sobreexpresados_N>Tx1,5.txt");
	}
	
	$genes_por_folding = 0;
	for($i = 0; $i < $cantidad_funciones; ++$i){
		my @atributo1 = split("	",@lista_funciones[$i]);

		for($j = 0; $j < $cantidad_genes; ++$j){
			my @atributo2 = split("	",@lista_genes[$j]);
			if (@atributo1[0] == @atributo2[0]){
				print FILEH "@atributo1[0]	@atributo1[1]\n";
				print FILEI "@atributo1[0]\n";
				$genes_por_folding++;
				last;
			}
		}

	}
	@lista_genes = (); @atributo1 = (); @atributo2 = ();
	print "Cantidad de genes: $genes_por_folding.\n\n";

}