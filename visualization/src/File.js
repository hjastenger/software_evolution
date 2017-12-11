import React, { Component } from 'react';
import Card from './Card';

class File extends Component {
  constructor(props) {
    super(props);

    this.state = {
      file: this.props.file,
      changeHook: this.props.changeHook
    }
  }

  render() {
    return (
      <React.Fragment>
        <h2>{ this.state.file.loc }</h2>
        { this.state.file.methods.map((method) => <Card key={ method.name } method={ method } loc={this.state.file.loc} changeHook= {this.state.changeHook} />) }
      </React.Fragment>
    );
  }
}

export default File;
