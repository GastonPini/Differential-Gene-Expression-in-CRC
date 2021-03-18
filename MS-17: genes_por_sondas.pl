#!/usr/bin/perl
use List::MoreUtils qw(uniq);

##### Carga de archivos
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

@lista_archivos_sondas = ("sondas_metabolicas_N<Tx1,5.txt","sondas_metabolicas_N<Tx2.txt", 
"sondas_metabolicas_N<Tx2,5.txt");

$cantidad_archivos = scalar @lista_archivos_sondas; # cantidad de archivos a procesar
print "Cantidad de archivos a procesar: $cantidad_archivos.\n\n";

for($l = 0; $l < $cantidad_archivos; $l++){

	@genes_id = ();
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
	
	
	print "Cantidad de sondas: $cantidad_sondas.\n\n";

	if($l == 0){ # generación de archivos con datos procesados
		open(FILEG, ">genes_por_sondas_N<Tx1,5.txt");
	}
	elsif($l == 1){
		open(FILEG, ">genes_por_sondas_N<Tx2.txt");
	}
	elsif($l == 2){
		open(FILEG, ">genes_por_sondas_N<Tx2,5.txt");
	}
	else{
		open(FILEG, ">genes_por_sondas_N>Tx1,5.txt");
	}
	
	$contador_sondas = 0;
	
	for($k = 0; $k < $cantidad_relaciones; $k++){

		my @atributo = split("	",$lista_relaciones[$k]);

		for($j = 0; $j < $cantidad_sondas; ++$j){

			if($atributo[0] == $lista_sondas[$j]){
				push @genes_id, $atributo[1];
			}
			
		}
		
	}
	my @genes_id = uniq(@genes_id);
	$s = scalar @genes_id;
	for($i = 0; $i < $s; $i++){
		print FILEG "$genes_id[$i]\n";
	}
	
	@lista_sondas = (); @lista_genes = (); @atributo = ();
}