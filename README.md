# ParentVUE-Gem

Provides library to sign into ParentVUE, a web site provided to families of the
San Francisco Unified School District (SFUSD), and interact with it.

The long term goal is to create an Alexa app so we can check assignments, etc.

Currently though it is just a library and a simple executable script. 

Example install and usage of executable:
```
$ gem install parentvue
Successfully installed parentvue-0.1.0
Parsing documentation for parentvue-0.1.0
Installing ri documentation for parentvue-0.1.0
Done installing documentation for parentvue after 0 seconds
1 gem installed

$ parentvue list -U frankchu -P 12galaxies

[{:name=>"Aila", :id=>"20111337", :school_name=>"Norton (Emperor) ES"},
 {:name=>"Tesla", :id=>"20071337", :school_name=>"Riley (Boots) HS"}]
```

If you want to add any functionality and make PRs, you'll want to 
- go to the real page in your browser
- save the source to a file under `spec/fixtures/html` (at some point be sure to change any personally identifiable information)
- create a spec that stubs that page request and lays out data scraping expectations
- update the service code to make the new spec pass (and all old specs, use `make test`)
- make sure `make lint` passes as well
- make a PR

TODO
- make a proper Students model
- once school year starts and there are actual assignments, extend to get this information
- Make it so you're not entering the password on the command line for the executable
- rename `master` branch (github default) to `main`
- set up a CI account for it
