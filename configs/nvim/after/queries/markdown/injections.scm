;; injections.scm for markdown

;; (code_fence_content) @injection.content
;;   (#set! injection.language (substitute! @code_fence_name "```" ""))

(fenced_code_block
  (info_string
    (language) @injection.language)
  (code_fence_content) @injection.content)
