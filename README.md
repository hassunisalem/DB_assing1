# DB_assing1



## Strategy for inhertance

i went with a single-table approch, since i saw it as the fastes solution for this task,
because it needs more simple qurries: no need for joins. Another pro is that it is the fastest at
getting the data of all the strategies.

Cons: unrelevant data may occour, no data normalization    


## (lack of) Implementation

The ER-Diagram showcases how i'd normally desing and populate the many-to-many reltations. Since this was tougth in the Datamatikker-education
and because of lack of time, i choose to focus on the new materials such as *views* and *procedures*.

also, when adding other *species* than *cat* or *dog* to the single table, i'd implement that exat species in the enum type *Dtype*, but went with *other* 
to save time.