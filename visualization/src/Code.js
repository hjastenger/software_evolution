import React, { Component } from 'react';
import SyntaxHighlighter from 'react-syntax-highlighter';
import { docco } from 'react-syntax-highlighter/styles/hljs';

class Code extends Component {
  constructor(props) {
    super(props);

    this.state = {
      name: null,
      loc: null,
      content: '<div />',
      fromLine: null,
      toLine: null,
      display: false,
      color: this.props.color
    };
  }

  componentWillReceiveProps(newProps) {
    this.setState({
      name: newProps.selected.method.name,
      loc: newProps.selected.loc,
      fromLine: newProps.selected.method.fromLine,
      toLine: newProps.selected.method.toLine,
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
      this.state.name ?
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
              if (this.range(this.state.fromLine, this.state.toLine).includes(lineNr)) {
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
