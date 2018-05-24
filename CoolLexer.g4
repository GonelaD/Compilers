lexer grammar CoolLexer;

tokens{
	ERROR,
	TYPEID,
	OBJECTID,
	BOOL_CONST,
	INT_CONST,
	STR_CONST,
	LPAREN,
	RPAREN,
	COLON,
	ATSYM,
	SEMICOLON,
	COMMA,
	PLUS,
	MINUS,
	STAR,
	SLASH,
	TILDE,
	LT,
	EQUALS,
	LBRACE,
	RBRACE,
	DOT,
	DARROW,
	LE,
	ASSIGN,
	CLASS,
	ELSE,
	FI,
	IF,
	IN,
	INHERITS,
	LET,
	LOOP,
	POOL,
	THEN,
	WHILE,
	CASE,
	ESAC,
	OF,
	NEW,
	ISVOID,
	NOT
}

/*
  DO NOT EDIT CODE ABOVE THIS LINE
*/

@lexer::header {
	#include <Token.h>
}
@lexer::postinclude {
	using namespace std;
	using namespace antlr4;
}
@members{

	/*
		YOU CAN ADD YOUR MEMBER VARIABLES AND METHODS HERE
	*/

	/**
	* Function to report errors.
	* Use this function whenever your lexer encounters any erroneous input
	* DO NOT EDIT THIS FUNCTION
	*/
	void reportError(string errorString){ //to handle error messages
		setText(errorString);
		setType(ERROR);
	}

	void unmatched(){ //unidentified token symbol is printed out
		auto t = _factory->create(make_pair(this, _input), type, _text, channel, tokenStartCharIndex, getCharIndex()-1, tokenStartLine, tokenStartCharPositionInLine);
		string text = t->getText();
		reportError(text);
	}
	void process_string()  //checks for errors in a string and prints accordingly
	{
		auto t = _factory->create(make_pair(this, _input), type, _text, channel, tokenStartCharIndex, getCharIndex()-1, tokenStartLine, tokenStartCharPositionInLine);
		string text = t->getText();
		text=text.substr(1,text.length()-1);
		string newstring = "";

		//if length of the string exceeds 1024, it throws error.
		if(text.length()>1024) 
		{
			reportError("String length is too long");
		}

		else{  //traverses through the string to check for errors

			int i = 0;
			while(i <= text.length()-2)
			{
				// if there is a null character in-between
				if(text[i] == '\0')
				{
					reportError("Contains NULL character");
					return;
				}

				///if there is a line break, in-between the string
				else if(text[i] == '\n')
				{
					reportError("Unterminated string constant");
					return;
				}
				else if(text[i] == '\\') //escaped characters are added accordingly
				{
					char nxt = text[i+1];
					switch(nxt){

						case 'n':
							newstring+= "\n";
							break;
						case '\n':
							newstring+= "\n";
							break;
						case '0':
							newstring+= "0";
							break;
						case 'b':
							newstring+= "\b";
							break;
						case 't':
							newstring+= "\t";
							break;
						case 'f':
							newstring+= "\f";
							break;
						default:
							newstring+= text[i+1];
							break;
					}

					i = i + 2;
					continue;
				}

				else
				{
					newstring+= text[i]; //if no error at particular index, then it adds to newstring
				}

				i = i + 1;
			}

			setText(newstring); //if there are no errors throughout the string, then it prints.

		}

		//write your code to test strings here
		
		

	}
	
}

/*
	WRITE ALL LEXER RULES BELOW
*/


//basic tokens
SEMICOLON   : ';';
DARROW      : '=>';
LPAREN		: '(';
RPAREN		: ')';
COMMA		: ',';
PLUS		: '+';
MINUS		: '-';
STAR 		: '*';
SLASH		: '/';
TILDE		: '~';
LT 			: '<';
LE 			: '<=';
EQUALS 		: '=';
LBRACE		: '{';
RBRACE		: '}';
ASSIGN		: '<-';
DOT			: '.';
ATSYM		: '@';
COLON		: ':';

//keywords
CASE	: ('c'|'C')('a'|'A')('s'|'S')('e'|'E');
ESAC	: ('e'|'E')('s'|'S')('a'|'A')('c'|'C');
IF		: ('i'|'I')('f'|'F');
FI 		: ('f'|'F')('i'|'F');
ELSE	: ('e'|'E')('l'|'L')('s'|'S')('e'|'E');
THEN	: ('t'|'T')('h'|'H')('e'|'E')('n'|'N');
WHILE	: ('w'|'W')('h'|'H')('i'|'I')('l'|'L')('e'|'E');
LOOP	: ('l'|'L')('o'|'O')('o'|'O')('p'|'P');
POOL 	: ('p'|'P')('o'|'O')('o'|'O')('l'|'L');
CLASS	: ('c'|'C')('l'|'L')('a'|'A')('s'|'S')('s'|'S');
INHERITS: ('i'|'I')('n'|'N')('h'|'H')('e'|'E')('r'|'R')('i'|'I')('t'|'T')('s'|'S');
IN 		: ('i'|'I')('n'|'N');
OF		: ('o'|'O')('f'|'F');
LET		: ('l'|'L')('e'|'E')('t'|'T');
NEW		: ('n'|'N')('e'|'E')('w'|'W');
NOT		: ('n'|'N')('o'|'O')('t'|'T');
ISVOID	: ('i'|'I')('s'|'S')('v'|'V')('o'|'O')('i'|'I')('d'|'D');

//definitons

fragment DIGIT	: ('0'..'9');
fragment LOWERL	: ('a'..'z');
fragment UPPERL	: ('A'..'Z');
fragment LETTER	: (LOWERL|UPPERL);
fragment TRUE 	: ('t')('r'|'R')('u'|'U')('e'|'E');
fragment FALSE	: ('f')('a'|'A')('l'|'L')('s'|'S')('e'|'E');
fragment OPEN	: ~["(*"];
fragment CLOSE	: ~["*)"];

// expressions 
INT_CONST	: DIGIT+;
BOOL_CONST	: (TRUE|FALSE);
TYPEID		: (UPPERL)('_'|LETTER|DIGIT)*;
OBJECTID	: (LOWERL)('_'|LETTER|DIGIT)*;

// checks if there is blankspace or any escaping characters, and skips accordingly
WHITESPACE	: [ \t\r\f\n]+ -> skip;

//if there is EOF symbol before actual termination of the file, then this reports.
EOF_STRING	: ('"' ( '\\' | WHITESPACE | ~('\\'|'"') )* )(EOF){reportError("EOF found in string");};

//idenifies a string and calls process_string function
STR_CONST 	: '"' ( '\\' | ~('"'| '\n' ) | WHITESPACE )* '"' {process_string();};

//single line comment that starts with "--" is skipped, i.e, removed.
SLINE_COMMENT	: '--'(.)*? ('\n'|'\r') -> skip;

//multi line comments are skipped too. This case also handles nested multi line comments
MLINE_COMMENT 	: '(*' (MLINE_COMMENT |.|WHITESPACE)*? '*)'->skip;

//if the comment is left open then this reports error.
E_COMMENT	: ('*)'|'(*') {reportError("UnMatched comment identifier.");};


//this is to handle non pre-decided tokens(like '$' symbol)
OTHER		: . {unmatched();}; 


