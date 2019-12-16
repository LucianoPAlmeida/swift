// RUN: %target-build-swift -typecheck %s -Xfrontend -verify
// REQUIRES: executable_test
// REQUIRES: OS=macosx

import CoreServices

func testFSEventStreamRef(stream: FSEventStreamRef) {
  // FIXME: These should be distinct types, constructible from one another.
  // works by coincidence because both are currently OpaquePointer 
  _ = stream as ConstFSEventStreamRef // expected-warning {{redundant cast from 'FSEventStreamRef' (aka 'OpaquePointer') to 'ConstFSEventStreamRef' (aka 'OpaquePointer') has no effect}} {{14-39=}}
  _ = ConstFSEventStreamRef(stream) // expected-error {{no exact matches in call to initializer}}

  // This is not a CF object.
  FSEventStreamRetain(stream) // no-warning
  FSEventStreamRelease(stream)

  let _: AnyObject = stream // expected-error {{value of type 'FSEventStreamRef' (aka 'OpaquePointer') does not conform to specified type 'AnyObject'}}
}
