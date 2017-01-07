require 'active_record'
require 'keychain'

require 'piggy_cash/version.rb'

# Core
require 'piggy_cash/core/keychain.rb'
require 'piggy_cash/core/database_connection.rb'

# Core/Importer
require 'piggy_cash/core/importer/base.rb'
require 'piggy_cash/core/importer/ingdiba.rb'
require 'piggy_cash/core/recognizer/tags.rb'

# CLI
require 'piggy_cash/cli/base.rb'
require 'piggy_cash/cli/import.rb'
require 'piggy_cash/cli/setup.rb'
require 'piggy_cash/cli/validate/saldo.rb'
require 'piggy_cash/cli/serve/api.rb'
require 'piggy_cash/cli/recognize/tags.rb'

# API
require 'piggy_cash/api/controllers/application_controller.rb'
require 'piggy_cash/api/controllers/accounts_controller.rb'
require 'piggy_cash/api/app.rb'

# Models
require 'piggy_cash/models/account.rb'
require 'piggy_cash/models/booking_entry.rb'
require 'piggy_cash/models/booking_entry_query.rb'
require 'piggy_cash/models/evaluated_booking_entry.rb'
require 'piggy_cash/models/tag.rb'
require 'piggy_cash/models/booking_entry_tag_recognizer.rb'
