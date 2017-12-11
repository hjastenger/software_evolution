import React, { Component } from 'react';

class Card extends Component {
  constructor(props) {
    super(props);

    this.state = {
      method: this.props.method,
      loc: this.props.loc,
      changeHook: this.props.changeHook
    }
  }

  openCodeViewer() {
    this.state.changeHook(this.state);
  }

  render() {
    return (
      <div className="card" onClick={this.openCodeViewer.bind(this)}>{ this.props.method.name }</div>
    );
  }
}

export default Card;
