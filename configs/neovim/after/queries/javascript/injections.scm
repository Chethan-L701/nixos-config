(call_expression
  (member_expression (property_identifier) @prop (#eq? @prop "query"))
  (arguments
    (template_string) @qsql
    )
  )
((field_definition
  (property_identifier) @query (#match? @query "Query$")
  ((template_string)  @injection.content (#set! injection.language "sql")
  )))
