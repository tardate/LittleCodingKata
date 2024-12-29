# #312 CSV to Markdown Tables (Ruby)

How to convert comma-separated value data into markdown tables with ruby.

## Notes

Converting CSV files to Markdown tables is a pretty common task I encounter, especially when generating documentation. The CSV data may come from a report, spreadsheet, or database extract, and I want to include it as a correctly formatted markdown table.

See [python/csv2md](../../python/csv2md/) for how to do this with
python scripts, command line utilities, online tools, and editor extensions.

These notes provide some ruby alternatives.

To test options, I'm using a listing of the Sharpe novels by Bernard Cornwell: [sharpe.csv](./sharpe.csv).

### csv2md gem

The [csv2md](https://rubygems.org/gems/csv2md) gem provides a command line utility
for converting csv formatted data to a GitHub Flavored Markdown table.

Example usage:

    cd using_csv2md
    gem install bundler
    bundle install
    csv2md ../sharpe.csv > README.md

See the [raw output here](./using_csv2md/README.md)
and the [rendered markdown output here](./using_csv2md/).

### Custom Ruby Script

Uses [csv](https://ruby.github.io/csv/) to read the input file and generate markdown.
See the [csv2md.rb](./using_custom_script/csv2md.rb) script.
The essence of the conversion is in these few lines:

    def csv_to_markdown(file)
      table = CSV.read(file)
      markdown = ""
      markdown << "| " + table[0].join(" | ") + " |\n"
      markdown << "|" + (" --- |" * table[0].size) + "\n"
      table[1..-1].each do |row|
        markdown << "| " + row.join(" | ") + " |\n"
      end
      markdown
    end

Example usage:

    cd using_custom_script
    gem install bundler
    bundle install
    ruby csv2md.rb ../sharpe.csv > README.md

See the [raw output here](./using_custom_script/README.md)
and the [rendered markdown output here](./using_custom_script/).

## Credits and References

* [python/csv2md](../../python/csv2md/) - using python scripts, command line utilities, online tools, and editor extensions
* [csv2md](https://rubygems.org/gems/csv2md)
