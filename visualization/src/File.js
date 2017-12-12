import React, { Component } from 'react';
import Card from './Card';

class File extends Component {
  constructor(props) {
    super(props);

    this.state = {
      file: this.props.file,
      changeHook: this.props.changeHook,
      changeDupLocs: this.props.changeDupLocs
    }
  }

  render() {
    return (
      <React.Fragment>
        <h2 className='file-header'>{ this.state.file.loc }</h2>
        { this.state.file.methods.map((method) => <Card key={ method.name } inLeftPane={true} method={ method } loc={this.state.file.loc} changeHook={this.state.changeHook} changeDupLocs={this.state.changeDupLocs} />) }
      </React.Fragment>
    );
  }
}

export default File;
