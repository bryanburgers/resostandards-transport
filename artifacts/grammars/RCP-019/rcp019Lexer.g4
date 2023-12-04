lexer grammar rcp019Lexer;

options {
	tokenVocab = rcp019MetadataLexer;
}

CONCAT: PIPE;
LPAREN: '(';
RPAREN: ')';
SQUOTE: '\'';
QUOTE: '"';
DOT: '.';
ASTERISK: '*';
SLASH: '/';
EXCLAMATION: '!';
DOLLAR: '$';
CARET: '^';
BACKSLASH: '\\';
SINGLE_SPACE: ' ';
COLON: ':';
PIPE: '|';
LBRACKET: '[';
RBRACKET: ']';
HASH: '#';

OR: '.OR.';
AND: '.AND.';
NOT: '.NOT.';

EQ: '=';
NE: EXCLAMATION EQ;
LT: '<';
LTE: LT EQ;
GT: '>';
GTE: GT EQ;

CONTAINS: '.CONTAINS.';
IN: '.IN.';
COMMA: ',';
PLUS: '+';
MINUS: '-';
MOD: '.MOD.';

IIF: 'IIF';
MATCH: 'MATCH';
LAST: 'LAST';
LIST: 'LIST';
SET: 'SET';
DIFFERENCE: 'DIFFERENCE';
INTERSECTION: 'INTERSECTION';
UNION: 'UNION';
TRUE: 'TRUE';
FALSE: 'FALSE';
EMPTY: 'EMPTY';
NULL: 'NULL';
TODAY: 'TODAY';
NOW: 'NOW';
ENTRY: 'ENTRY';
OLDVALUE: 'OLDVALUE';
UPDATEACTION: 'UPDATEACTION';
ANY: 'any';

// See: Data Dictionary Member and Office Resources
MEMBER_LOGIN_ID: 'MEMBER_LOGIN_ID';
MEMBER_MLS_SECURITY_CLASS: 'MEMBER_MLS_SECURITY_CLASS';
MEMBER_TYPE: 'MEMBER_TYPE';
MEMBER_MLS_ID: 'MEMBER_MLS_ID';
OFFICE_BROKER_MLS_ID: 'OFFICE_BROKER_MLS_ID';
OFFICE_MLS_ID: 'OFFICE_MLS_ID';

ALPHA: ('a' ..'z' | 'A' ..'Z');
DIGIT: ('0' ..'9');

// special tokens
RESO_SPECIAL_TOKENS: FIELD_NAME | SPECOP;

// TODO: Dynamically fill in your FIELD_NAMEs here
FIELD_NAME:
	'ListPrice'
	| 'Status'
	| 'CloseDate'
	| 'Bedrooms'
	| 'Bathrooms';

SPECFUNC: IIF | MATCH;

SPECOP:
	EMPTY
	| TRUE
	| FALSE
	| TODAY
	| NOW
	| ENTRY
	| OLDVALUE
	| MEMBER_LOGIN_ID
	| MEMBER_MLS_SECURITY_CLASS
	| MEMBER_TYPE
	| MEMBER_MLS_ID
	| OFFICE_BROKER_MLS_ID
	| OFFICE_MLS_ID
	| UPDATEACTION
	| ANY;

ALPHANUM: ALPHA (ALPHA | DIGIT)*;

QUOTED_TERM: QUOTE (~[\\"])*? QUOTE | SQUOTE (~[\\'])*? SQUOTE;

// #2023-12-04T06:12:24.00Z# #2023-12-04T06:12:24.00-7:00# #2023-12-04T06:12:24.00+7:00#
ISO_TIMESTAMP:
	HASH ISO_DATE 'T' [0-23] COLON [0-59] COLON [0-59] DOT (
		DIGIT
	)* ('Z' | (PLUS | MINUS) [0-12] COLON [0-59]) HASH;

// #2023-12-04#
ISO_DATE: HASH YEAR '-' MONTH '-' DAY HASH;

YEAR: DIGIT DIGIT DIGIT DIGIT;
MONTH: [0-12];
DAY: [0-3] DIGIT;

//added support for c++ style comments
SLASH_STAR_COMMENT: '/*' .+? '*/' -> skip;
SLASH_SLASH_COMMENT: '//' .+? ('\n' | EOF) -> skip;

WS: [ \t\n\r]+ -> skip;