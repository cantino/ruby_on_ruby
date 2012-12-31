module RubyOnRuby
  class Console
    def log(*args)
      puts *args.map(&:to_s)
    end
  end
end