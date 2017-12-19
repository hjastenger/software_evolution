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
        { this.props.loc }
      </div>
    );
  }
}

export default Card;
