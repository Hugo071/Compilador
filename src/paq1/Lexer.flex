
package paq1;
import paq1.Tokens.*;
import java.util.Map;
import java.util.HashMap;

class Token {
    public String lexema;
    public String token;
    public int nLinea;

    public Token(String lexema, String token, int nLinea) {
        this.lexema = lexema;
        this.token = token;
        this.nLinea = nLinea;
    }

    public String getLexema() {
        return lexema;
    }

    public void setLexema(String lexema) {
        this.lexema = lexema;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public int getnLinea() {
        return nLinea;
    }

    public void setnLinea(int nLinea) {
        this.nLinea = nLinea;
    }
    
    @Override
    public String toString() {
        return super.toString(); 
    }
    
    
}

%%

%class Lexer
%type Tokens
%line
%column
%{
   public String lexeme;
   InfoTokens t = new InfoTokens();
   Map<String,Token> tablaSimbolos = new HashMap<>();
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
entero {t.numeroLinea=yyline; lexeme=yytext(); Token t1 = new Token(yytext(),"entero",yyline); tablaSimbolos.put(yytext(),t1); return entero;}
flotante {t.numeroLinea=yyline; lexeme=yytext(); Token t1 = new Token(yytext(),"flotante",yyline); tablaSimbolos.put(yytext(),t1); return flotante;}
car {t.numeroLinea=yyline; lexeme=yytext(); Token t1 = new Token(yytext(),"caracter",yyline); tablaSimbolos.put(yytext(),t1); return caracter;}
cad {t.numeroLinea=yyline; lexeme=yytext(); Token t1 = new Token(yytext(),"cadena",yyline); tablaSimbolos.put(yytext(),t1); return cadena;}
booleano {t.numeroLinea=yyline; lexeme=yytext(); Token t1 = new Token(yytext(),"booleano",yyline); tablaSimbolos.put(yytext(),t1); return booleano;}
por {t.numeroLinea=yyline; lexeme=yytext(); Token t1 = new Token(yytext(),"por",yyline); tablaSimbolos.put(yytext(),t1); return por;}
si {t.numeroLinea=yyline; lexeme=yytext(); Token t1 = new Token(yytext(),"si",yyline); tablaSimbolos.put(yytext(),t1); return si;}
entonces {t.numeroLinea=yyline; lexeme=yytext(); Token t1 = new Token(yytext(),"entonces",yyline); tablaSimbolos.put(yytext(),t1); return entonces;}
romper {t.numeroLinea=yyline; lexeme=yytext(); Token t1 = new Token(yytext(),"romper",yyline); tablaSimbolos.put(yytext(),t1); return romper;}
verdadero {t.numeroLinea=yyline; lexeme=yytext(); Token t1 = new Token(yytext(),"verdadero",yyline); tablaSimbolos.put(yytext(),t1); return verdadero;}
falso {t.numeroLinea=yyline; lexeme=yytext(); Token t1 = new Token(yytext(),"falso",yyline); tablaSimbolos.put(yytext(),t1); return falso;}
mostrar {t.numeroLinea=yyline; lexeme=yytext(); Token t1 = new Token(yytext(),"mostrar",yyline); tablaSimbolos.put(yytext(),t1); return mostrar;}
entrada {t.numeroLinea=yyline; lexeme=yytext(); Token t1 = new Token(yytext(),"entrada",yyline); tablaSimbolos.put(yytext(),t1); return entrada;}

/* Identificadores */
{id} {t.numeroLinea=yyline; lexeme=yytext(); Token t1 = new Token(yytext(),"id",yyline); tablaSimbolos.put(yytext(),t1); return id;}

/* Literal caracter */
{caracter} {t.numeroLinea=yyline; lexeme=yytext(); Token t1 = new Token(yytext(),"litcar",yyline); tablaSimbolos.put(yytext(),t1); return litcar;}

/* Literal cadena */
{cadena} {t.numeroLinea=yyline; lexeme=yytext(); Token t1 = new Token(yytext(),"litcad",yyline); tablaSimbolos.put(yytext(),t1); return litcad;}

/* Literal flotante */
{flotante} {t.numeroLinea=yyline; lexeme=yytext(); Token t1 = new Token(yytext(),"litflo",yyline); tablaSimbolos.put(yytext(),t1); return litflo;}

/* Literal entero */
{entero} {t.numeroLinea=yyline; lexeme=yytext(); Token t1 = new Token(yytext(),"litint",yyline); tablaSimbolos.put(yytext(),t1); return litint;}

/* Simbolos de asignación */
"=" {t.numeroLinea=yyline; lexeme=yytext(); Token t1 = new Token(yytext(),"Igual",yyline); tablaSimbolos.put(yytext(),t1); return Igual;}
"+=" {t.numeroLinea=yyline; lexeme=yytext(); Token t1 = new Token(yytext(),"MasIgual",yyline); tablaSimbolos.put(yytext(),t1); return MasIgual;}
"-=" {t.numeroLinea=yyline; lexeme=yytext(); Token t1 = new Token(yytext(),"MenosIgual",yyline); tablaSimbolos.put(yytext(),t1); return MenosIgual;}
"*=" {t.numeroLinea=yyline; lexeme=yytext(); Token t1 = new Token(yytext(),"PorIgual",yyline); tablaSimbolos.put(yytext(),t1); return PorIgual;}
"/=" {t.numeroLinea=yyline; lexeme=yytext(); Token t1 = new Token(yytext(),"DivIgual",yyline); tablaSimbolos.put(yytext(),t1); return DivIgual;}
"%=" {t.numeroLinea=yyline; lexeme=yytext(); Token t1 = new Token(yytext(),"FactIgual",yyline); tablaSimbolos.put(yytext(),t1); return FactIgual;}

/* Simbolos aritmeticos */
"+" {t.numeroLinea=yyline; lexeme=yytext(); Token t1 = new Token(yytext(),"Suma",yyline); tablaSimbolos.put(yytext(),t1); return Suma;}
"-" {t.numeroLinea=yyline; lexeme=yytext(); Token t1 = new Token(yytext(),"Resta",yyline); tablaSimbolos.put(yytext(),t1); return Resta;}
"/" {t.numeroLinea=yyline; lexeme=yytext(); Token t1 = new Token(yytext(),"Division",yyline); tablaSimbolos.put(yytext(),t1); return Division;}
"*" {t.numeroLinea=yyline; lexeme=yytext(); Token t1 = new Token(yytext(),"Producto",yyline); tablaSimbolos.put(yytext(),t1); return Producto;}
"%" {t.numeroLinea=yyline; lexeme=yytext(); Token t1 = new Token(yytext(),"Factorial",yyline); tablaSimbolos.put(yytext(),t1); return Factorial;}
"++" {t.numeroLinea=yyline; lexeme=yytext(); Token t1 = new Token(yytext(),"Incremento",yyline); tablaSimbolos.put(yytext(),t1); return Incremento;}
"--" {t.numeroLinea=yyline; lexeme=yytext(); Token t1 = new Token(yytext(),"Decremento",yyline); tablaSimbolos.put(yytext(),t1); return Decremento;}

/* Simbolos de comparación */
"==" {t.numeroLinea=yyline; lexeme=yytext(); Token t1 = new Token(yytext(),"DobleIgual",yyline); tablaSimbolos.put(yytext(),t1); return DobleIgual;}
"!=" {t.numeroLinea=yyline; lexeme=yytext(); Token t1 = new Token(yytext(),"Diferencia",yyline); tablaSimbolos.put(yytext(),t1); return Diferencia;}
"<" {t.numeroLinea=yyline; lexeme=yytext(); Token t1 = new Token(yytext(),"Menor",yyline); tablaSimbolos.put(yytext(),t1); return Menor;}
">" {t.numeroLinea=yyline; lexeme=yytext(); Token t1 = new Token(yytext(),"Mayor",yyline); tablaSimbolos.put(yytext(),t1); return Mayor;}
">=" {t.numeroLinea=yyline; lexeme=yytext(); Token t1 = new Token(yytext(),"MayorIgual",yyline); tablaSimbolos.put(yytext(),t1); return MayorIgual;}
"<=" {t.numeroLinea=yyline; lexeme=yytext(); Token t1 = new Token(yytext(),"MenorIgual",yyline); tablaSimbolos.put(yytext(),t1); return MenorIgual;}

/* Simbolos logicos */
"||" {t.numeroLinea=yyline; lexeme=yytext(); Token t1 = new Token(yytext(),"OR",yyline); tablaSimbolos.put(yytext(),t1); return OR;}
"&&" {t.numeroLinea=yyline; lexeme=yytext(); Token t1 = new Token(yytext(),"AND",yyline); tablaSimbolos.put(yytext(),t1); return AND;}
"!" {t.numeroLinea=yyline; lexeme=yytext(); Token t1 = new Token(yytext(),"Negacion",yyline); tablaSimbolos.put(yytext(),t1); return Negacion;}

/* Simbolos de agrupación */
"(" {t.numeroLinea=yyline; lexeme=yytext(); Token t1 = new Token(yytext(),"AbreParentesis",yyline); tablaSimbolos.put(yytext(),t1); return AbreParentesis;}
")" {t.numeroLinea=yyline; lexeme=yytext(); Token t1 = new Token(yytext(),"CierraParentesis",yyline); tablaSimbolos.put(yytext(),t1); return CierraParentesis;}
"[" {t.numeroLinea=yyline; lexeme=yytext(); Token t1 = new Token(yytext(),"AbreCorchetes",yyline); tablaSimbolos.put(yytext(),t1); return AbreCorchete;}
"]" {t.numeroLinea=yyline; lexeme=yytext(); Token t1 = new Token(yytext(),"CierraCorchetes",yyline); tablaSimbolos.put(yytext(),t1); return CierraCorchete;}
"{" {t.numeroLinea=yyline; lexeme=yytext(); Token t1 = new Token(yytext(),"AbreLlave",yyline); tablaSimbolos.put(yytext(),t1); return AbreLLave;}
"}" {t.numeroLinea=yyline; lexeme=yytext(); Token t1 = new Token(yytext(),"CierraLlave",yyline); tablaSimbolos.put(yytext(),t1); return CierreLLave;}

/* Simbolos de puntuación */
"," {t.numeroLinea=yyline; lexeme=yytext(); Token t1 = new Token(yytext(),"Coma",yyline); tablaSimbolos.put(yytext(),t1); return Coma;}
";" {t.numeroLinea=yyline; lexeme=yytext(); Token t1 = new Token(yytext(),"PuntoyComa",yyline); tablaSimbolos.put(yytext(),t1); return PuntoComa;}

 . {t.numeroLinea=yyline; lexeme=yytext(); return ERROR;}