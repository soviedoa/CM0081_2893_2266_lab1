{
module Parser where
import Syntax (Token(..),Term(..))
import Lexer
}

%name myParser
%tokentype { Token }
%error { parseError }

%token
    var { TokenVar $$ }
    '(' { TokenLParen }
    ')' { TokenRParen }
    '.' { TokenDot }
    ';' { TokenSemiColon }
    'λ' { TokenLambda }

%right Lam
%left App

%%


program : termList          {  $1 }

termList : term ';' termList  { $1 : $3 }
      | term ';'            { [$1] }

term : 'λ' var '.' term       {Lam $2 $4 }
    | appTerm                { $1 }

appTerm : appTerm aTerm       {App $1 $2}
        | aTerm               { $1 }

aTerm : '(' var ')'           {Var $2 }
      | var                   {Var $1 }

{

parseError :: [Token] -> a
parseError _ = error "Parse error"

}