import React, { Component } from 'react';
import Card from './Card';
// import Code from './Code';
// import File from './File';

class RightPane extends Component {
  constructor(props) {
    super(props);

    this.state = {
      dupLocs: [],
    }
  }

  componentWillReceiveProps(newProps) {
    console.log(newProps);
    this.setState({
      dupLocs: newProps.dupLocs
    });
  }

  render() {
    return (
      <div className="right-pane">
        { this.state.dupLocs.map((method) => <Card key={ method.name } method={ method } loc={method.loc} />)}
      </div>
    );
  }
}

export default RightPane;
