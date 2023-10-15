
package paq1;
import static paq1.Tokens.*;
import java.util.Map;
import java.util.LinkedHashMap;

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
   Map<String,Token> tablaSimbolos = new LinkedHashMap<>();
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
espacio = [ ]+
caracter = \'(\\.|[^\'\\])?\'
carinc = \'(\\.|[^\'\\])?
cadena = \"(\\.|[^\"\\])*\"
cadinc = \"(\\.|[^\"\\])*
flotante = (-?[1-9][0-9]*\.[0-9]*[1-9])|(0\.0)|(-?[1-9][0-9]*\.0)|(-?[1-9][0-9]*\.[0-9]*[1-9][eE][-+][1-9][0-9]*)|(-?0\.[0-9]*[1-9][eE][-+][1-9][0-9]*)
entero = (0|-?[1-9][0-9]*)
num = {entero} | {flotante}
tipo = entero|flotante|caracter|cadena|booleano

id = {letra}({letra}|{digito})*
%%

{comentario}|{espacioEnBlanco} { /* Ignorar */ }

/* Reservadas */
programa {t.numeroLinea=yyline; t.lexema=yytext(); lexeme=yytext(); Token t1 = new Token(yytext(),"programa",yyline); return programa;}
funcion {t.numeroLinea=yyline; t.lexema=yytext(); lexeme=yytext(); Token t1 = new Token(yytext(),"funcion",yyline); return funcion;}
procedimiento {t.numeroLinea=yyline; t.lexema=yytext(); lexeme=yytext(); Token t1 = new Token(yytext(),"procedimiento",yyline); return procedimiento;}
principal {t.numeroLinea=yyline; t.lexema=yytext(); lexeme=yytext(); Token t1 = new Token(yytext(),"principal",yyline); return principal;}
sino {t.numeroLinea=yyline; t.lexema=yytext(); lexeme=yytext(); Token t1 = new Token(yytext(),"sino",yyline); return sino;}
inc {t.numeroLinea=yyline; t.lexema=yytext(); lexeme=yytext(); Token t1 = new Token(yytext(),"inc",yyline); return inc;}
dec {t.numeroLinea=yyline; t.lexema=yytext(); lexeme=yytext(); Token t1 = new Token(yytext(),"dec",yyline); return dec;}
mientras {t.numeroLinea=yyline; t.lexema=yytext(); lexeme=yytext(); Token t1 = new Token(yytext(),"mientras",yyline); return mientras;}
hacer {t.numeroLinea=yyline; t.lexema=yytext(); lexeme=yytext(); Token t1 = new Token(yytext(),"hacer",yyline); return hacer;}
para {t.numeroLinea=yyline; t.lexema=yytext(); lexeme=yytext(); Token t1 = new Token(yytext(),"para",yyline); return para;}
entero {t.numeroLinea=yyline; t.lexema=yytext(); lexeme=yytext(); Token t1 = new Token(yytext(),"entero",yyline); return entero;}
flotante {t.numeroLinea=yyline; t.lexema=yytext(); lexeme=yytext(); Token t1 = new Token(yytext(),"flotante",yyline); return flotante;}
caracter {t.numeroLinea=yyline; t.lexema=yytext(); lexeme=yytext(); Token t1 = new Token(yytext(),"caracter",yyline); return caracter;}
cadena {t.numeroLinea=yyline; t.lexema=yytext(); lexeme=yytext(); Token t1 = new Token(yytext(),"cadena",yyline); return cadena;}
booleano {t.numeroLinea=yyline; t.lexema=yytext(); lexeme=yytext(); Token t1 = new Token(yytext(),"booleano",yyline); return booleano;}
si {t.numeroLinea=yyline; t.lexema=yytext(); lexeme=yytext(); Token t1 = new Token(yytext(),"si",yyline); return si;}
entonces {t.numeroLinea=yyline; t.lexema=yytext(); lexeme=yytext(); Token t1 = new Token(yytext(),"entonces",yyline); return entonces;}
verdadero {t.numeroLinea=yyline; t.lexema=yytext(); lexeme=yytext(); Token t1 = new Token(yytext(),"verdadero",yyline); return verdadero;}
falso {t.numeroLinea=yyline; t.lexema=yytext(); lexeme=yytext(); Token t1 = new Token(yytext(),"falso",yyline); return falso;}
mostrar {t.numeroLinea=yyline; t.lexema=yytext(); lexeme=yytext(); Token t1 = new Token(yytext(),"mostrar",yyline); return mostrar;}
leer {t.numeroLinea=yyline; t.lexema=yytext(); lexeme=yytext(); Token t1 = new Token(yytext(),"leer",yyline); return leer;}

/* Identificadores */
{id} {t.numeroLinea=yyline; t.lexema=yytext(); lexeme=yytext(); Token t1 = new Token(yytext(),"id",yyline); tablaSimbolos.put(yytext(),t1); return id;}
"f."{id} {t.numeroLinea=yyline; t.lexema=yytext(); lexeme=yytext(); Token t1 = new Token(yytext(),"idf",yyline); tablaSimbolos.put(yytext(),t1); return idf;}
"p."{id} {t.numeroLinea=yyline; t.lexema=yytext(); lexeme=yytext(); Token t1 = new Token(yytext(),"idp",yyline); tablaSimbolos.put(yytext(),t1); return idp;}

