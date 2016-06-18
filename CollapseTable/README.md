# Collapsing Tables
I wanted to see how easy or hard it would be to make a UITableView collapse and expand sections. Turns out it was pretty easy with built in insert and remove animations for cells.

### How Does It Work?
Create a basic `UITableView` along with a `UITableViewDataSource` and `UITableViewDelegate`.

#### UITableViewDataSource
`numberOfRowsInSection`
We need to track which sections are collapsed, and return 0 or the actual number of cells. I store a `[Bool]` (array of booleans) and just flip the Bool at each section index. I've seen people use a `NSSet` and other creative solutions as well.

`willDisplayHeaderView`
Since I'm not using a custom header view (and just returning titles), I add a `UITapGestureRecognizer` to the built-in `UITableViewHeaderFooterView` here so that tapping the section header will expand/collapse.

#### Custom Code
One last bit of work: handling the collapse or expand. I used the `deleteRowsAtIndexPaths` and `insertRowsAtIndexPaths` on `UITableView` to get some nice animation. There are a few different options for the `withRowAnimation` parameter: I liked Bottom, but try them all out.

Before you make any changes to the table's cells, remember to start and end with `beginUpdates` and `endUpdates` on the `UITableView`.

That's all it takes to get a basic `UITableView` with collapsing sections.

### Other Ideas
**Want to have a custom section header?** Try the `viewForHeaderInSection` method in `UITableViewDataSource`.