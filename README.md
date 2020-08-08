# ParentVUE-Gem

Provides library to sign into ParentVUE, a web site provided to families of the
San Francisco Unified School District (SFUSD), and interact with it.

The long term goal is to create an Alexa app so we can check assignments, etc.

I figured I might as well make it a gem too. Currently though it is
just a library and an example script. Once some more basic functionality is
supported I'll figure out the gem part.

The script works like this:
```
bundle exec ruby parentvue_script.rb list -U frankchu -P 12galaxies                             1226ms  Sat Aug  8 11:57:30 2020
[{:name=>"Aila", :id=>"20111337", :school_name=>"Norton (Emperor) ES"},
 {:name=>"Tesla", :id=>"20071337", :school_name=>"Riley (Boots) HS"}]
```

If you want to add any functionality and make PRs, you'll want to 
- go to the real page in your browser
- save the source to a file under `spec/fixtures/html`
- create a spec that stubs that page request and lays out data scraping expectations
- update the service code to make the new spec pass (and all old specs, use `make test`)
- make sure `make lint` passes as well
- make a PR

TODO
- make a proper Students model
- once school year starts and there are actual assignments, extend to get this information
- rename `master` branch (github default) to `main`
- set up a CI account for it
- Actually turn it into a gem
