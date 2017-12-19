import React, { Component } from 'react';

class Card extends Component {
  constructor(props) {
    super(props);

    this.state = {
      lines: this.props.lines,
      loc: this.props.loc,
      changeHook: this.props.changeHook,
      inLeftPane: this.props.inLeftPane || false
    }
  }

  openCodeViewer() {
    this.state.changeHook(this.state);
  }

  render() {
    return (
      <div className="card" onClick={() => { this.openCodeViewer() }}>
        { this.state.loc + "(" + this.state.lines[0] + ", " + this.state.lines.slice(-1)[0] + ")"}
      </div>
    );
  }
}

export default Card;
