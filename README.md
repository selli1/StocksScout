# StocksScout

A simple stock app that pulls from the Polygon.io API

## Description

The StocksScout app consists of 4 major screens. Landing on the users "My stocks" (watchlist) screen, the user can select a row to be taken to the dtails screen for that stock which displays a chart ad some additional data.  Additionaly from the "My stocks" screen, the user can select the menu button to be taken to the "Edit my stocks" list. From here the user can swipe to delete thier saved stocks or select the plus button to add a stock via the "Add a stock" (ticker search) screen. On this screen stocks are searchable by both ticker symbol and company name.

## Limitations

The free tier of the Polygon.io has some limitations that needed to be designed around. Firstly, it does not provide real time or even delayed stock price data. As such the app relies on historical data from the previous close. In addition the free tier says that it is limited to a maximum of 5 network calls per minute. 

## Design Considerations

Due to the limitations mentioned above, several design conseiderations were made to attempt to limit network calls, store data, and handle errors. One of the first examples of this is the ability to search for tickers to add to your watch list.  As one of the requirements was for the ticker results to autocomplete on search and this would use a network call for every new character typed, I decided to pull down all the ticker info at startup and store in SwiftData to query for there. If this hits a limit and fails, the currently place is saved via the 'nextURL' and will be returned to upon next startup. Additionally messaging is provided on the search screen to inform users if the tickes have not yet been fully poulated. It is currently set to update ticker results once a week, but this could possibly be further optimized.

SwiftData is also used pretty extensively to store stock data for the users saved watchlist stocks. This means the user will at least see older saved data in the case that they are hitting thier API limits. Also when a network call does fail due to the limits the user is notified with an alert.
