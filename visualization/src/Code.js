import React, { Component } from 'react';
import SyntaxHighlighter from 'react-syntax-highlighter';
import { docco } from 'react-syntax-highlighter/styles/hljs';

class Code extends Component {
  constructor(props) {
    super(props);

    this.state = {
      loc: null,
      content: '<div />',
      lines: null,
      display: false,
      color: this.props.color
    };
  }

  componentWillReceiveProps(newProps) {
    this.setState({
      loc: newProps.selected.loc,
      lines: newProps.selected.lines,
      display: true
    });

    fetch(newProps.selected.loc)
      .then((res) => res.text().then((text) => this.setState({ content: text })))
      .catch(() => console.warn("Couldn't fetch data"));
  }

  hide() {
    this.props.hideCallback();
  }

  range(start, end) { return [...Array(1+end-start).keys()].map(v => start+v) }

  render() {
    return (
      this.state.loc ?
        <div className="code-content" style={{display: this.state.display ? 'block' : 'none'}}>
          <div className='title-pane'>
            <div className='title'>{this.state.name}</div>
            <div className='close-button' onClick={this.hide.bind(this)}>x</div>
          </div>

          <SyntaxHighlighter
            language='javascript'
            style={docco}
            wrapLines={true}
            showLineNumbers={true}
            lineStyle={lineNr => {
              if (this.range(this.state.lines[0]+1, this.state.lines.slice(-1)[0]+1).includes(lineNr)) {
                return { backgroundColor: this.state.color };
              }
            }}
          >
            {this.state.content}
          </SyntaxHighlighter>
        </div>
      :
        <div />
      );
  }
}

export default Code;
