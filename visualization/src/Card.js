import React, { Component } from 'react';

class Card extends Component {
  constructor(props) {
    super(props);

    this.state = {
      method: this.props.method,
      loc: this.props.loc,
      changeHook: this.props.changeHook,
      changeDupLocs: this.props.changeDupLocs,
      inLeftPane: this.props.inLeftPane || false
    }
  }

  openCodeViewer() {
    this.state.changeHook(this.state);

    if(this.state.inLeftPane) {
      this.state.changeDupLocs(this.props.method.dupLocs);
    }
  }

  render() {
    return (
      <div className="card" onClick={() => { this.openCodeViewer() }}>
        { this.props.method.name }
      </div>
    );
  }
}

export default Card;
