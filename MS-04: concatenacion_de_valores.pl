#!/usr/bin/perl

# archivo con los IDs de sondas correspondientes a Homo sapiens
my $archivo = "id_sondas_homo_sapiens.txt";
chomp $archivo;
unless (open (FILEIN, $archivo)){
	print "No se puede abrir el archivo $archivo\n\n";
	exit;
}
@probe_id = <FILEIN>;
close (FILEIN);
$clave; $cantidad_ids = 0;
foreach my $linea (@probe_id){ 
	chomp($linea);
	$clave = $linea;
	$cantidad_ids++;
}

# archivo conteniendo los valores de expresión
my $archivo = "sanos_crudos.txt";
chomp $archivo;
unless (open (FILEIN, $archivo)){
	print "No se puede abrir el archivo $archivo\n\n";
	exit;
}
@lista_sanos = <FILEIN>;
close (FILEIN);
$indice1; $cantidad_sanos = 0;
foreach my $linea (@lista_sanos){ 
	chomp($linea);
	$indice1 = $linea;
	$cantidad_sanos++;
}

my $archivo = "medias_tumorales.txt";
chomp $archivo;
unless (open (FILEIN, $archivo)){
	print "No se puede abrir el archivo $archivo\n\n";
	exit;
}
@lista_tumorales = <FILEIN>;
close (FILEIN);
$indice2; $cantidad_tumorales = 0;
foreach my $linea (@lista_tumorales){ 
	chomp($linea);
	$indice2 = $linea;
	$cantidad_tumorales++;
}
print "archivos leidos\n\n";

# separación entre los IDs de la sondas y los valores de expresión
for($j = 0; $j < $cantidad_sanos; ++$j){
	my @atributo = split("	",@lista_sanos[$j]);
	$sano[$j][0] = @atributo[0]; $sano[$j][1] = @atributo[1];
	$sano[$j][2] = @atributo[2]; $sano[$j][3] = @atributo[3];
	$sano[$j][4] = @atributo[4]; $sano[$j][5] = @atributo[5];
	$sano[$j][6] = @atributo[6]; $sano[$j][7] = @atributo[7];
	$sano[$j][8] = @atributo[8]; $sano[$j][9] = @atributo[9];
	$sano[$j][10] = @atributo[10];
}
@atributo = ();
for($j = 0; $j < $cantidad_tumorales; ++$j){
	my @atributo = split("	",@lista_tumorales[$j]);
	$tumoral[$j][0] = @atributo[0]; $tumoral[$j][1] = @atributo[1];
	$tumoral[$j][2] = @atributo[2]; $tumoral[$j][3] = @atributo[3];
	$tumoral[$j][4] = @atributo[4];
}
@atributo = ();

$contador_sanos = 0; $contador_tumorales = 0;
open(FILEH, ">valores_sanos.txt");
open(FILEI, ">valores_tumorales.txt");
for($i = 0; $i < $cantidad_ids; ++$i){

	for($j = 0; $j < $cantidad_sanos; ++$j){
		if ($probe_id[$i] == $sano[$j][0]){
			print FILEH "$sano[$j][0]	$sano[$j][1]	$sano[$j][2]	$sano[$j][3]	$sano[$j][4]	$sano[$j][5]	$sano[$j][6]	$sano[$j][7]	$sano[$j][8]	$sano[$j][9]	$sano[$j][10]\n";
			$contador_sanos++;
			last;
		}
	}


	for($j = 0; $j < $cantidad_tumorales; ++$j){
		if ($probe_id[$i] == $tumoral[$j][0]){
			print FILEI "$tumoral[$j][0]	$tumoral[$j][1]	$tumoral[$j][2]	$tumoral[$j][3]	$tumoral[$j][4]\n";
			$contador_tumorales++;
			last;
		}
	}

}


my $archivo = "valores_sanos.txt"; # archivo con valores de expresioes ya procesados
chomp $archivo;
unless (open (FILEIN, $archivo)){
	print "No se puede abrir el archivo $archivo\n\n";
	exit;
}
@lista_sanos = <FILEIN>;
close (FILEIN);
$indice1; $cantidad_sanos = 0;
foreach my $linea (@lista_sanos){ 
	chomp($linea);
	$indice1 = $linea;
	$cantidad_sanos++;
}

my $archivo = "valores_tumorales.txt";
chomp $archivo;
unless (open (FILEIN, $archivo)){
	print "No se puede abrir el archivo $archivo\n\n";
	exit;
}
@lista_tumorales = <FILEIN>;
close (FILEIN);
$indice2; $cantidad_tumorales = 0;
foreach my $linea (@lista_tumorales){ 
	chomp($linea);
	$indice2 = $linea;
	$cantidad_tumorales++;
}

for($j = 0; $j < $cantidad_sanos; ++$j){ # separación de valores de expresión de sanos
	my @atributo = split("	",@lista_sanos[$j]);
	$sano[$j][0] = @atributo[0]; $sano[$j][1] = @atributo[1];
	$sano[$j][2] = @atributo[2]; $sano[$j][3] = @atributo[3];
	$sano[$j][4] = @atributo[4]; $sano[$j][5] = @atributo[5];
	$sano[$j][6] = @atributo[6]; $sano[$j][7] = @atributo[7];
	$sano[$j][8] = @atributo[8]; $sano[$j][9] = @atributo[9];
	$sano[$j][10] = @atributo[10];
}
@atributo = ();

for($j = 0; $j < $cantidad_tumorales; ++$j){ # separación de valores de expresión de tumorales
	my @atributo = split("	",@lista_tumorales[$j]);
	$tumoral[$j][0] = @atributo[0]; $tumoral[$j][1] = @atributo[1];
	$tumoral[$j][2] = @atributo[2]; $tumoral[$j][3] = @atributo[3];
	$tumoral[$j][4] = @atributo[4];
}
@atributo = ();

$contador_sondas = 0;
open(FILEH, ">valores_expresion_sondas.txt"); # escritura de archivo con los IDs de sondas y valores de expresión
for($i = 0; $i < $cantidad_sanos; ++$i){
	for($j = 0; $j < $cantidad_tumorales; ++$j){

		if ($sano[$i][0] =~ /$tumoral[$j][0]/g){
							
			print FILEH "$sano[$i][0]	$sano[$i][1]	$sano[$i][2]	$sano[$i][3]	$sano[$i][4]	$sano[$i][5]	$sano[$i][6]	$sano[$i][7]	$sano[$i][8]	$sano[$i][9]	$sano[$i][10]	$tumoral[$j][1]	$tumoral[$j][2]	$tumoral[$j][3]	$tumoral[$j][4]\n";
			$contador_sondas++;
			last;

		}
	}
}