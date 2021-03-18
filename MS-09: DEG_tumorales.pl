#!/usr/bin/perl
use List::Util qw(min);
use List::Util qw(max);

my $archivo = "funciones_genes_sobreexpresados.txt";
chomp $archivo;
unless (open (FILEIN, $archivo)){
	print "No se puede abrir el archivo $archivo\n\n";
exit;
}
@lista_funciones = <FILEIN>;
close (FILEIN);
$indice1; $cantidad_funciones = 0;
foreach my $linea (@lista_funciones){ 
	chomp($linea);
	$indice1 = $linea;
	$cantidad_funciones++;
}
print "$cantidad_funciones\n";

# lista de archivos con IDs y valores de expresión de genes tumorales
@lista_archivos = ("valores_expresion_genes_sobreexpresados_promedio_N<Tx1,5.txt",
"valores_expresion_genes_sobreexpresados_promedio_N<Tx2.txt",
"valores_expresion_genes_sobreexpresados_promedio_N<Tx2,5.txt");

$cantidad_archivos = scalar @lista_archivos;
print "Cantidad de archivos a procesar: $cantidad_archivos.\n\n";

$cantidad_estadios = 4;

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
	
	for($j = 0; $j < $cantidad_genes; ++$j){

		my @atributo = split("	",@lista_genes[$j]);
		@valores = (@atributo[11], @atributo[12], @atributo[13], @atributo[14]);
		$minimo[$j] = min(@valores);
		$maximo[$j] = max(@valores);

		for($k = 0; $k < $cantidad_estadios; $k++){
			
			if($valores[$k] =~ /$maximo[$j]/){
				

				for($m = 0; $m < $cantidad_funciones; $m++){
					@funcion = split("	",$lista_funciones[$m]);
					
					if($funcion[0] =~ /$atributo[0]/){
						$p = rindex("$funcion[1]","(");
						$funcion[1] = substr("$funcion[1]", $p+1);
						chop($funcion[1]);
					
						if($k == 0){
							push @nivel1, $funcion[1];
						}
						elsif($k == 1){
							push @nivel2, $funcion[1];
						}
						elsif($k == 2){
							push @nivel3, $funcion[1];
						}
						else{
							push @nivel4, $funcion[1];
						}
					
					}
				
				}			
				
			}

		}

	}


	if($l == 0){ # generación de archivos con datos procesados
		open(FILEG, ">DEG_tumorales_N<Tx1,5.txt");
	}
	elsif($l == 1){
		open(FILEG, ">DEG_tumorales_N<Tx2.txt");
	}
	else{
		open(FILEG, ">DEG_tumorales_N<Tx2,5.txt");
	}

	$cantidad_1 = scalar @nivel1;
	$cantidad_2 = scalar @nivel2;
	$cantidad_3 = scalar @nivel3;
	$cantidad_4 = scalar @nivel4;

	print FILEG "Estadio tumoral 1:\n";
	for($k = 0; $k < $cantidad_1; $k++){
		print FILEG "$nivel1[$k]\n";
	}
	print FILEG "Estadio tumoral 2:\n";
	for($k = 0; $k < $cantidad_2; $k++){
		print FILEG "$nivel2[$k]\n";
	}
	print FILEG "Estadio tumoral 3:\n";
	for($k = 0; $k < $cantidad_3; $k++){
		print FILEG "$nivel3[$k]\n";
	}
	print FILEG "Estadio tumoral 4:\n";
	for($k = 0; $k < $cantidad_4; $k++){
		print FILEG "$nivel4[$k]\n";
	}
		
	print "Genes representativos de estadio 1: $cantidad_1;\nGenes representativos de estadio 2: $cantidad_2;\nGenes representativos de estadio 3: $cantidad_3;\nGenes representativos de estadio 4: $cantidad_4\n\n";	

	if($l == 0){
		open(FILEH, ">valores_DEG_N<Tx1,5.txt");
	}
	elsif($l == 1){
		open(FILEH, ">valores_DEG_N<Tx2.txt");
	}
	else{
		open(FILEH, ">valores_DEG_N<Tx2,5.txt");
	}

	for($j = 0; $j < $cantidad_genes; ++$j){
		my @atributo = split("	",@lista_genes[$j]);
		print FILEH "@atributo[0]	@atributo[11]	@atributo[12]	@atributo[13]	@atributo[14]\n";
	}

	@lista_sondas = (); @atributo = (); @nivel1 = (); @nivel2 = (); @nivel3 = (); @nivel4 = ();
}