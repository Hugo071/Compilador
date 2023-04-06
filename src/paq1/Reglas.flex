package Papus;
import static Papus.Tokens.*;

%%
%class lexer
%type Tokens
L=[a-zA-Z]
D=[0-9]
S=[']
E=[ ]
T=[\t]
B=[\n]
C=[\"]

%{
public String lexeme;
%}
%%
{E}							{return ESPACIO;}
{T}							{return TABULADOR;}
{B}							{return SALTO;}
"programa"					{return INICIO_PROG;}
"finprograma"				{return FIN_PROG;}
"int"					{return T_DATO1;}
"float"						{return T_DATO2;}
"char"  				{return T_DATO3;}
"String"					{return T_DATO4;}
"if"						{return EST_CONTROLSI;}
"then"						{return ESTRUCCTRL;}
"finif"						{return EST_CONTROLFINSI;}
"for"						{return CICLO_PARA;}
"finfor"  					{return FIN_PARA;}
"inc"						{return INCREMENTO;}
"syso"						{return SYSO;}
"dec"						{return DECREMENTO;}
"="							{return ASIGNACION;}
"+"							{return OPERADOR_ARITMETICO1;}
"-"							{return OPERADOR_ARITMETICO2;}
"*"							{return OPERADOR_ARITMETICO3;}
"/"							{return OPERADOR_ARITMETICO4;}
"<"							{return OPERADOR_LOGICO1;}
">"							{return OPERADOR_LOGICO2;}
"!"							{return OPERADOR_LOGICO3;}
"("							{return SIMBOLO_A1;}
")"							{return SIMBOLO_A2;}
";"							{return SIMBOLO_S;}
","							{return COMA;}
{L}({L}|(D))* 				{lexeme=yytext(); return ID;}
{D}+						{lexeme=yytext(); return ENTERO;}
{D}+"."{D}+					{lexeme=yytext(); return DECIMAL;}
{C}({D}|{L}|{E}|{T}|{B})*{C} {lexeme=yytext(); return MSJ;}
{S}({E}|{T}|{B}|{D}|{L}){S}  	{lexeme=yytext(); return CARACTER;}