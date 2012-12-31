module RubyOnRuby
  class FileLoader
    def self.setup(context)
      context.eval <<-JS
        XMLHttpRequest = function() {
          this.open = function(type, url) {
            this.responseText = loadFile(url);
          };
          this.send = function() {};
          this.status = 200;
          this.responseText = "";
          return this;
        };
      JS

      context['loadFile'] = lambda do |this, url|
        begin
          if url && url =~ /\A\.\/lib\/([\w\_\-\/]+\.rb)\Z/i
            file_name = $1
            File.read(File.expand_path("../../../vendor/javascripts/emscripted-ruby/lib/#{file_name}", __FILE__), :encoding => "binary")
          else
            nil
          end
        rescue => e
          puts "Exception when loading #{url}: #{e.message}"
          raise
        end
      end
    end
  end
end
