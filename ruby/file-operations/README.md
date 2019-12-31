# #xx Ruby File Handling

Reviewing common file operations with ruby

## Notes

### Create and Write to File

Use either
[`File.new`](https://ruby-doc.org/3.4.1/File.html#method-c-new)
or
[`File.open`](https://ruby-doc.org/3.4.1/File.html#method-c-open)

* `File.new` opens the file at the given path according to the given mode; creates and returns a new File object for that file.
* `File.open` uses `File.new` but also accepts a block

Examples:

    f = File.new(filename, 'w')
    f.write 'content'
    f.close
    # or
    File.open(filename, 'w') do |f|
      f.write 'content'
    end

### Read File

Files support [`IO#read`](https://ruby-doc.org/3.4.1/IO.html#method-i-read)
to read the content.

Example:

    content = File.read(filename)
    # or
    f = File.open('t.txt')
    content = f.read

### Append to File

Use the [append mode](https://ruby-doc.org/3.4.1/File.html#class-File-label-Read-2FWrite+Mode) when opening the file

Example:

    File.open('t.txt', 'a') do |file|
      file.write(content)
    end

### Delete File

Use [`File.delete`](https://ruby-doc.org/3.4.1/File.html#method-c-unlink)
aliased to `File.unlink`:

    File.delete('t.txt')

### Example

See [example.rb](./example.rb)

    #!/usr/bin/env ruby

    def create_file_new(filename, content)
      puts "# creating file using File.new: #{filename}"
      f = File.new(filename, 'w')
      f.write(content)
      f.close
    end

    def create_file_open(filename, content)
      puts "# creating file using File.open: #{filename}"
      File.open(filename, 'w') do |file|
        file.write(content)
      end
    end

    def append_to_file(filename, content)
      puts "# appending to file: #{filename}"
      File.open(filename, 'a') do |file|
        file.write(content)
      end
    end

    def read_file(filename)
      puts "# reading file: #{filename}"
      File.read(filename)
    end

    def delete_file(filename)
      puts "# deleting file: #{filename}"
      File.delete(filename)
    end

    filename = 'example.txt'

    create_file_new(filename, "Using File.new: Hello World!\n")
    puts read_file(filename)
    create_file_open(filename, "Using File.open: Hello World!\n")
    puts read_file(filename)
    append_to_file(filename, "Appended content to the file.\n")
    puts read_file(filename)
    delete_file(filename)

Run:

    $ ruby example.rb
    # creating file using File.new: example.txt
    # reading file: example.txt
    Using File.new: Hello World!
    # creating file using File.open: example.txt
    # reading file: example.txt
    Using File.open: Hello World!
    # appending to file: example.txt
    # reading file: example.txt
    Using File.open: Hello World!
    Appended content to the file.
    # deleting file: example.txt

## Credits and References

* <https://ruby-doc.org/3.4.1/File.html>
* <https://ruby-doc.org/3.4.1/Dir.html>
* <https://ruby-doc.org/3.4.1/stdlibs/fileutils/FileUtils.html>
