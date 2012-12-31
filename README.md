# RubyOnRuby

An unholy amalgam of therubyracer's V8 engine and emscripted-ruby to allow a truly sandboxed Ruby-on-Ruby environment.  This is a terrible idea.

## Installation

Add this line to your application's Gemfile:

    gem 'ruby_on_ruby'

Or install it yourself as:

    $ gem install ruby_on_ruby

As with any usage of [therubyracer](https://github.com/cowboyd/therubyracer), you'll need to install v8 with your package manager or use the `libv8` gem (currently `~> 3.11.8`).  See [therubyracer's installation instructions](https://github.com/cowboyd/therubyracer#prerequisites) for more information.

## Usage

    require 'ruby_on_ruby'
    context = RubyOnRuby::Context.new
    context.eval "(1..10).inject(1) { |fact, n| fact * n }" # => "3628800"

## I have questions!

#### What version of Ruby is running in the sandbox?

Ruby MRI 1.8.7

#### Can the host and guest environments interact?

Only through assignment and return values, at the moment.  If [emscripted-ruby](https://github.com/replit/emscripted-ruby.git) provides a more complete API, so can I.  For now, it's probably best to communicate over simple structures and do things like this:

    context.eval "a = #{my_ruby_data.inspect}"
    context.eval "result = process a"
    result = eval(context.eval("result"))
    # Horrible, right?  Right!

#### Is there Garbage Collection?

Nope.  Available RAM ought be enough for anybody.  (According to emscripted-ruby, "The Ruby garbage collector is currently incompatible with Emscripten, so we disable it completely. This causes memory leaks, but prevents crashes.")

#### Does this actually work?

Sometimes.

#### Is it slow?

That depends.  For your problem, is three orders of magnitude slower acceptable?  Remember: Ruby scales!  Just run it on three orders of magnitude more servers.

(Also, the same code may be up to an order of magnitude FASTER than native, non-sandboxed Ruby if you write it in JavaScript and run it with therubyracer, or with `RubyOnRuby::Context#js_eval`.)

#### Why would you make this?

No comment.

## License

This code is released under the MIT License.  You can use it however you like.  I recommend that you not, and will not be held accountable if you do.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