/* Literal caracter */
{caracter} {t.numeroLinea=yyline; t.lexema=yytext(); lexeme=yytext(); Token t1 = new Token(yytext(),"litcar",yyline); return litcar;}

/* Literal cadena */
{cadena} {t.numeroLinea=yyline; t.lexema=yytext(); lexeme=yytext(); Token t1 = new Token(yytext(),"litcad",yyline); return litcad;}

/* num */
{num} {t.numeroLinea=yyline; t.lexema=yytext(); lexeme=yytext(); Token t1 = new Token(yytext(),"num",yyline); return num;}

/* Simbolos de asignación */
":=" {t.numeroLinea=yyline; t.lexema=yytext(); lexeme=yytext(); Token t1 = new Token(yytext(),":=",yyline); return Igual;}

/* Simbolos aritmeticos */
"+" {t.numeroLinea=yyline; t.lexema=yytext(); lexeme=yytext(); Token t1 = new Token(yytext(),"+",yyline); return Suma;}
"-" {t.numeroLinea=yyline; t.lexema=yytext(); lexeme=yytext(); Token t1 = new Token(yytext(),"-",yyline); return Resta;}
"/" {t.numeroLinea=yyline; t.lexema=yytext(); lexeme=yytext(); Token t1 = new Token(yytext(),"/",yyline); return Division;}
"*" {t.numeroLinea=yyline; t.lexema=yytext(); lexeme=yytext(); Token t1 = new Token(yytext(),"*",yyline); return Producto;}
"%" {t.numeroLinea=yyline; t.lexema=yytext(); lexeme=yytext(); Token t1 = new Token(yytext(),"%",yyline); return Factorial;}

/* Simbolos de comparación */
"==" {t.numeroLinea=yyline; t.lexema=yytext(); lexeme=yytext(); Token t1 = new Token(yytext(),"==",yyline); return DobleIgual;}
"¡=" {t.numeroLinea=yyline; t.lexema=yytext(); lexeme=yytext(); Token t1 = new Token(yytext(),"¡=",yyline); return Diferencia;}
"<" {t.numeroLinea=yyline; t.lexema=yytext(); lexeme=yytext(); Token t1 = new Token(yytext(),"<",yyline); return Menor;}
">" {t.numeroLinea=yyline; t.lexema=yytext(); lexeme=yytext(); Token t1 = new Token(yytext(),">",yyline); return Mayor;}
"<=" {t.numeroLinea=yyline; t.lexema=yytext(); lexeme=yytext(); Token t1 = new Token(yytext(),"@",yyline); return mI;}
">=" {t.numeroLinea=yyline; t.lexema=yytext(); lexeme=yytext(); Token t1 = new Token(yytext(),"#",yyline); return MI;}

/* Simbolos logicos */
"||" {t.numeroLinea=yyline; t.lexema=yytext(); lexeme=yytext(); Token t1 = new Token(yytext(),"||",yyline); return OR;}
"&&" {t.numeroLinea=yyline; t.lexema=yytext(); lexeme=yytext(); Token t1 = new Token(yytext(),"&&",yyline); return AND;}
"!" {t.numeroLinea=yyline; t.lexema=yytext(); lexeme=yytext(); Token t1 = new Token(yytext(),"!",yyline); return Negacion;}

/* Simbolos de agrupación */
"(" {t.numeroLinea=yyline; t.lexema=yytext(); lexeme=yytext(); Token t1 = new Token(yytext(),"(",yyline); return AbreParentesis;}
")" {t.numeroLinea=yyline; t.lexema=yytext(); lexeme=yytext(); Token t1 = new Token(yytext(),")",yyline); return CierraParentesis;}
"[" {t.numeroLinea=yyline; t.lexema=yytext(); lexeme=yytext(); Token t1 = new Token(yytext(),"[",yyline); return AbreCorchete;}
"]" {t.numeroLinea=yyline; t.lexema=yytext(); lexeme=yytext(); Token t1 = new Token(yytext(),"]",yyline); return CierraCorchete;}
"{" {t.numeroLinea=yyline; t.lexema=yytext(); lexeme=yytext(); Token t1 = new Token(yytext(),"{",yyline); return AbreLLave;}
"}" {t.numeroLinea=yyline; t.lexema=yytext(); lexeme=yytext(); Token t1 = new Token(yytext(),"}",yyline); return CierreLLave;}

/* Simbolos de puntuación */
"," {t.numeroLinea=yyline; t.lexema=yytext(); lexeme=yytext(); Token t1 = new Token(yytext(),",",yyline); return Coma;}
";" {t.numeroLinea=yyline; t.lexema=yytext(); lexeme=yytext(); Token t1 = new Token(yytext(),";",yyline); return PuntoComa;}

 . {t.numeroLinea=yyline; t.lexema=yytext(); lexeme=yytext(); return ERROR;}
{cadinc} {t.numeroLinea=yyline; t.lexema=yytext(); lexeme=yytext(); return ERROR;}
{carinc} {t.numeroLinea=yyline; t.lexema=yytext(); lexeme=yytext(); return ERROR;}
