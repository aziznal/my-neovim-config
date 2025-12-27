return {
  "johmsalas/text-case.nvim",
  config = function()
    require("textcase").setup({})
  end,
}

-- Case           Example      Method                         Trigger
---------------+--------------+-----------------------------+---------
-- Upper-case     LOREM IPSUM  textcase.api.to_constant_case  u
-- Lower-case     lorem ipsum  textcase.api.to_lower_case     l
-- Snake-case     lorem_ipsum  textcase.api.to_snake_case     s
-- Dash-case      lorem-ipsum  textcase.api.to_dash_case      d
-- Constant-case  LOREM_IPSUM  textcase.api.to_constant_case  n
-- Dot-case       lorem.ipsum  textcase.api.to_dot_case       
-- Camel-case     loremIpsum   textcase.api.to_camel_case     c
-- Pascal-case    LoremIpsum   textcase.api.to_pascal_case    p
-- Title-case     Lorem Ipsum  textcase.api.to_title_case     
-- Path-case      lorem/ipsum  textcase.api.to_path_case      
-- Phrase-case    Lorem ipsum  textcase.api.to_phrase_case    
