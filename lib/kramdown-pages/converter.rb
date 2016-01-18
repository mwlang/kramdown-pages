module Kramdown
  module Converter

    class Html
      def convert_page(el, indent)
        if page = Page.find_by_path(el.value)
          %{<a href="#{page.path}">#{page.title}</a>}
        else
          %{<a>#{el.value}</a>}
        end
      end
    end

    class Kramdown
      def convert_page(el, opts)
        "{page:#{el.value}}"
      end
    end

    class Latex
      def convert_page(el, opts)
        if page = Page.find_by_path(el.value)
          "\\href{#{page.path}}{page.title}"
        else
          el.value
        end
      end

    end

  end
end
