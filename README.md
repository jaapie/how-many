# How Many?

`how-many` is a small Ruby CLI script that answers questions like: "How many
seconds are there in a year", and many more.

I created this script so that when I wanted to `shutdown -r -t ?` a server in
8h and 23 minutes I didn't have to ask Google or Spotlight.

It has a simple, natural language style interface, with some output formatting
options. For example:

```
$ how-many seconds in 1 year
31536025.919999998
$ hay-many weeks in 1 month
4.3452416666666664
```

The script understands the following time units:

   - seconds
   - minutes
   - hours
   - days
   - weeks
   - fortnights
   - months
   - years

By default, results will be displayed as floating point numbers, however you
can pass the `-t` option (use the -h or --help option for more information) to
choose integer, in which case the number is rounded up.

It uses the definition that a year is 52.1429 weeks. There are `24.0072` hours
in `0.1429` weeks.

## Operations
`how-many` will understand two operations: `in` and `till`. It currently only
understands `in`. That means you can ask it how many of one unit will fit into
another. I am implementing the `till` function next. You will he able to ask:

```
$how-many seconds till 10pm
```
or
```
$how-many days till 2020-02-20
```

## Contributing
I welcome comments, criticisms, praise, pointers to tools that already did
this, and most of all contributions in the form of pull-requests.

## Author
`how-many` was written by me, Jacob Degeling, in my spare time. I am a School
IT Manager whose first love in the computer world was programming.

`:wq`
