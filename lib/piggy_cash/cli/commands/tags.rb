module PiggyCash
  module CLI
    module Commands
      module Tags
        def tag_commands
          command 'tags recognize' do |c|
            c.syntax = 'piggycash tag recognize'
            c.description = 'Tags: recognize tags on booking entries, silent'

            c.action do |arg, options|
              cmd = PiggyCash::CLI::Tags::Recognize.new
              cmd.execute(options)
            end
          end

          command 'tags reveal untagged' do |c|
            c.syntax = 'piggycash tags reveal untagged'
            c.description = 'Tags: reveal unrecognized booking entries, silent (just a table)'

            c.action do |arg, options|
              cmd = PiggyCash::CLI::Tags::Reveal::Untagged.new
              cmd.execute(options)
            end
          end
        end
      end
    end
  end
end