#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "find"

module Version1
  class Action
    def initialize(glob="*", &block)
      @glob = glob
      @block = block
    end

    def trigger(path)
      @block.call(path) if File.fnmatch(@glob, path)
    end
  end

  class Rawk
    def initialize
      @actions = []
      yield(self) if block_given?
    end

    def on_path(glob="*", &block)
      @actions << Action.new(glob, &block)
    end

    def run(start_path)
      Find.find(start_path).each do |path|
        @actions.each do |a|
          a.trigger(path)
        end
      end
    end

    def on_file(glob="*", &block)
      on_path(glob) do |path|
        block.call(path) if File.file?(path)
      end
    end

    def on_dir(glob="*", &block)
      on_path(glob) do |path|
        block.call(path) if File.directory?(path)
      end
    end

    def transform(glob="*", &block)
      on_file(glob) do |path|
        contents = File.read(path)
        new_contents = block.call(contents)
        open(path, "w") {|io| io.write(new_contents)}
      end
    end
  end
end
