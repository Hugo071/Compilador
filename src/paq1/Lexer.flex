
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
comentaroDeDocumentacion = "/**" {contenidoComentario} "*"+ "/"
comentario = {comentarioTradicional} | {finDeLineaComentario} | {comentarioDeDocumentacion}

letra = [a-zA-ZñÑ_$á-źÁ-Ź]
digito = [0-9]
caracter = ^'[^']*'$
cadena = ^"[^"]*"$
flotante = ^(-?[1-9][0-9]*\.[0-9]*[1-9])|(0\.0)|(-?[1-9][0-9]*\.0)|(-?[1-9][0-9]*\.[0-9]*[1-9][eE][-+][1-9][0-9]*)|(-?0\.[0-9]*[1-9][eE][-+][1-9][0-9]*)$
entero = ^(0|-?[1-9][0-9]*)$

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
"=" {return =;}
"+=" {return +=;}
"-=" {return -=;}
"*=" {return *=;}
"/=" {return /=;}
"%=" {return %=;}

/* Simbolos aritmeticos */
"+" {return =;}
"-" {return -;}
"/" {return /;}
"*" {return *;}
"%" {return %;}
"++" {return ++;}
"--" {return --;}

/* Simbolos de comparación */
"==" {return ==;}
"!=" {return !=;}
"<" {return <;}
">" {return >;}
">=" {return >=;}
"<=" {return <=;}

/* Simbolos logicos */
"||" {return ||;}
"&&" {return &&;}
"!" {return !;}

/* Simbolos de agrupación */
"(" {return (;}
")" {return );}
"[" {return [;}
"]" {return ];}
"{" {return {;}
"}" {return };}

/* Simbolos de puntuación */
"," {return ,;}
";" {return ;;}

/* Reservadas */
int {lexeme=yytext(); return int;}
float {lexeme=yytext(); return float;}
char {lexeme=yytext(); return char;}
String {lexeme=yytext(); return String;}
boolean {lexeme=yytext(); return boolean;}
for {lexeme=yytext(); return for;}
if {lexeme=yytext(); return if;}
else {lexeme=yytext(); return else;}
break {lexeme=yytext(); return break;}
true {lexeme=yytext(); return true;}
false {lexeme=yytext(); return false;}