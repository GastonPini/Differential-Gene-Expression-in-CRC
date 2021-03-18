#!/usr/bin/perl

# archivo con IDs de sondas y valores de expresión de poblaciones tumorales
my $archivo = "tumorales_crudos.txt";
chomp $archivo;
unless (open (FILEIN, $archivo)){
	print "No se puede abrir el archivo $archivo\n\n";
	exit;
}
@lista_sondas = <FILEIN>;
close (FILEIN);
$clave; $cantidad_sondas = 0;
foreach my $linea (@lista_sondas){ 
	chomp($linea);
	$clave = $linea;
	$cantidad_sondas++;
} 

$muestras_tI = 2; $muestras_tII = 6; $muestras_tIII = 1; $muestras_tIV = 3;

# archivo con valores de expresión promedio de sondas
open(FILEH, ">medias_tumorales.txt");
for($i = 0; $i < $cantidad_sondas; ++$i){
	my @muestras = split("	",@lista_sondas[$i]);
	@id_sonda[$i] = @muestras[0];
	$valor[$i][0] = @muestras[1]; $valor[$i][1] = @muestras[2];
	$valor[$i][2] = @muestras[3]; $valor[$i][3] = @muestras[4];
	$valor[$i][4] = @muestras[5]; $valor[$i][5] = @muestras[6];
	$valor[$i][6] = @muestras[7]; $valor[$i][7] = @muestras[8];
	$valor[$i][8] = @muestras[9]; $valor[$i][9] = @muestras[10];
	$valor[$i][10] = @muestras[11]; $valor[$i][11] = @muestras[12];
	$valor[$i][12] = @muestras[13];
	
	##### Cálculo de promedios
	$promedio_tI[$i] = 0;
	for($j = 0; $j < $muestras_tI; ++$j){
		$promedio_tI[$i] = $promedio_tI[$i] + $valor[$i][$j];
	}
	$promedio_tI[$i] = $promedio_tI[$i]/$muestras_tI;

	$promedio_tII[$i] = 0;
	for($j = $muestras_tI; $j < $muestras_tI+$muestras_tII; ++$j){
		$promedio_tII[$i] = $promedio_tII[$i] + $valor[$i][$j];
	}
	$promedio_tII[$i] = $promedio_tII[$i]/$muestras_tII;
	
	$promedio_tIII[$i] = $valor[$i][$muestras_tI+$muestras_tII];

	$promedio_tIV[$i] = 0;
	for($j = $muestras_tI+$muestras_tII+$muestras_tIII; $j < $muestras_tI+$muestras_tII+$muestras_tIII+$muestras_tIV; ++$j){
		$promedio_tIV[$i] = $promedio_tIV[$i] + $valor[$i][$j];
	}
	$promedio_tIV[$i] = $promedio_tIV[$i]/$muestras_tIV;

	print FILEH "@id_sonda[$i]	$promedio_tI[$i]	$promedio_tII[$i]	$promedio_tIII[$i]	$promedio_tIV[$i]\n";
}
@lista_sondas = (); @id_sonda = (); @muestras = ();

print "\nCantidad de sondas: $cantidad_sondas\n";