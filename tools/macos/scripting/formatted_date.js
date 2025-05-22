ObjC.import('Cocoa')
rightNow = $.NSDate.date
dtFormatter = $.NSDateFormatter.alloc.init
dtFormatter.dateStyle = $.NSDateFormatterFullStyle
dtFormatter.timeStyle = $.NSDateFormatterMediumStyle

formattedDate = dtFormatter.stringFromDate(rightNow)
console.log(ObjC.unwrap(formattedDate));
