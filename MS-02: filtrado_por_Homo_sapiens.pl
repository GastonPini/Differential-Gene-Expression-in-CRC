#!/usr/bin/perl
use List::MoreUtils qw(uniq);

# Carga de información brindada por DAVID
my $archivo = "informacion_brindada_por_DAVID.txt";
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

# Separacioń de datos bridados por DAVID
for($i = 0; $i < $cantidad_sondas; ++$i){
	my @muestras = split("	",@lista_sondas[$i]);
	$sonda[$i][0] = @muestras[0]; $sonda[$i][1] = @muestras[1];
	$sonda[$i][2] = @muestras[2]; $sonda[$i][3] = @muestras[3];
	if($sonda[$i][2] =~ /Homo sapiens/){
		@id_sonda[$j] = $sonda[$i][0]; $j++;
	}
}
my @id_sonda = uniq(@id_sonda);
$cantidad_sondas = @id_sonda;
my @id_sonda = sort	@id_sonda;

# Escritura de archivo conteniendo los IDs de sondas correspondientes a Homo sapiens
open(FILEH, ">id_sondas_homo_sapiens.txt");
for($i = 0; $i < $cantidad_sondas; ++$i){
	print FILEH "@id_sonda[$i]\n";
}
@lista_sondas = (); @id_sonda = (); @muestras = ();

print "Cantidad de sondas pertenecientes a la especie Homo sapiens: $cantidad_sondas\n\n";