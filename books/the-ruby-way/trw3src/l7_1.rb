def nth_wday(n, wday, month, year)
  if (!n.between? 1,5) or
     (!wday.between? 0,6) or
     (!month.between? 1,12)
    raise ArgumentError, "Invalid day or date"
  end
  t = Time.local year, month, 1
  first = t.wday
  if first == wday
    fwd = 1
  elsif first < wday
    fwd = wday - first + 1
  elsif first > wday
    fwd = (wday+7) - first + 1
  end
  target = fwd + (n-1)*7
  begin
    t2 = Time.local year, month, target
  rescue ArgumentError
    return nil
  end
  if t2.mday == target
    t2
  else 
    nil
  end 
end
