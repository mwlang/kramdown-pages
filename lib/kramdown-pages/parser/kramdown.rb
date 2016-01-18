require 'kramdown/parser/kramdown'

module Kramdown
  module Parser

    class KramdownPages < ::Kramdown::Parser::Kramdown

      def initialize(source, options)
        super
        @span_parsers.unshift(:page)
      end

      def parse_page
        @src.pos += @src.matched_size
        permalink = @src[1]
        @tree.children << Element.new(:page, permalink)
      end

      define_parser(:page, /\{page:([\_\-\/0-9a-zA-Z]+?)\}/)

    end

  end
end
