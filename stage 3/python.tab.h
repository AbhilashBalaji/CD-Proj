/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_PYTHON_TAB_H_INCLUDED
# define YY_YY_PYTHON_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    IF = 258,
    ELIF = 259,
    ELSE = 260,
    WHILE = 261,
    FOR = 262,
    PRINT = 263,
    IN = 264,
    RANGE = 265,
    OR = 266,
    AND = 267,
    NOT = 268,
    LP = 269,
    RP = 270,
    LEFT_SQUARE_P = 271,
    RIGHT_SQUARE_P = 272,
    LEFT_CURL_P = 273,
    RIGHT_CURL_P = 274,
    COLON = 275,
    ASSIGN_OP = 276,
    EQ = 277,
    NEQ = 278,
    LT = 279,
    GT = 280,
    LTE = 281,
    GTE = 282,
    PLUS_OP = 283,
    MINUS_OP = 284,
    MUL_OP = 285,
    DIV_OP = 286,
    POWER_OP = 287,
    IDENTIFIER = 288,
    DIGIT = 289,
    NEWLINE = 290
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_PYTHON_TAB_H_INCLUDED  */
