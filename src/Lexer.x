{
{-# OPTIONS_GHC -Wno-missing-local-signatures #-}
module Lexer (myLexer) where
import Syntax (Token(..))
}

%wrapper "basic"

tokens :-

  $white+                       ;
  "--".*                        ;
  [a-zA-Z] ([a-zA-Z] | [0-9])*      { \s -> TokenVar s }
  \(                            { \s -> TokenLParen }
  \)                            { \s -> TokenRParen }
  \.                            { \s -> TokenDot }
  \;                            { \s -> TokenSemiColon }
  \λ                            { \s -> TokenLambda }

{
  myLexer = alexScanTokens
}