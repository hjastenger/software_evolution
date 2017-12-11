import React, { Component } from 'react';
import File from './File';
import Code from './Code';

class LeftPane extends Component {
  constructor(props) {
    super(props);

    this.state = {
      files: this.props.state.files
    }
  }

  render() {
    console.log(this.state);
    return (
      <div className="left-pane">
        <Code selected={this.state.selected} />
        { this.state.files.map((file) => <File key={ file.loc } file={ file } />) }
      </div>
    );
  }
}

export default LeftPane;
