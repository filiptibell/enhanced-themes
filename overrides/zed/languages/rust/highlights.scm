(type_identifier) @type
(primitive_type) @type.builtin
(self) @variable.special
(field_identifier) @property

(trait_item name: (type_identifier) @type.interface)
(impl_item trait: (type_identifier) @type.interface)
(abstract_type trait: (type_identifier) @type.interface)
(dynamic_type trait: (type_identifier) @type.interface)
(trait_bounds (type_identifier) @type.interface)

(call_expression
  function: [
    (identifier) @function
    (scoped_identifier
      name: (identifier) @function)
    (field_expression
      field: (field_identifier) @function.method)
  ])

(generic_function
  function: [
    (identifier) @function
    (scoped_identifier
      name: (identifier) @function)
    (field_expression
      field: (field_identifier) @function.method)
  ])

(function_item name: (identifier) @function.definition)
(function_signature_item name: (identifier) @function.definition)

(macro_invocation
  macro: [
    (identifier) @function.special
    (scoped_identifier
      name: (identifier) @function.special)
  ])

(macro_definition
  name: (identifier) @function.special.definition)

; Identifier conventions

; Assume uppercase names are types/enum-constructors
((identifier) @type
 (#match? @type "^[A-Z]"))

; Assume all-caps names are constants
((identifier) @constant
 (#match? @constant "^_*[A-Z][A-Z\\d_]*$"))

; Highlight enum variants
(enum_variant
  name: (identifier) @enum.variant)

; Highlight enum variants such as EnumName::VariantName
(scoped_identifier
  path: (identifier) @type
  "::"
  name: (identifier) @enum.variant
  (#match? @type "^[A-Z]")
  (#match? @enum.variant "^[A-Z]"))

; Highlight enum variants in some other special cases: let Enum(_), return Enum(_)
; This may have some false positives with unit structs, but is generally better
(tuple_struct_pattern
  type: (identifier) @enum.variant
  "("
  (identifier)
  ")"
  (#match? @enum.variant "^[A-Z]"))
(call_expression
  function: (identifier) @enum.variant
  (arguments)
  (#match? @enum.variant "^[A-Z]"))

; Highlight the special "Self" type identifier
((identifier) @variable.special
  (#eq? @variable.special "Self"))

((type_identifier) @variable.special
  (#eq? @variable.special "Self"))

; Highlight the special "Self" type when it is an enum
(scoped_identifier
  path: (identifier) @variable.special
  "::"
  name: (identifier) @enum.variant
  (#eq? @variable.special "Self")
  (#match? @enum.variant "^[A-Z]"))

[
  "("
  ")"
  "{"
  "}"
  "["
  "]"
] @punctuation.bracket

(_
  .
  "<" @punctuation.bracket
  ">" @punctuation.bracket)

[
  ";"
  ","
  "::"
] @punctuation.delimiter

[
  "#"
] @punctuation.special

[
  "as"
  "async"
  "await"
  "break"
  "const"
  "continue"
  "default"
  "dyn"
  "else"
  "enum"
  "extern"
  "fn"
  "for"
  "if"
  "impl"
  "in"
  "let"
  "loop"
  "macro_rules!"
  "match"
  "mod"
  "move"
  "pub"
  "ref"
  "return"
  "static"
  "struct"
  "trait"
  "type"
  "union"
  "unsafe"
  "use"
  "where"
  "while"
  "yield"
  (crate)
  (mutable_specifier)
  (super)
] @keyword

[
  (string_literal)
  (raw_string_literal)
  (char_literal)
] @string

[
  (integer_literal)
  (float_literal)
] @number

(boolean_literal) @constant

[
  (line_comment)
  (block_comment)
] @comment

[
  "!"
  "!="
  "%"
  "%="
  "&"
  "&="
  "&&"
  "*"
  "*="
  "*"
  "+"
  "+="
  ","
  "-"
  "-="
  "->"
  "."
  ".."
  "..="
  "..."
  "/"
  "/="
  ":"
  ";"
  "<<"
  "<<="
  "<"
  "<="
  "="
  "=="
  "=>"
  ">"
  ">="
  ">>"
  ">>="
  "@"
  "^"
  "^="
  "|"
  "|="
  "||"
  "?"
] @operator

(lifetime) @lifetime
