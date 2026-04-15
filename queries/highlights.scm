; Ada highlight queries for nvim-treesitter.
; See the syntax at https://tree-sitter.github.io/tree-sitter/using-parsers#pattern-matching-with-queries
; See also https://github.com/nvim-treesitter/nvim-treesitter/blob/master/CONTRIBUTING.md#parser-configurations
; for a list of recommended @ tags, though not all of them have matching
; highlights in neovim.

; ---------------------------------------------------------------------------
; Punctuation
; ---------------------------------------------------------------------------

[
  "("
  ")"
] @punctuation.bracket

[
  ","
  ";"
  ":"
  "."
] @punctuation.delimiter

[
  "<<"
  ">>"
] @punctuation.special

; ---------------------------------------------------------------------------
; Operators
; ---------------------------------------------------------------------------

[
  "+"
  "-"
  "*"
  "/"
  "**"
  "&"
  "="
  "/="
  "<"
  ">"
  "<="
  ">="
  ".."
  ":="
  "=>"
] @operator

(binary_adding_operator) @operator

(multiplying_operator) @operator

(relational_operator) @operator

(unary_adding_operator) @operator

; ---------------------------------------------------------------------------
; Keywords
; ---------------------------------------------------------------------------

[
  "abort"
  "abs"
  "abstract"
  "accept"
  "access"
  "all"
  "array"
  "at"
  "begin"
  "body"
  "declare"
  "delay"
  "delta"
  "digits"
  "do"
  "end"
  "entry"
  "exit"
  "generic"
  "goto"
  "interface"
  "is"
  "limited"
  "mod"
  "new"
  "null"
  "of"
  "others"
  "out"
  "overriding"
  "package"
  "pragma"
  "private"
  "protected"
  "range"
  "separate"
  "subtype"
  "synchronized"
  "tagged"
  "task"
  "terminate"
  "type"
  "until"
  "when"
] @keyword

"record" @keyword.type

[
  "aliased"
  "constant"
  "renames"
] @keyword.modifier

[
  "with"
  "use"
] @keyword.import

[
  "function"
  "procedure"
] @keyword.function

[
  "and"
  "in"
  "not"
  "or"
  "xor"
] @keyword.operator

[
  "while"
  "loop"
  "for"
  "parallel"
  "reverse"
  "some"
] @keyword.repeat

"return" @keyword.return

[
  "case"
  "if"
  "else"
  "then"
  "elsif"
  "select"
] @keyword.conditional

[
  "exception"
  "raise"
] @keyword.exception

; ---------------------------------------------------------------------------
; Literals
; ---------------------------------------------------------------------------

(comment) @comment @spell

(string_literal) @string

(character_literal) @character

(numeric_literal) @number

(primary_null) @constant.builtin

; ---------------------------------------------------------------------------
; Type definitions
; ---------------------------------------------------------------------------

(full_type_declaration
  (identifier) @type.definition)

(subtype_declaration
  (identifier) @type.definition)

(incomplete_type_declaration
  (identifier) @type.definition)

(private_type_declaration
  (identifier) @type.definition)

(private_extension_declaration
  (identifier) @type.definition)

(task_type_declaration
  (identifier) @type.definition)

(protected_type_declaration
  (identifier) @type.definition)

(formal_complete_type_declaration
  (identifier) @type.definition)

(formal_incomplete_type_declaration
  (identifier) @type.definition)

; Enumeration values are constants
(enumeration_type_definition
  (identifier) @constant)

; ---------------------------------------------------------------------------
; Variables and parameters
; ---------------------------------------------------------------------------

; General identifier references in expressions (low priority — overridden by
; more specific captures below for types, functions, modules, etc.)
(term
  name: (identifier) @variable)

; Selected component: Obj.Field — prefix is variable, selector is member
(selected_component
  prefix: (identifier) @variable)

(selected_component
  selector_name: (identifier) @variable.member)

(parameter_specification
  (identifier) @variable.parameter)

(discriminant_specification
  (identifier) @variable.parameter)

(entry_index_specification
  (identifier) @variable.parameter)

(choice_parameter_specification
  (identifier) @variable)

(object_declaration
  name: (identifier) @variable)

(component_declaration
  (identifier) @variable.member)

; Field names in record aggregates (Name_Holder => ...)
(component_choice_list
  (identifier) @variable.member)

(number_declaration
  (identifier) @constant)

(exception_declaration
  (identifier) @variable)

(loop_parameter_specification
  (identifier) @variable)

(iterator_specification
  iterator_name: (_) @variable)

; ---------------------------------------------------------------------------
; Type references (via subtype_mark field) — after variables so @type wins
; ---------------------------------------------------------------------------

(subtype_declaration
  subtype_mark: (_) @type)

(derived_type_definition
  subtype_mark: (_) @type)

(object_declaration
  subtype_mark: (_) @type)

(component_definition
  subtype_mark: (_) @type)

(parameter_specification
  subtype_mark: (_) @type)

(discriminant_specification
  subtype_mark: (_) @type)

(result_profile
  subtype_mark: (_) @type)

