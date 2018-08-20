#cool compiler#
#lexer#

Tokens are defined at the end of the file.
Keywords are defined before objectid and typeid, inorder to protect them from misinterpreting as objectids or typeids.
Definitions are defined using 'fragment'. 
  1. 0 to 9 are defined as digits
  2. lowercase letters are defined as lowerl
  3. uppercase letters are defined as upperl and so on....

Escape characters are taken care by 'WHITESPACE' token.  Whenever any of the symbol belonging to token 'WHITESPACE' is observed, it skips.(line blank symbol, \n)

STR_CONST recognises a string and calls process_string.
Process_string gets the string and implements the check and error procedure i.e, checks if there are any symbols or something that would refer to error when sent to parser.

Initially it checks for length of the string, if it is more than 1024, it reports error.
Else, it continues further and starts evaluating each character in the string.
If there are any errors like unescaped new line, null character, it prints the error and returns.
Else, it continues checking for further characters.
Once all the characters in the string are evaluated, and if there are no errors, then it prints the string.

Single line and multi-line comments are handled using tokens 'SLINE_COMMENT' and 'MLINE_COMMENT' . 
Nested comments are also handled in MLINE_COMMENT.


reportError function is to print error messages.
unMatched function is to report error, that does not fall in any of the pre-decided tokens/errors.