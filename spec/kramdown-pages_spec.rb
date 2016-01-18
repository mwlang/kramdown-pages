require 'kramdown-pages'

describe Kramdown::Parser::KramdownPages do
  class Page
    attr_accessor :path, :permalink, :title
    
    def initialize permalink
      @permalink = permalink
      @path = "http://localhost/pages/#{permalink}"
      @title = permalink.gsub("-", ' ')
    end
    
    def self.find_by_path permalink
      return nil if permalink == 'bogus'
      Page.new permalink
    end
  end

  def md text
    ::Kramdown::Document.new(text,  :input => 'KramdownPages')
  end
  
  def md_to_html text
    md(text).to_html
  end
  
  context "when parsing a simple block" do
    it "converts a valid public page tag to an href tag" do
      expect(md_to_html("{page:simple-test}")).to eq "<p><a href=\"http://localhost/pages/simple-test\">simple test</a></p>\n"
    end

    it "converts a valid child page" do
      expect(md_to_html("{page:parent-page/child-page}")).to eq "<p><a href=\"http://localhost/pages/parent-page/child-page\">parent page/child page</a></p>\n"
    end

    it "falls back to default behaviour when the tag is malformed" do
      expect(md_to_html("{page:garbage page}")).to eq "<p>{page:garbage page}</p>\n"
    end

    it "treats the page tag as a span-level element" do
      expect(md_to_html("testing 123 {page:simple-test}")).to eq %{<p>testing 123 <a href="http://localhost/pages/simple-test">simple test</a></p>\n}
      expect(md_to_html("testing 123\n{page:1234}")).to eq %{<p>testing 123\n<a href="http://localhost/pages/1234">1234</a></p>\n}
      expect(md_to_html("testing 123\n\n{page:1234}")).to eq %{<p>testing 123</p>\n\n<p><a href="http://localhost/pages/1234">1234</a></p>\n}
    end

    it "is idempotent when generating kramdown" do
      expect(md("{page:simple-test}").to_kramdown).to eq "{page:simple-test}\n\n"
    end

    it "renders to a suitable placeholder when generating LaTeX" do
      expect(md("{page:simple-test}").to_latex).to eq "\\href{http://localhost/pages/simple-test}{page.title}\n\n"
    end
    
    context "non-existent page" do
      let(:content) { "{page:bogus}" }
      
      it "returns the text of the tag for HTML" do
        expect(md_to_html(content)).to eq "<p><a>bogus</a></p>\n"
      end
      it "returns the text of the tag for LaTeX" do
        expect(md(content).to_latex).to eq "bogus\n\n"
      end
    end
  end

  context "when parsing a complex document" do
    # Standard kramdown source and rendered files
    let(:standard_src)    { File.read(File.expand_path("../fixtures/standard.md", __FILE__)) }
    let(:standard_html)   { File.read(File.expand_path("../fixtures/standard.html", __FILE__)) }
    let(:standard_latex)  { File.read(File.expand_path("../fixtures/standard.tex", __FILE__)) }

    # KramdownPages source and rendered files
    let(:page_src)    { File.read(File.expand_path("../fixtures/page.md", __FILE__)) }
    let(:page_html)   { File.read(File.expand_path("../fixtures/page.html", __FILE__)) }
    let(:page_latex)  { File.read(File.expand_path("../fixtures/page.tex", __FILE__)) }

    context "without page tags" do
      it "produces valid HTML output" do
        expect(md_to_html(standard_src)).to eq standard_html
      end

      it "produces valid LaTeX output" do
        expect(md(standard_src).to_latex).to eq standard_latex
      end
    end

    context "with page tags" do
      it "produces valid HTML output" do
        expect(md_to_html(page_src)).to eq page_html
      end

      it "produces valid LaTeX output" do
        expect(md(page_src).to_latex).to eq page_latex
      end
    end
  end
end
