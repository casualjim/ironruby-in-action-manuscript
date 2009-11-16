# require our core extensions first
require 'lib/core_ext/array'

# load the Gemtris.dll containing our CLR object shells
require 'bin/Gemtris.dll'

require 'lib/gemtris/game_manager'
require 'lib/gemtris/board'
require 'lib/gemtris/gem'
require 'lib/gemtris/shape'