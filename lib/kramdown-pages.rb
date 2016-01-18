require 'kramdown-pages/version'

require 'kramdown'

module Kramdown
  class Element
    CATEGORY[:page] = :block
  end
end

require 'kramdown-pages/parser'
require 'kramdown-pages/converter'