(access_to_object_definition
  subtype_mark: (_) @type)

(allocator
  subtype_mark: (_) @type)

(formal_object_declaration
  subtype_mark: (_) @type)

(extended_return_object_declaration
  subtype_mark: (_) @type)

; ---------------------------------------------------------------------------
; Function / procedure declarations
; ---------------------------------------------------------------------------

(procedure_specification
  name: (_) @function)

(function_specification
  name: (_) @function)

(entry_declaration
  .
  (identifier) @function)

; Repeat the name at "end <Name>"
(subprogram_body
  endname: (identifier) @function)

(package_body
  endname: (identifier) @module)

(package_declaration
  endname: (identifier) @module)


; ---------------------------------------------------------------------------
; Function / procedure calls
; ---------------------------------------------------------------------------

(function_call
  name: (identifier) @function.call)

(function_call
  name: (selected_component
    selector_name: (_) @function.call))

(procedure_call_statement
  name: (identifier) @function.call)

(procedure_call_statement
  name: (selected_component
    selector_name: (_) @function.call))

; ---------------------------------------------------------------------------
; Modules (packages)
; ---------------------------------------------------------------------------

(package_declaration
  name: (_) @module)

(package_body
  name: (_) @module)

(generic_instantiation
  name: (_) @function)

(package_renaming_declaration
  name: (_) @module)

; ---------------------------------------------------------------------------
; Labels
; ---------------------------------------------------------------------------

(label
  statement_identifier: (identifier) @label)

(loop_label
  (identifier) @label)

; ---------------------------------------------------------------------------
; Import clauses
; ---------------------------------------------------------------------------

(use_clause
  "use" @keyword.import
  "type" @keyword.import)

(with_clause
  "private" @keyword.import)

(with_clause
  "limited" @keyword.import)

(use_clause
  (_) @module)

(with_clause
  (_) @module)

; Override selected_component defaults inside import clauses
(with_clause
  (selected_component
    prefix: (identifier) @module))

(with_clause
  (selected_component
    selector_name: (identifier) @module))

(use_clause
  (selected_component
    prefix: (identifier) @module))

(use_clause
  (selected_component
    selector_name: (identifier) @module))

; ---------------------------------------------------------------------------
; Context-dependent keyword overrides
; ---------------------------------------------------------------------------

(loop_statement
  "end" @keyword.repeat)

(if_statement
  "end" @keyword.conditional)

(case_statement
  "end" @keyword.conditional)

(selective_accept
  "end" @keyword.conditional)

(loop_parameter_specification
  "in" @keyword.repeat)

(iterator_specification
  [
    "in"
    "of"
  ] @keyword.repeat)

(range_attribute_designator
  "range" @keyword.repeat)

(raise_statement
  "with" @keyword.exception)

(subprogram_declaration
  "is" @keyword.function
  "abstract" @keyword.function)

(aspect_specification
  "with" @keyword)

(full_type_declaration
  "is" @keyword.type)

(subtype_declaration
  "is" @keyword.type)

(record_definition
  "end" @keyword.type)

(full_type_declaration
  (_
    "access" @keyword.type))

(array_type_definition
  "array" @keyword.type
  "of" @keyword.type)

(access_to_object_definition
  "access" @keyword.type)

(access_to_object_definition
  "access" @keyword.type
  [
    (general_access_modifier
      "constant" @keyword.type)
    (general_access_modifier
      "all" @keyword.type)
  ])

(range_constraint
  "range" @keyword.type)

(signed_integer_type_definition
  "range" @keyword.type)

(index_subtype_definition
  "range" @keyword.type)

(record_type_definition
  "abstract" @keyword.type)

(record_type_definition
  "tagged" @keyword.type)

(record_type_definition
  "limited" @keyword.type)

(record_type_definition
  (record_definition
    "null" @keyword.type))

(private_type_declaration
  "is" @keyword.type
  "private" @keyword.type)

(private_type_declaration
  "tagged" @keyword.type)

(private_type_declaration
  "limited" @keyword.type)

(task_type_declaration
  "task" @keyword.type
  "is" @keyword.type)

; ---------------------------------------------------------------------------
; Preprocessor (gnatprep)
; ---------------------------------------------------------------------------

(gnatprep_declarative_if_statement) @keyword.directive

(gnatprep_if_statement) @keyword.directive

(gnatprep_identifier) @keyword.directive

; ---------------------------------------------------------------------------
; Expression functions and aspect specifications
; ---------------------------------------------------------------------------

; Gray the body of expression functions
(expression_function_declaration
  (function_specification)
  "is"
  (_) @attribute)

(subprogram_declaration
  (aspect_specification) @attribute)

; ---------------------------------------------------------------------------
; Documentation comments
; ---------------------------------------------------------------------------

((comment) @comment.documentation
  .
  [
    (entry_declaration)
    (subprogram_declaration)
    (parameter_specification)
  ])

(compilation_unit
  .
  (comment) @comment.documentation)

(component_list
  (component_declaration)
  .
  (comment) @comment.documentation)

(enumeration_type_definition
  (identifier)
  .
  (comment) @comment.documentation)
