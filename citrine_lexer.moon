-- Copyright 2016 Jake Russo
-- License: MIT


howl.aux.lpeg_lexer ->

  c = capture

  ident = (alpha + '_')^1 * (alpha + digit + '_')^0

  identifier = c 'identifier', ident

  comment = c 'comment', P'#' * scan_until eol

  operator = c 'operator', S'+-/*<>=≤≥≠←^@;'

  special = c 'special', word { 'Nil', 'True', 'False' }

  member = c 'member', word { 'my', 'me' }

  keyword = c 'keyword', ident * P':'

  declarator = c 'definition', P'var'

  -- string = c 'string', span("'", "'", '\\')

  number = c 'number', any { float, digit^1 }

  functions = c 'function', word {
    'isNil', 'type', 'myself', 'toString', 'break', 'continue',
    'not', 'flip', 'toNumber', 'odd', 'even', 'positive', 'negative',
    'factorial', 'floor', 'ceiling', 'round', 'absolute',
    'squareRoot', 'expoonent', 'sine', 'cosine', 'tangent',
    'arctangent', 'logarithm', 'toBoolean', 'bytes',
    'asciiUpperCase', 'asciiLowerCase', 'asciiLowerCase1st',
    'asciiUpperCase1st', 'trim', 'leftTrim', 'rightTrim',
    'htmlEscape', 'run', 'new', 'max', 'min', 'sum', 'product',
    'pop', 'shift', 'count', 'path', 'read', 'exists', 'include',
    'delete', 'size', 'close', 'rewind', 'end', 'dust',
    'objectCount', 'keptCount', 'keptAlloc', 'stickyCount',
    'memoryLimit', 'argCount', 'exit', 'waitForInput',
    'flush', 'roll', 'rawRandomNumber', 'wait', 'time', 'brk'
  }

  P {
    'all'

    all: any {
      comment,
      V'block',
      V'string',
      operator,
      declarator,
      keyword,
      special,
      number,
      member,
      functions,
      identifier,
      V'html'
    }

    string: sequence {
      c('string', "'"),
      V'string_chunk',
      c('string', "'")
    }

    string_chunk: c('string', scan_until(any("'", '\\'))) * any {
      #P("'"),
      V'escape' * V'string_chunk',
      c('string', P(1)) * V'string_chunk'
    }

    escape: c 'function', P'\\' * S"'\\nrtbfv0"

    block: P"{" * any {
      c('keyword', P'\\'),
      c('definition', scan_until P'|') * c('keyword', P'|')
    }

    html: sequence {
      capture('operator', P'?>'),
      sub_lex('html', '<?'),
      capture('operator', '<?')
    }
  }
