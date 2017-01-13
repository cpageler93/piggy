module PiggyCash
  module Core
    module Selection
      class Tag

        def self.select_tag_from_table(tags)
          print_tags_in_table(tags)

          # create array for selection
          tags_to_select = tags.collect{|tag| "#{tag.name} (#{tag.id})" }

          tag_id = choose(*tags_to_select)
          choosen_tag_index = tags_to_select.index(tag_id)
          choosen_tag = tags[choosen_tag_index]

          return choosen_tag
        end

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