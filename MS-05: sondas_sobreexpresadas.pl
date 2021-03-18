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

# lista con sondas sobreexpresadas
@lista_archivos = ("MeV_N<Tx1,5.txt","MeV_N<Tx2.txt","MeV_N<Tx2,5.txt","MeV_N>Tx1,5.txt");

$cantidad_archivos = scalar @lista_archivos; # cantidad de archivos a procesar
print "Cantidad de archivos a procesar: $cantidad_archivos\n\n";


for(my $l = 0; $l < $cantidad_archivos; $l++){
	my $archivo = @lista_archivos[$l];
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

	if($l == 0){ # generación de archivos con datos procesados
		open(FILEG, ">sondas_sobreexpresadas_N<Tx1,5.txt");
		open(FILEH, ">#id_sondas_sobreexpresadas_N<Tx1,5.txt");
	}
	elsif($l == 1){
		open(FILEG, ">sondas_sobreexpresadas_N<Tx2.txt");
		open(FILEH, ">#id_sondas_sobreexpresadas_N<Tx2.txt");
	}
	elsif($l == 2){
		open(FILEG, ">sondas_sobreexpresadas_N<Tx2,5.txt");
		open(FILEH, ">#id_sondas_sobreexpresadas_N<Tx2,5.txt");
	}
	else{
		open(FILEG, ">sondas_sobreexpresadas_N>Tx1,5.txt");
		open(FILEH, ">#id_sondas_sobreexpresadas_N>Tx1,5.txt");
	}
	
	for($j = 0; $j < $cantidad_sondas; ++$j){
		my @atributo = split("	",@lista_sondas[$j]);
		print FILEG "@atributo[1]	@atributo[4]	@atributo[5]	@atributo[6]	@atributo[7]	@atributo[8]	@atributo[9]	@atributo[10]	@atributo[11]	@atributo[12]	@atributo[13]	@atributo[14]	@atributo[15]	@atributo[16]	@atributo[17]\n";
		print FILEH "@atributo[1]\n";
	}

	print "Cantidad de sondas sobreexpresadas: $cantidad_sondas.\n\n";
	@lista_sondas = (); @atributo = ();
}