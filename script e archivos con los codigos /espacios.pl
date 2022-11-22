#!/usr/local/bin/perl
################## abre la lista 

open(UNO,"10bitsneg.txt") || die "No fue posible abrir 10bitsneg.txt\n";
open(DOS,"10bitspos.txt") || die "No fue posible abrir 10bitspos.txt\n";
#open(DOS,"todo.txt") || die "error en el archivo del smi" 
#hasta aqui funca todo bien
while($texto = <UNO>){
    chop($texto);
    @hola = split(",",$texto);
}
while($texto2 = <DOS>){
    chop($texto2);
    @hola2 = split(",",$texto2);
}

#ya sabemos que tenemos convertido en  array el texto
#hacemos un loop

#debo convertir a strings la cadena
#funciona este print
#este ciclo hace los numeros negativos de 10 bits
print"imprimimos numeros de de 10 bits negativos\n";
for ( $i=0; $i <= 536;$i = $i +2) {
   print "@hola[$i+2]@hola[$i+3]\n";   
}#aqui cierra este ciclo
print"terminamos de imprimir numeros de de 10 bits negativos\n";

print"imprimimos numeros de de 10 bits positivos\n";
for ( $u=0; $u <= 536;$u = $u +2) {
   print "@hola2[$u+2]@hola2[$u+3]\n";   
}#aqui cierra este ciclo
print"terminamos de imprimir numeros de de 10 bits positivos\n";

close(UNO);
close(DOS);