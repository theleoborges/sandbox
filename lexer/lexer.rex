class Lexer
macro
  BLANK         [\ \t]+
rule
  {BLANK}       { [:WHITESPACE, text] }
  func          { [:FUNC, [text, lineno]] }
  if            { [:IF, [text, lineno]] }
  else          { [:ELSE, [text, lineno]] }
  return        { [:RETURN, [text, lineno]] }
  ==            { [:EQUALS, [text, lineno]] }
  \|\|          { [:OP_OR, [text, lineno]] }
  ".*"          { [:STRING, [(/"(.*)"/.match(text)).captures[0], lineno]] }
  [a-z]\w*      { [:IDENTIFIER, [text, lineno]] }
  \d+           { [:NUMBER, [text.to_i, lineno]] }
  \n            { [:NEWLINE, text] }
  .             { [text, [text, lineno]] }
inner  
end
