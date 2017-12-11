import React, { Component } from 'react';
import SyntaxHighlighter from 'react-syntax-highlighter';
import { docco } from 'react-syntax-highlighter/styles/hljs';


class Code extends Component {
  constructor(props) {
    super(props);

    this.state = {
      selected: this.props.selected
    }
  }

  toggleDisplay() {
    this.setState({ display: !this.state.display });
  }

  range(start, end) { return [...Array(1+end-start).keys()].map(v => start+v) }

  render() {
    if(this.state.selected) {
      return (
        <div className="code-content" style={{display: this.state.display ? 'block' : 'none'}}>
        <div className='title-pane'>
        <div className='title'>{this.state.selected.loc}</div>
        <div className='close-button' onClick={this.toggleDisplay.bind(this)}>X</div>
        </div>

        <SyntaxHighlighter
          language='javascript'
          style={docco}
          wrapLines={true}
          showLineNumbers={true}
          lineStyle={lineNr => {
            if (this.range(this.state.selected.fromLine, this.state.selected.toLine).includes(lineNr)) {
              return { backgroundColor: 'red' };
            }
          }}
        >
        {this.state.selected.content}
        </SyntaxHighlighter>
        </div>
      );
    } else {
      return(<div />);
    }
  }
}

export default Code;
