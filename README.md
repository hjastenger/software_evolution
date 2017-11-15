# software_evolution
Repository for the course Software Evolution

1. Jovan Maric, 10443762
2. Hector Stenger, 10398872

# how to run

1. start Rascal REPL in root dir: `java -Xmx1G -Xss32m -jar <rascal_jar_location>`
2. import spec runner i.e. `import specs::comments::MultineComments;` 
3. invoke runner i.e. `runner();`

# notes:
1. re-importing a spec after changing an imported module in that spec does not
   reload the dependencies the spec has. Rascal does this in a shallow way. To
   ensure that the specs are using the updated version of the dependency
   explicitly re-import the changed module. 
