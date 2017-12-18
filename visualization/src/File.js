import React, { Component } from 'react';
import Card from './Card';

class File extends Component {
  render() {
    return (
      <React.Fragment>
        <h2 className='file-header'>{ this.props.file.loc }</h2>
        { this.props.file.methods.map((method) =>
            <Card
              key={ method.name }
              inLeftPane={true}
              method={ method }
              loc={this.props.file.loc}
              changeHook={this.props.changeHook}
              changeDupLocs={this.props.changeDupLocs} />
        )}
      </React.Fragment>
    );
  }
}

export default File;
