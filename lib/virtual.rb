require "parfait"
require "virtual/machine"

require "virtual/compiler"
require "virtual/instruction"
require "virtual/compiled_method_info"
require "virtual/slots/slot"
require "virtual/type"
# the passes _are_ order dependant
require "virtual/passes/send_implementation"
require "virtual/passes/get_implementation"
require "virtual/passes/enter_implementation"
require "virtual/passes/frame_implementation"

Sof::Volotile.add(Virtual::Block ,  [:method])
Sof::Volotile.add(Virtual::CompiledMethodInfo ,  [:current])
