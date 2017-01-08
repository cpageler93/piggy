module PiggyCash
  module Core
    module Selection
      class Tag
        def self.print_tags_in_table(tags, title = nil)
          # create rows
          rows = []
          tags.each do |tag|

            # get row options
            row_options = block_given? ? (yield tag) : nil

            # make row
            row = [
              tag.name
            ]

            # highlight row if necessary
            if row_options && row_options[:highlight]
              color ||= row_options[:color]
              color ||= :green
              row.map!{|col|col.colorize(col, :foreground => color.to_s)}
            end

            # append row
            rows << row
          end

          title ||= "Tags (#{rows.count})"

          table = Terminal::Table.new :title => title,
                                      :headings => [
                                        'Name'
                                      ],
                                      :rows => rows
          puts table
        end
      end
    end
  end
end