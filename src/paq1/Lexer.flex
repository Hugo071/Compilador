
package paq1;
import paq1.Tokens.*;

%%

%class Lexer
%type Tokens
%{
   public String lexeme;
%}

terminadorDeLinea = \r|\n|\r\n
entradaDeCaracter = [^\r\n]
espacioEnBlanco = {terminadorDeLinea} | [ \t\f]
comentarioTradicional   = "/*" [^*] ~"*/" | "/*" "*"+ "/"
finDeLineaComentario = "//" {entradaDeCaracter}* {terminadorDeLinea}?
contenidoComentario = ( [^*] | \*+ [^/*] )*
comentarioDeDocumentacion = "/**" {contenidoComentario} "*"+ "/"
comentario = {comentarioTradicional} | {finDeLineaComentario} | {comentarioDeDocumentacion}

letra = [a-zA-ZñÑ_$á-źÁ-Ź]
digito = [0-9]
caracter = \'(\\.|[^\'\\])?\'
cadena = \"(\\.|[^\"\\])*\"
flotante = (-?[1-9][0-9]*\.[0-9]*[1-9])|(0\.0)|(-?[1-9][0-9]*\.0)|(-?[1-9][0-9]*\.[0-9]*[1-9][eE][-+][1-9][0-9]*)|(-?0\.[0-9]*[1-9][eE][-+][1-9][0-9]*)
entero = (0|-?[1-9][0-9]*)

id = {letra}({letra}|{digito})*
%%

{comentario}|{espacioEnBlanco} { /* Ignorar */ }

/* Identificadores */
{id} {lexeme=yytext(); return id;}

/* Literal caracter */
{caracter} {lexeme=yytext(); return litcar;}

/* Literal cadena */
{cadena} {lexeme=yytext(); return litcad;}

/* Literal flotante */
{flotante} {lexeme=yytext(); return litflo;}

/* Literal entero */
{entero} {lexeme=yytext(); return litint;}

/* Simbolos de asignación */
"=" {return Asignacion_Igual;}
"+=" {return Asignacion_MasIgual;}
"-=" {return Asignacion_MenosIgual;}
"*=" {return Asignacion_PorIgual;}
"/=" {return Asignacion_DivIgual;}
"%=" {return Asignacion_FactIgual;}

/* Simbolos aritmeticos */
"+" {return Aritmetico_Suma;}
"-" {return Aritmetico_Resta;}
"/" {return Aritmetico_Division;}
"*" {return Aritmetico_Producto;}
"%" {return Aritmetico_Factorial;}
"++" {return Aritmetico_Incremento;}
"--" {return Aritmetico_Decremento;}

/* Simbolos de comparación */
"==" {return Comparacion_Igual;}
"!=" {return Comparacion_Diferencia;}
"<" {return Comparacion_Menor;}
">" {return Comparacion_Mayor;}
">=" {return Comparacion_MayorIgual;}
"<=" {return Comparacion_MenorIgual;}

/* Simbolos logicos */
"||" {return Logico_OR;}
"&&" {return Logico_AND;}
"!" {return Logico_Negacion;}

/* Simbolos de agrupación */
"(" {return Agrupacion_AbreParentesis;}
")" {return Agrupacion_CierraParentesis;}
"[" {return Agrupacion_AbreCorchete;}
"]" {return Agrupacion_CierraCorchete;}
"{" {return Agrupacion_AbreLLave;}
"}" {return Agrupacion_CierreLLave;}

/* Simbolos de puntuación */
"," {return Puntuacion_Coma;}
";" {return Puntuacion_PuntoComa;}

/* Reservadas */
int {lexeme=yytext(); return entero;}
float {lexeme=yytext(); return flotante;}
char {lexeme=yytext(); return caracter;}
String {lexeme=yytext(); return cadena;}
boolean {lexeme=yytext(); return booleano;}
for {lexeme=yytext(); return por;}
if {lexeme=yytext(); return si;}
else {lexeme=yytext(); return entonces;}
break {lexeme=yytext(); return romper;}
true {lexeme=yytext(); return verdadero;}
false {lexeme=yytext(); return falso;}
 . {return ERROR;}