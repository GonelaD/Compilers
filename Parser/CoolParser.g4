parser grammar CoolParser;

options {
	tokenVocab = CoolLexer;
}

@parser::header {
	#include <Token.h>
}
@parser::postinclude {
	using namespace std;
	using namespace antlr4;
}

@members{
	string filename;
	void setFilename(string f){
		filename = f;
	}

/*
	DO NOT EDIT THE FILE ABOVE THIS LINE
	Add member functions, variables below.
*/

}

/*
	Add Grammar rules and appropriate actions for building AST below.
*/

program : class_list EOF ;

class_list : (class_sc SEMICOLON)*; //SEMICOLON is a token here.

class_sc : /*TODO write your rules*/
			CLASS TYPEID (INHERITS TYPEID)? LBRACE (feature SEMICOLON)* RBRACE ;

feature : OBJECTID LPAREN (formal(COMMA formal)*)? RPAREN COLON TYPEID LBRACE expr RBRACE
		  | OBJECTID COLON TYPEID (ASSIGN expr)? ;

formal : OBJECTID COLON TYPEID ;

expr : OBJECTID ASSIGN expr
	   | expr (ATSYM TYPEID)? DOT OBJECTID LPAREN (expr (COMMA expr)*)? RPAREN
	   | OBJECTID LPAREN (expr (COMMA expr)*)? RPAREN
	   | IF expr THEN expr ELSE expr FI
	   | WHILE expr LOOP expr POOL
	   | LBRACE (expr SEMICOLON)+ RBRACE
	   | LET OBJECTID COLON TYPEID (ASSIGN expr)? (COMMA OBJECTID COLON TYPEID(ASSIGN expr)?)* IN expr
	   | CASE expr OF (OBJECTID COLON TYPEID DARROW expr SEMICOLON)+ ESAC
	   | NEW TYPEID
	   | ISVOID expr
	   | expr PLUS expr
	   | expr MINUS expr
	   | expr STAR expr
	   | expr SLASH expr
	   | TILDE expr
	   | expr LT expr
	   | expr LE expr
	   | expr EQUALS expr
	   | NOT expr
	   | LPAREN expr RPAREN
	   | OBJECTID
	   | INT_CONST
	   | STR_CONST
	   | BOOL_CONST ; 

