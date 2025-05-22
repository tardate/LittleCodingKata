set quotes to { "It is never too late to be what you might have been.— George Eliot (Mary Ann Evans)", "Not all those who wander are lost. — J.R.R. Tolkien, The Fellowship of the Ring", "There is no friend as loyal as a book. — Ernest Hemingway", "We are all in the gutter, but some of us are looking at the stars. — Oscar Wilde, Lady Windermere’s Fan" }

set randomIndex to random number from 1 to (count of quotes)
set dailyQuote to item randomIndex of quotes
display dialog dailyQuote buttons {"Thanks!"} default button "Thanks!"
