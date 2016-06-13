-- Copyright 2016 Jake Russo
-- License: MIT

{
  lexer: bundle_load('citrine_lexer')
  -- api: bundle_load('api')
  -- completers: { 'in_buffer', 'api' }

  comment_syntax: '#'

  default_config:
    indent: 4

  indentation: {
    more_after: {
      r'[\\|\\\\]\\s*$'
    }
  }

  auto_pairs: {
    '(': ')'
    '{': '}'
    "'": "'"
  }

  structure: (editor) =>
    [l for l in *editor.buffer.lines when l\match('^%s*.-%s*:=%s')]
}
