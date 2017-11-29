# Software Evolution
Repository for the course Software Evolution

1. Jovan Maric, 10443762
2. Hector Stenger, 10398872

# How to run

## Series 1

1. Start Rascal REPL in root dir: `java -Xmx1G -Xss32m -jar <rascal_jar_location>`
2. `import Runner;` to import the general runner module.
  1. Run metrics on given path eg: `runMetrics(|cwd:///path/to/directory|);`
  2. Run metrics on HSQLDB: `runHSQL();`
  3. Run metrics on SmallSQL: `runSmall();`
  4. Run tests: `runTests();`

# notes:
1. re-importing a spec after changing an imported module in that spec does not
   reload the dependencies the spec has. Rascal does this in a shallow way. To
   ensure that the specs are using the updated version of the dependency
   explicitly re-import the changed module.