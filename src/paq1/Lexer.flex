
package paq1;
import paq1.Tokens.*;

%%

%class Lexer
%type Tokens
%line
%column
%{
   public String lexeme;
   InfoTokens t = new InfoTokens();
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

/* Reservadas */
entero {t.numeroLinea=yyline; lexeme=yytext(); return entero;}
flotante {t.numeroLinea=yyline; lexeme=yytext(); return flotante;}
car {t.numeroLinea=yyline; lexeme=yytext(); return caracter;}
cad {t.numeroLinea=yyline; lexeme=yytext(); return cadena;}
booleano {t.numeroLinea=yyline; lexeme=yytext(); return booleano;}
por {t.numeroLinea=yyline; lexeme=yytext(); return por;}
si {t.numeroLinea=yyline; lexeme=yytext(); return si;}
entonces {t.numeroLinea=yyline; lexeme=yytext(); return entonces;}
romper {t.numeroLinea=yyline; lexeme=yytext(); return romper;}
verdadero {t.numeroLinea=yyline; lexeme=yytext(); return verdadero;}
falso {t.numeroLinea=yyline; lexeme=yytext(); return falso;}
mostrar {t.numeroLinea=yyline; lexeme=yytext(); return mostrar;}
entrada {t.numeroLinea=yyline; lexeme=yytext(); return entrada;}

/* Identificadores */
{id} {t.numeroLinea=yyline; lexeme=yytext(); return id;}

/* Literal caracter */
{caracter} {t.numeroLinea=yyline; lexeme=yytext(); return litcar;}

/* Literal cadena */
{cadena} {t.numeroLinea=yyline; lexeme=yytext(); return litcad;}

/* Literal flotante */
{flotante} {t.numeroLinea=yyline; lexeme=yytext(); return litflo;}

/* Literal entero */
{entero} {t.numeroLinea=yyline; lexeme=yytext(); return litint;}

/* Simbolos de asignación */
"=" {t.numeroLinea=yyline; lexeme=yytext(); return Igual;}
"+=" {t.numeroLinea=yyline; lexeme=yytext(); return MasIgual;}
"-=" {t.numeroLinea=yyline; lexeme=yytext(); return MenosIgual;}
"*=" {t.numeroLinea=yyline; lexeme=yytext(); return PorIgual;}
"/=" {t.numeroLinea=yyline; lexeme=yytext(); return DivIgual;}
"%=" {t.numeroLinea=yyline; lexeme=yytext(); return FactIgual;}

/* Simbolos aritmeticos */
"+" {t.numeroLinea=yyline; lexeme=yytext(); return Suma;}
"-" {t.numeroLinea=yyline; lexeme=yytext(); return Resta;}
"/" {t.numeroLinea=yyline; lexeme=yytext(); return Division;}
"*" {t.numeroLinea=yyline; lexeme=yytext(); return Producto;}
"%" {t.numeroLinea=yyline; lexeme=yytext(); return Factorial;}
"++" {t.numeroLinea=yyline; lexeme=yytext(); return Incremento;}
"--" {t.numeroLinea=yyline; lexeme=yytext(); return Decremento;}

/* Simbolos de comparación */
"==" {t.numeroLinea=yyline; lexeme=yytext(); return DobleIgual;}
"!=" {t.numeroLinea=yyline; lexeme=yytext(); return Diferencia;}
"<" {t.numeroLinea=yyline; lexeme=yytext(); return Menor;}
">" {t.numeroLinea=yyline; lexeme=yytext(); return Mayor;}
">=" {t.numeroLinea=yyline; lexeme=yytext(); return MayorIgual;}
"<=" {t.numeroLinea=yyline; lexeme=yytext(); return MenorIgual;}

/* Simbolos logicos */
"||" {t.numeroLinea=yyline; lexeme=yytext(); return OR;}
"&&" {t.numeroLinea=yyline; lexeme=yytext(); return AND;}
"!" {t.numeroLinea=yyline; lexeme=yytext(); return Negacion;}

/* Simbolos de agrupación */
"(" {t.numeroLinea=yyline; lexeme=yytext(); return AbreParentesis;}
")" {t.numeroLinea=yyline; lexeme=yytext(); return CierraParentesis;}
"[" {t.numeroLinea=yyline; lexeme=yytext(); return AbreCorchete;}
"]" {t.numeroLinea=yyline; lexeme=yytext(); return CierraCorchete;}
"{" {t.numeroLinea=yyline; lexeme=yytext(); return AbreLLave;}
"}" {t.numeroLinea=yyline; lexeme=yytext(); return CierreLLave;}

/* Simbolos de puntuación */
"," {t.numeroLinea=yyline; lexeme=yytext(); return Coma;}
";" {t.numeroLinea=yyline; lexeme=yytext(); return PuntoComa;}

 . {return ERROR;}