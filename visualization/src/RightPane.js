import React, { Component } from 'react';
import Card from './Card';
// import Code from './Code';
// import File from './File';

class RightPane extends Component {
  constructor(props) {
    super(props);

    this.state = {
      dupLocs: [],
      visibility: false
    }
  }

  componentWillReceiveProps(newProps) {
    this.setState({
      dupLocs: newProps.dupLocs,
      visibility: true
    });
  }

  render() {
    return (
      <div className="right-pane">
        <h2 className='duplication-header'>Duplication</h2>
        <div className="right-panel-cards" style={{display: this.state.visibility ? 'block' : 'none'}}>
          { this.state.dupLocs.map((method) => <Card key={ method.name } method={ method } loc={method.loc} />)}
        </div>
      </div>
    );
  }
}

export default RightPane;

// <Code selected={this.state.selected} color="#ff788b"/>
