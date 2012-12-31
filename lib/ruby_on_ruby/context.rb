require 'v8'
require 'ruby_on_ruby/console'
require 'ruby_on_ruby/ruby_stream'
require 'ruby_on_ruby/file_loader'

module RubyOnRuby
  class Context
    attr_accessor :v8_context

    def initialize
      self.v8_context = V8::Context.new
      v8_context['console'] = Console.new # Mock out `console`.
      FileLoader.setup(v8_context) # Mock out XMLHttpRequest to allow loading of Ruby Standard Library files.
      v8_context.load(File.expand_path("../../../vendor/javascripts/emscripted-ruby/ruby.closure.js", __FILE__)) # Load Ruby itself.
      @input = RubyStream.new(STDIN)
      @output = RubyStream.new(STDOUT)
      @error = RubyStream.new(STDERR)
      v8_context['input'] = @input.input
      v8_context['output'] = @output.output
      v8_context['error'] = @error.output
      v8_context.eval "Ruby.initialize(input, output, error)"
    end

    def eval(str)
      @v8_context['lastInput'] = str
      @v8_context.eval "Ruby.stringify(Ruby.eval(lastInput))"
    end

    def js_eval(str)
      @v8_context.eval str
    end
  end
end
