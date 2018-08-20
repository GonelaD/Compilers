
	#include <Token.h>


// Generated from CoolLexer.g4 by ANTLR 4.7.1

#pragma once


#include "antlr4-runtime.h"


	using namespace std;
	using namespace antlr4;


namespace cool {


class  CoolLexer : public antlr4::Lexer {
public:
  enum {
    ERROR = 1, TYPEID = 2, OBJECTID = 3, BOOL_CONST = 4, INT_CONST = 5, 
    STR_CONST = 6, LPAREN = 7, RPAREN = 8, COLON = 9, ATSYM = 10, SEMICOLON = 11, 
    COMMA = 12, PLUS = 13, MINUS = 14, STAR = 15, SLASH = 16, TILDE = 17, 
    LT = 18, EQUALS = 19, LBRACE = 20, RBRACE = 21, DOT = 22, DARROW = 23, 
    LE = 24, ASSIGN = 25, CLASS = 26, ELSE = 27, FI = 28, IF = 29, IN = 30, 
    INHERITS = 31, LET = 32, LOOP = 33, POOL = 34, THEN = 35, WHILE = 36, 
    CASE = 37, ESAC = 38, OF = 39, NEW = 40, ISVOID = 41, NOT = 42, WHITESPACE = 43, 
    EOF_STRING = 44, SLINE_COMMENT = 45, MLINE_COMMENT = 46, E_COMMENT = 47, 
    OTHER = 48
  };

  CoolLexer(antlr4::CharStream *input);
  ~CoolLexer();



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
  	

  virtual std::string getGrammarFileName() const override;
  virtual const std::vector<std::string>& getRuleNames() const override;

  virtual const std::vector<std::string>& getChannelNames() const override;
  virtual const std::vector<std::string>& getModeNames() const override;
  virtual const std::vector<std::string>& getTokenNames() const override; // deprecated, use vocabulary instead
  virtual antlr4::dfa::Vocabulary& getVocabulary() const override;

  virtual const std::vector<uint16_t> getSerializedATN() const override;
  virtual const antlr4::atn::ATN& getATN() const override;

  virtual void action(antlr4::RuleContext *context, size_t ruleIndex, size_t actionIndex) override;
private:
  static std::vector<antlr4::dfa::DFA> _decisionToDFA;
  static antlr4::atn::PredictionContextCache _sharedContextCache;
  static std::vector<std::string> _ruleNames;
  static std::vector<std::string> _tokenNames;
  static std::vector<std::string> _channelNames;
  static std::vector<std::string> _modeNames;

  static std::vector<std::string> _literalNames;
  static std::vector<std::string> _symbolicNames;
  static antlr4::dfa::Vocabulary _vocabulary;
  static antlr4::atn::ATN _atn;
  static std::vector<uint16_t> _serializedATN;


  // Individual action functions triggered by action() above.
  void EOF_STRINGAction(antlr4::RuleContext *context, size_t actionIndex);
  void STR_CONSTAction(antlr4::RuleContext *context, size_t actionIndex);
  void E_COMMENTAction(antlr4::RuleContext *context, size_t actionIndex);
  void OTHERAction(antlr4::RuleContext *context, size_t actionIndex);

  // Individual semantic predicate functions triggered by sempred() above.

  struct Initializer {
    Initializer();
  };
  static Initializer _init;
};

}  // namespace cool
