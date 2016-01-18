kramdown-pages
==============

This gem extends the default [kramdown][] parser with a new block-level
element which adds support for embedding Custom Page links in a Markdown document.

Installation
------------

Add this line to your application's Gemfile:

    gem 'kramdown-pages'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kramdown-pages


Usage
-----

### With standalone kramdown and Rails

* Ensure you have a Page model that responds to #title and Page::find_by_path, and #path where
  * #title returns the Page title
  * #path returns fully-qualified URL to the page
  * Page::find_by_path returns a Page instance (or nil) given <permalink>

* Pass the `input` option as shown below when initializing a new Kramdown::Document

    Kramdown::Document.new(content, :input => 'KramdownPages')

Syntax
------

All kramdown supported markup [syntax][] is supported.  This gem simply extends the parser to support `{page:<permalink>}` span-level element. The element
will be replaced with an appropriate `<a href="page#path">page#title</a>` tag.

`<permalink>` should be replaced with the identifier of the Page you are referencing.  The identifier can be hyphenated text, underscored text, or numerical identifier, but cannot contain spaces and special characters.  That is, it's regular expression matcher is: `[\_\-\/0-9a-zA-Z]+?`
  

Contributing
------------

1. Fork
2. Create a topic branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request


License
-------

MIT License &mdash; see `MIT-LICENSE` for more information

[kramdown]: http://kramdown.rubyforge.org/
[syntax]: http://kramdown.rubyforge.org/syntax.html
