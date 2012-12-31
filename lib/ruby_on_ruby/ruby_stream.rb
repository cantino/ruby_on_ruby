require 'stringio'

module RubyOnRuby
  class RubyStream
    attr_accessor :stream

    def initialize(stream = StringIO.new)
      @stream = stream
    end

    def input
      lambda do
        if stream.eof?
          nil
        else
          stream.read(1).ord
        end
      end
    end

    def output
      lambda do |this, char|
        stream.print char.to_i.chr
      end
    end
  end
end