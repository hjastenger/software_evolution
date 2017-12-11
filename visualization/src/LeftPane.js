import React, { Component } from 'react';
import File from './File';
import Code from './Code';

class LeftPane extends Component {
  render() {
    let json = {
      files: [
        {
          // TODO: Remove "content" as this should be read from file
          loc: 'file_one.jpg',
          content: 'def henk; binding.pry; end',
          methods: [
            {
              name: 'one()',
              fromLine: 0,
              toLine: 10,
              original: true
              // dupLocs: ["path/to/file_two.jpg", "path/to/file_three.jpg"]
            },
            {
              name: 'two()',
              fromLine: 0,
              toLine: 10,
              original: true
              // dupLocs: ["path/to/file_two.jpg", "path/to/file_three.jpg"]
            },
          ]
        }
      ]
    }

    return (
      <div className="left-pane">
        <Code />
        { json.files.map((file) => <File key={ file.loc } file={ file } />) }
      </div>
    );
  }
}

export default LeftPane;
