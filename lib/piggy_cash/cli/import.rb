require 'csv'

module PiggyCash
  module CLI
    class Import < Base

      def execute(options = {})
        ensure_valid_connection_in_keychain_item!

        # set option defaults
        options[:encoding]  ||= 'utf-8'
        options[:seperator] ||= ','

        # get options
        file = options[:file]
        encoding = options[:encoding]
        type = options[:type]

        # check file exists
        unless File.file?(file)
          puts "Error: file does not exist at ´#{file_path}´"
          exit 1
        end

        csv_options = {
          :col_sep => ';',
          :encoding => encoding
        }

        rows = []
        CSV.foreach(file, csv_options) do |row|
          rows << row
        end

        case type.upcase
        when "INGDIBA"
          PiggyCash::Core::Importer::INGDiBa.import(rows)
        else
          puts "Error: type not supported ´#{type}´"
        end

      end

    end
  end
end