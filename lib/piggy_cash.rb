require 'active_record'
require 'keychain'

require 'piggy_cash/version.rb'

# Core
require 'piggy_cash/core/keychain.rb'
require 'piggy_cash/core/database_connection.rb'
require 'piggy_cash/core/recognizer/tags.rb'
require 'piggy_cash/core/revealer/untagged.rb'
require 'piggy_cash/core/assigner/tag.rb'

# Core/Selection
require 'piggy_cash/core/selection/account.rb'
require 'piggy_cash/core/selection/booking_entry.rb'
require 'piggy_cash/core/selection/booking_entry_query.rb'
require 'piggy_cash/core/selection/tag.rb'

# Core/Importer
require 'piggy_cash/core/importer/base.rb'
require 'piggy_cash/core/importer/ingdiba.rb'

# CLI Commands
require 'piggy_cash/cli/commands/api.rb'
require 'piggy_cash/cli/commands/import.rb'
require 'piggy_cash/cli/commands/query.rb'
require 'piggy_cash/cli/commands/setup.rb'
require 'piggy_cash/cli/commands/tags.rb'
require 'piggy_cash/cli/commands/validate.rb'
require 'piggy_cash/cli/commands/stats.rb'

# CLI
require 'piggy_cash/cli/base.rb'
require 'piggy_cash/cli/import.rb'
require 'piggy_cash/cli/setup.rb'
require 'piggy_cash/cli/validate/saldo.rb'
require 'piggy_cash/cli/api/serve.rb'
require 'piggy_cash/cli/tags/recognize.rb'
require 'piggy_cash/cli/tags/reveal/untagged.rb'
require 'piggy_cash/cli/query/assign/tags.rb'
require 'piggy_cash/cli/query/split.rb'
require 'piggy_cash/cli/stats/saldo.rb'


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
