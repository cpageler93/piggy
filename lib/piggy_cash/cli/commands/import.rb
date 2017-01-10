module PiggyCash
  module CLI
    module Commands
      module Import
        def import_commands
          command 'import' do |c|
            c.syntax = 'piggycash import --file ~/path/to/file.csv --encoding ISO-8859-1 --seperator \';\' --type ingdiba'
            c.description = 'Import: imports CSV file with booking entries to database'

            c.option '--file STRING', String, 'path to file'
            c.option '--encoding STRING', String, 'encoding of file'
            c.option '--seperator STRING', String, 'seperator of csv file'
            c.option '--type STRING', String, 'type of input file'

            c.action do |args, options|
              options = {
                file: options.file,
                encoding: options.encoding,
                seperator: options.seperator,
                type: options.type,
              }

              cmd = PiggyCash::CLI::Import.new
              cmd.execute(options)
            end
          end
        end
      end
    end
  end
end