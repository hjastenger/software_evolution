import React, { Component } from 'react';
import Card from './Card';

class File extends Component {
  render() {
    return (
      <React.Fragment>
        <h2>{ this.props.file.loc }</h2>
        { this.props.file.methods.map((method) => <Card key={ method.name } method={ method } />) }
      </React.Fragment>
    );
  }
}

export default File;
