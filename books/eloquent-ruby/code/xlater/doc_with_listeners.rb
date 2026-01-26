#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "../common/document"

module TraditionalListeners
  class DocumentSaveListener
    def on_save(doc, path)
      puts "Hey, I've been saved!"
    end
  end

  class DocumentLoadListener
    def on_load(doc, path)
      puts "Hey, I've been loaded!"
    end
  end

  class Document < ::Document; end

  class Document
    attr_accessor :load_listener
    attr_accessor :save_listener

    # Most of the class omitted...

    def load(path)
      @content = File.read(path)
      load_listener.on_load(self, path) if load_listener
    end

    def save(path)
      File.open(path, "w") {|f| f.print(@content)}
      save_listener.on_save(self, path) if save_listener
    end
  end
end

module BlockListeners
  class Document < ::Document; end

  class Document
    # Most of the class omitted...
    
    def on_save(&block_function)
      @save_listener = block_function
    end

    def on_load(&block_function)
      @load_listener = block_function
    end

    def load(path)
      @content = File.read(path)
      @load_listener.call(self, path) if @load_listener
    end

    def save(path)
      File.open(path, "w") { |f| f.print(@content) }
      @save_listener.call(self, path) if @save_listener
    end
  end
end
