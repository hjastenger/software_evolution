import React, { Component } from 'react';
import File from './File';
import Code from './Code';

class LeftPane extends Component {
  constructor(props) {
    super(props);

    this.state = {
      files: this.props.state.files,
      selected: {},
      changeHook: this.props.changeHook
    }
  }

  componentWillReceiveProps(newProps) {
    this.setState({
      selected: newProps.state.leftSelected
    });
  }

  render() {
    return (
      <div className="left-pane">
        <Code selected={this.state.selected} color="#99ffaf" />
        { this.state.files.map((file) => <File key={ file.loc } file={ file } changeHook={this.state.changeHook} />) }
      </div>
    );
  }
}

export default LeftPane;
