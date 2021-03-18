#!/usr/bin/perl

# Carga de archivo con IDs de sondas
my $archivo = "sanos_crudos.txt";
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

# Escritura de archivo conteniendo IDs de sondas con SE menor al 20%
$muestras_por_sonda = 10;
$SE_menor_20 = 0;
open(FILEF, ">id_sondas_menores_a_20.txt");
for($i = 0; $i < $cantidad_sondas; ++$i){
	my @muestras = split("	",@lista_sondas[$i]);
	@id_sonda[$i] = @muestras[0];
	$valor[$i][0] = @muestras[1]; $valor[$i][1] = @muestras[2];
	$valor[$i][2] = @muestras[3]; $valor[$i][3] = @muestras[4];
	$valor[$i][4] = @muestras[5]; $valor[$i][5] = @muestras[6];
	$valor[$i][6] = @muestras[7]; $valor[$i][7] = @muestras[8];
	$valor[$i][8] = @muestras[9]; $valor[$i][9] = @muestras[10];
	
	# Cálculo de promedios
	$promedio[$i] = 0;
	for($j = 0; $j < $muestras_por_sonda; ++$j){
		$promedio[$i] = $promedio[$i] + $valor[$i][$j];
	}
	$promedio[$i] = $promedio[$i]/$muestras_por_sonda;
	
	# Cálculo de desviaciones estándar (SD)
	$SD[$i] = 0;
	for($j = 0; $j < $muestras_por_sonda; ++$j){
		$termino = (($valor[$i][$j]-$promedio[$i])**2)/($muestras_por_sonda-1);
		$SD[$i] = $SD[$i] + $termino;
	}
	$SD[$i] = sqrt($SD[$i]);
	$SE[$i] = $SD[$i]/sqrt($muestras_por_sonda-1);
	$SE100[$i] = $SE[$i] * 100; ##### Cálculo de error estándar (SE)

	if($SE100[$i] <= 20){
		$SE_menor_20++;
		print FILEF "@id_sonda[$i]\n";
	}
}
@lista_sondas = (); @id_sonda = (); @muestras = ();

print "\nCantidad de sondas: $cantidad_sondas\n";
print "\nCantidad de sondas SE menor a 20%: $SE_menor_20\n";