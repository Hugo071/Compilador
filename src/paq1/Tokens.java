
package paq1;

public enum Tokens {
    id,
    litcar,
    litcad,
    num,
    Igual("="),
    MasIgual("+="),
    MenosIgual("-="),
    PorIgual("*="),
    DivIgual("/="),
    FactIgual("%="),
    Suma("+"),
    Resta("-"),
    Division("/"),
    Producto("*"),
    Factorial("%"),
    Incremento("++"),
    Decremento("--"),
    DobleIgual("=="),
    Diferencia("!="),
    Menor("<"),
    Mayor(">"),
    MayorIgual(">="),
    MenorIgual("<="),
    OR("||"),
    AND("&&"),
    Negacion("!"),
    AbreParentesis("("),
    CierraParentesis(")"),
    AbreCorchete("["),
    CierraCorchete("]"),
    AbreLLave("{"),
    CierreLLave("}"),
    Coma(","),
    PuntoComa(";"),
    entero,
    flotante,
    caracter,
    cadena,
    booleano,
    por,
    si,
    entonces,
    romper, 
    verdadero,
    falso,
    mostrar,
    entrada,
    ERROR;
    
    private final String simbolo;

    private Tokens() {
        this.simbolo = null;
    }

    private Tokens(String simbolo) {
        this.simbolo = simbolo;
    }

    public String getSimbolo() {
        return simbolo;
    }
}
