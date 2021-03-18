#!/usr/bin/perl

# lista de archivos con IDs de genes sobreexpresados
@lista_archivos_ids = ("id_genes_sobreexpresados_N<Tx1,5.txt","id_genes_sobreexpresados_N<Tx2.txt", 
"id_genes_sobreexpresados_N<Tx2,5.txt","id_genes_sobreexpresados_N>Tx1,5.txt");

# listas de archivos valores de expresión de genes
@lista_archivos_genes = ("valores_expresion_genes_sobreexpresados_N<Tx1,5.txt","valores_expresion_genes_sobreexpresados_N<Tx2.txt",
"valores_expresion_genes_sobreexpresados_N<Tx2,5.txt","valores_expresion_genes_sobreexpresados_N>Tx1,5.txt");

$cantidad_archivos = scalar @lista_archivos_genes; # cantidad de archivos a procesar
print "Cantidad de archivos a procesar: $cantidad_archivos.\n\n";

for(my $l = 0; $l < $cantidad_archivos; $l++){
	my $archivo = @lista_archivos_ids[$l];
	chomp $archivo;
	unless (open (FILEIN, $archivo)){
		print "No se puede abrir el archivo $archivo\n\n";
		exit;
	}
	@lista_genes = <FILEIN>;
	close (FILEIN);
	$clave1; $cantidad_genes = 0;
	foreach my $linea (@lista_genes){ 
		chomp($linea);
		$clave1 = $linea;
		$cantidad_genes++;
	}

	my $archivo = @lista_archivos_genes[$l];
	chomp $archivo;
	unless (open (FILEIN, $archivo)){
		print "No se puede abrir el archivo $archivo\n\n";
		exit;
	}
	@lista_valores = <FILEIN>;
	close (FILEIN);
	$clave2; $cantidad_filas = 0;
	foreach my $linea (@lista_valores){ 
		chomp($linea);
		$clave2 = $linea;
		$cantidad_filas++;
	}


	##### Spliting entre el ID de los genes y valores de expresión
	for($i = 0; $i < $cantidad_filas; ++$i){
		my @valor = split("	",$lista_valores[$i]);
		$dato[$i][0] = @valor[0]; $dato[$i][1] = @valor[1]; $dato[$i][2] = @valor[2]; $dato[$i][3] = @valor[3]; $dato[$i][4] = @valor[4];
		$dato[$i][5] = @valor[5]; $dato[$i][6] = @valor[6]; $dato[$i][7] = @valor[7]; $dato[$i][8] = @valor[8]; $dato[$i][9] = @valor[9];
		$dato[$i][10] = @valor[10]; $dato[$i][11] = @valor[11]; $dato[$i][12] = @valor[12]; $dato[$i][13] = @valor[13]; $dato[$i][14] = @valor[14];
	}


	##### Escritura de arcvhivo con ID de genes y valores de expresión
	$total_contadores = 0;
	
	if($l == 0){ # generación de archivos con datos procesados
		open(FILEH, ">valores_expresion_genes_sobreexpresados_promedio_N<Tx1,5.txt");
	}
	elsif($l == 1){
		open(FILEH, ">valores_expresion_genes_sobreexpresados_promedio_N<Tx2.txt");
	}
	elsif($l == 2){
		open(FILEH, ">valores_expresion_genes_sobreexpresados_promedio_N<Tx2,5.txt");
	}
	else{
		open(FILEH, ">valores_expresion_genes_sobreexpresados_promedio_N>Tx1,5.txt");
	}


	for($i = 0; $i < $cantidad_genes; $i++){
		
		$contador = 0;

		for($j = 0; $j < $cantidad_filas; $j++){
			
			if($dato[$j][0] == @lista_genes[$i]){
				$sum[$i][1] = $sum[$i][1] + $dato[$j][1]; $sum[$i][2] = $sum[$i][2] + $dato[$j][2]; $sum[$i][3] = $sum[$i][3] + $dato[$j][3]; $sum[$i][4] = $sum[$i][4] + $dato[$j][4];
				$sum[$i][5] = $sum[$i][5] + $dato[$j][5]; $sum[$i][6] = $sum[$i][6] + $dato[$j][6]; $sum[$i][7] = $sum[$i][7] + $dato[$j][7]; $sum[$i][8] = $sum[$i][8] + $dato[$j][8];
				$sum[$i][9] = $sum[$i][9] + $dato[$j][9]; $sum[$i][10] = $sum[$i][10] + $dato[$j][10]; $sum[$i][11] = $sum[$i][11] + $dato[$j][11]; $sum[$i][12] = $sum[$i][12] + $dato[$j][12];
				$sum[$i][13] = $sum[$i][13] + $dato[$j][13]; $sum[$i][14] = $sum[$i][14] + $dato[$j][14];
				$contador++;
			}

		}

		##### Escritura de ID de genes y valores de expresión promedios
		$sum[$i][1] = sprintf("%.3f", $sum[$i][1] / $contador); $sum[$i][2] = sprintf("%.3f", $sum[$i][2] / $contador); $sum[$i][3] = sprintf("%.3f", $sum[$i][3]  / $contador); $sum[$i][4] = sprintf("%.3f", $sum[$i][4] / $contador);
		$sum[$i][5] = sprintf("%.3f", $sum[$i][5] / $contador); $sum[$i][6] = sprintf("%.3f", $sum[$i][6] / $contador); $sum[$i][7] = sprintf("%.3f", $sum[$i][7]  / $contador); $sum[$i][8] = sprintf("%.3f", $sum[$i][8] / $contador);
		$sum[$i][9] = sprintf("%.3f", $sum[$i][9] / $contador); $sum[$i][10] = sprintf("%.3f", $sum[$i][10] / $contador); $sum[$i][11] = sprintf("%.3f", $sum[$i][11]  / $contador); $sum[$i][12] = sprintf("%.3f", $sum[$i][12] / $contador);
		$sum[$i][13] = sprintf("%.3f", $sum[$i][13] / $contador); $sum[$i][14] = sprintf("%.3f", $sum[$i][14] / $contador);
		
		print FILEH "@lista_genes[$i]	$sum[$i][1]	$sum[$i][2]	$sum[$i][3]	$sum[$i][4]	$sum[$i][5]	$sum[$i][6]	$sum[$i][7]	$sum[$i][8]	$sum[$i][9]	$sum[$i][10]	$sum[$i][11]	$sum[$i][12]	$sum[$i][13]	$sum[$i][14]\n";

		$total_contadores = $total_contadores + $contador;

	}
	@lista_valores = (); @dato = (); @sum = ();

}