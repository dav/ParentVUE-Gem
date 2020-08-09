# ParentVUE-Gem

Provides library to interact with [ParentVUE](https://portal.sfusd.edu/), 
a web site that the
San Francisco Unified School District (SFUSD) uses to communicate with families.

This consists largely of providing a high level DSL to navigate the web site, and
is implemented using the [Mechanize gem](https://github.com/sparklemotion/mechanize).

The long term goal is to create an Alexa app so we can check assignments, attendance, 
grades, etc.

Currently though it is just a library and a simple executable script. 

Example install and usage of executable:
```
$ gem install parentvue
Successfully installed parentvue-0.1.0

$ parentvue list -U frankchu -P 12galaxies

[{:name=>"Aila", :id=>"20111337", :school_name=>"Norton (Emperor) ES"},
 {:name=>"Tesla", :id=>"20071337", :school_name=>"Riley (Boots) HS"}]
```

If you want to add any functionality and make PRs, you'll want to 
- go to the real page in your browser
- save the source to a file under `spec/fixtures/html` (before committing be sure to change any personally identifiable information)
- create a spec that stubs that page request and lays out data scraping expectations (examples exist)
- update the service code to make the new spec pass (and all old specs, use `make test`)
- make sure `make lint` passes as well
- make a PR

TODO
- make a proper Students model
- once school year starts and there are actual assignments, extend to get this information
- Make it so you're not entering the password on the command line for the executable
- rename `master` branch (github default) to `main`
