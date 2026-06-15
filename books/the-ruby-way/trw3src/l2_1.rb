class String
  alias old_compare <=>
  def <=>(other)
    a = self.dup
    b = other.dup
    # Remove punctuation
    a.gsub!(/[\,\.\?\!\:\;]/, "")
    b.gsub!(/[\,\.\?\!\:\;]/, "")
    # Remove initial articles
    a.gsub!(/^(a |an |the )/i, "")
    b.gsub!(/^(a |an |the )/i, "")
    # Remove leading/trailing whitespace
    a.strip!
    b.strip!
    # Use the old <=>
    a.old_compare(b)
  end 
end

title1 = "Calling All Cars"
title2 = "The Call of the Wild"

# Ordinarily this would print "yes"
if title1 < title2
  puts "yes"
else
  puts "no"         # But now it prints "no"
end
