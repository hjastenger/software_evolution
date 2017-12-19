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

## Series 2
Series 2 is split into two parts: Clone detection and Visualization. Follow the
below steps to properly configure both components.

### Clone detection
To generate json data for the visualization part you need to do the following:
1. Start Rascal REPL in root dir: `java -Xmx1G -Xss32m -jar <rascal_jar_location>`
2. `import Runner;` to import the general runner module.
  1. Run clone detection tests: `runDuplicationTests()`
  2. Run clone detection on fixtures: `runDuplicationFixtures()`
  3. Run clone detection on SmallSQL: `runDuplicationSmallSQL();`
  4. Run clone detection on HSQLDB: `runDuplicationHSQL();`

### Visualization
To get the visualization working you need to fulfill the below steps. Keep in
mind that data has to be generated with the clone detection tool first.

The visualization works best on the chrome browser.

1. Install yarn first from https://yarnpkg.com/lang/en/docs/install/
2. Install dependencies
  1. cd into the visualization directory: `cd visualization`
  2. run: `yarn install`
3. When everything is installed:
  1. run the visualization with `yarn start`
  2. A local webserver will be spawned and exposed on http://localhost:3000.
  3. Visit http://localhost:3000 and enjoy

# notes:
1. We are running rascal with: `java -Xmx6G -Xss512M -jar path/to/rascal`
2. Generating a type-2 clone detection based JSON of hsqldb takes a lot of time
   therefore it isn't included in the library.
3. re-importing a spec after changing an imported module in that spec does not
   reload the dependencies the spec has. Rascal does this in a shallow way. To
   ensure that the specs are using the updated version of the dependency
   explicitly re-import the changed module.
