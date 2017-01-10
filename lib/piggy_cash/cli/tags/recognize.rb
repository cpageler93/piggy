module PiggyCash
  module CLI
    module Tags
      class Recognize < Base
        def execute(options = {})
          ensure_valid_connection_in_keychain_item!

          PiggyCash::Core::Recognizer::Tags.recognize_tags_for_all_accounts
        end
      end
    end
  end
end
