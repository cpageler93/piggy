module PiggyCash
  module CLI
    module Commands
      module Query
        def query_commands
          command 'query assign tags' do |c|
            c.syntax = 'piggycash query assign tags'
            c.description = 'Query: create, select query and assign tags to it'

            c.option '--select', 'Select existing Query'
            c.option '--create', 'Create new Query'

            c.action do |arg, options|
              options = {
                select: options.select,
                create: options.create
              }
              cmd = PiggyCash::CLI::Query::Assign::Tags.new
              cmd.execute(options)
            end
          end

          command 'query split' do |c|
            c.syntax = 'piggycash query split'
            c.description = 'Query: split single query multiple queries'

            c.action do |arg, options|

              options = {
                query_name: (arg.length >= 1 ? arg[0] : nil)
              }

              cmd = PiggyCash::CLI::Query::Split.new
              cmd.execute(options)
            end
          end
        end
      end
    end
  end
end