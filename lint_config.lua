return {
  whitelist_globals = {
    [".+%.moon"] = {
      "howl",
      "bundle_load"
    },
    ["citrine_lexer%.moon"] = {
      "any",
      "alpha",
      "capture",
      "compose",
      "blank",
      "digit",
      "float",
      "word",
      "S",
      "scan_until",
      "eol",
      "P",
      'r',
      'R',
      'B',
      'span',
      'upper',
      'sequence',
      'V',
      'sub_lex'
    },
    ["citrine_mode%.moon"] = {
      'r'
    }
  }
}
