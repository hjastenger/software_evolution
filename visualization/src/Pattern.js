import React, { Component } from 'react';
import SyntaxHighlighter from 'react-syntax-highlighter';
import { docco } from 'react-syntax-highlighter/styles/hljs';

class Pattern extends Component {
  changeLocs() {
    this.props.changeDupLocs(this.props.pattern.locations);
  }

  render() {
    return (
      <React.Fragment>
        <h2 className='file-header'>{ this.props.pattern.matches } Matches</h2>

        <div className="card" onClick={() => { this.changeLocs() }}>
          <SyntaxHighlighter
            className='prettyprint lang-java'
            language='javascript'
            style={docco}
            wrapLines={true}
            showLineNumbers={true}
          >
            { this.props.pattern.pattern.join("\n") }
          </SyntaxHighlighter>
        </div>
      </React.Fragment>
    );
  }
}

export default Pattern;
