import React, { Component } from 'react';
import SyntaxHighlighter from 'react-syntax-highlighter';
import { docco } from 'react-syntax-highlighter/styles/hljs';


class Code extends Component {


  constructor(props) {
    super(props);

    this.state = {
      display: true,
      loc: 'path/to/file.jpg',
      fromLine: 1,
      toLine: 2
    }
  }

  toggleDisplay() {
    this.setState({ display: !this.state.display });
  }

  range(start, end) { return [...Array(1+end-start).keys()].map(v => start+v) }

  render() {
    let henk =  `flex: 49.9%;
        flex-direction: row;
        flex-wrap: wrap;
        height: 100vh;`;

    return (
      <div className="code-content" style={{display: this.state.display ? 'block' : 'none'}}>
        <SyntaxHighlighter
          language='javascript'
          style={docco}
          wrapLines={true}
          showLineNumbers={true}
          lineStyle={lineNumber => {
            if (this.range(this.state.fromLine, this.state.toLine).includes(lineNumber)) {
              return { backgroundColor: 'red' };
            }
          }}
        >
          {henk}
        </SyntaxHighlighter>;
        <div className='close-button' onClick={this.toggleDisplay.bind(this)}>X</div>
      </div>
    );
  }
}

export default Code;
