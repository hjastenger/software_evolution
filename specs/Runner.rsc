module specs::Runner

import specs::comments::MultilineComments;
import specs::comments::SinglelineComments;
import specs::comments::Whitespace;

import assignments::helpers::Defaults;

public void runner() {
  loc fixtures = |cwd:///specs/fixtures|;

  whitespaceRunner(fixtures);
  singlelineRunner(fixtures);
  multilineRunner(fixtures);
}
