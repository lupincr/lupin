require "../lupin"
require "../../../../lupinfile.cr"
if ARGV.size > 0
  Lupin.run(ARGV)
else
  Lupin.run_default
end
