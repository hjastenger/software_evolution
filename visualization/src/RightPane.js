import React, { Component } from 'react';
import Card from './Card';
import Code from './Code';

class RightPane extends Component {
  constructor(props) {
    super(props);

    this.state = {
      dupLocs: [],
      selected: {
        method: {},
        loc: null
      }
    }
  }

  componentWillReceiveProps(newProps) {
    this.setState({
      dupLocs: newProps.dupLocs
    });
  }

  changeRightSelected(props) {
    this.setState({
      selected: {
        method: props.method,
        loc: props.loc
      }
    });
  }

  isNotEmpty(obj) {
    return Object.keys(obj).length > 0 && obj.constructor === Object
  }

  render() {
    return (
      <div className="right-pane">
        { this.isNotEmpty(this.state.selected) ? <Code selected={this.state.selected} color="#ff788b" /> : <div /> }
        <h2 className='duplication-header'>Duplication</h2>
        { this.state.dupLocs.map((method) => <Card key={ method.name } method={ method } loc={method.loc} changeHook={this.changeRightSelected.bind(this)} />)}
      </div>
    );
  }
}

export default RightPane;
