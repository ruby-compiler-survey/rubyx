require "parfait"
require "virtual/machine"
#if we are in the ruby run-time / generating an executable
require "virtual/positioned"
require "virtual/padding"
require "virtual/parfait_adapter"

require "phisol/compiler"
require "virtual/instruction"
require "virtual/method_source"
require "virtual/slots/slot"
require "virtual/type"
# the passes _are_ order dependant
require "virtual/passes/minimizer"
require "virtual/passes/collector"
require "virtual/passes/enter_implementation"


class Fixnum
  def fits_u8?
    self >= 0 and self <= 255
  end
end
