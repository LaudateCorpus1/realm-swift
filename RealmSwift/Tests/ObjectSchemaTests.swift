////////////////////////////////////////////////////////////////////////////
//
// Copyright 2015 Realm Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
////////////////////////////////////////////////////////////////////////////

import XCTest
import RealmSwift

class ObjectSchemaTests: TestCase {
    var objectSchema: ObjectSchema!

    var swiftObjectSchema: ObjectSchema {
        return try! Realm().schema["SwiftObject"]!
    }

    func testProperties() {
        let objectSchema = swiftObjectSchema
        let propertyNames = objectSchema.properties.map { $0.name }
        XCTAssertEqual(propertyNames,
                       ["boolCol", "intCol", "intEnumCol", "floatCol", "doubleCol",
                        "stringCol", "binaryCol", "dateCol", "decimalCol",
                        "objectIdCol", "objectCol", "uuidCol", "arrayCol", "setCol"]
        )
    }

    // Cannot name testClassName() because it interferes with the method on XCTest
    func testClassNameProperty() {
        let objectSchema = swiftObjectSchema
        XCTAssertEqual(objectSchema.className, "SwiftObject")
    }

    func testObjectClass() {
        let objectSchema = swiftObjectSchema
        XCTAssertTrue(objectSchema.objectClass === SwiftObject.self)
    }

    func testPrimaryKeyProperty() {
        let objectSchema = swiftObjectSchema
        XCTAssertNil(objectSchema.primaryKeyProperty)
        XCTAssertEqual(try! Realm().schema["SwiftPrimaryStringObject"]!.primaryKeyProperty!.name, "stringCol")
    }

    func testDescription() {
        let objectSchema = swiftObjectSchema
        let expected =
            "SwiftObject {\n" +
            "    boolCol {\n" +
            "        type = bool;\n" +
            "        indexed = NO;\n" +
            "        isPrimary = NO;\n" +
            "        array = NO;\n" +
            "        set = NO;\n" +
            "        optional = NO;\n" +
            "    }\n" +
            "    intCol {\n" +
            "        type = int;\n" +
            "        indexed = NO;\n" +
            "        isPrimary = NO;\n" +
            "        array = NO;\n" +
            "        set = NO;\n" +
            "        optional = NO;\n" +
            "    }\n" +
            "    intEnumCol {\n" +
            "        type = int;\n" +
            "        indexed = NO;\n" +
            "        isPrimary = NO;\n" +
            "        array = NO;\n" +
            "        set = NO;\n" +
            "        optional = NO;\n" +
            "    }\n" +
            "    floatCol {\n" +
            "        type = float;\n" +
            "        indexed = NO;\n" +
            "        isPrimary = NO;\n" +
            "        array = NO;\n" +
            "        set = NO;\n" +
            "        optional = NO;\n" +
            "    }\n" +
            "    doubleCol {\n" +
            "        type = double;\n" +
            "        indexed = NO;\n" +
            "        isPrimary = NO;\n" +
            "        array = NO;\n" +
            "        set = NO;\n" +
            "        optional = NO;\n" +
            "    }\n" +
            "    stringCol {\n" +
            "        type = string;\n" +
            "        indexed = NO;\n" +
            "        isPrimary = NO;\n" +
            "        array = NO;\n" +
            "        set = NO;\n" +
            "        optional = NO;\n" +
            "    }\n" +
            "    binaryCol {\n" +
            "        type = data;\n" +
            "        indexed = NO;\n" +
            "        isPrimary = NO;\n" +
            "        array = NO;\n" +
            "        set = NO;\n" +
            "        optional = NO;\n" +
            "    }\n" +
            "    dateCol {\n" +
            "        type = date;\n" +
            "        indexed = NO;\n" +
            "        isPrimary = NO;\n" +
            "        array = NO;\n" +
            "        set = NO;\n" +
            "        optional = NO;\n" +
            "    }\n" +
            "    decimalCol {\n" +
            "        type = decimal128;\n" +
            "        indexed = NO;\n" +
            "        isPrimary = NO;\n" +
            "        array = NO;\n" +
            "        set = NO;\n" +
            "        optional = NO;\n" +
            "    }\n" +
            "    objectIdCol {\n" +
            "        type = object id;\n" +
            "        indexed = NO;\n" +
            "        isPrimary = NO;\n" +
            "        array = NO;\n" +
            "        set = NO;\n" +
            "        optional = NO;\n" +
            "    }\n" +
            "    objectCol {\n" +
            "        type = object;\n" +
            "        objectClassName = SwiftBoolObject;\n" +
            "        linkOriginPropertyName = (null);\n" +
            "        indexed = NO;\n" +
            "        isPrimary = NO;\n" +
            "        array = NO;\n" +
            "        set = NO;\n" +
            "        optional = YES;\n" +
            "    }\n" +
            "    uuidCol {\n" +
            "        type = uuid;\n" +
            "        indexed = NO;\n" +
            "        isPrimary = NO;\n" +
            "        array = NO;\n" +
            "        set = NO;\n" +
            "        optional = NO;\n" +
            "    }\n" +
            "    arrayCol {\n" +
            "        type = object;\n" +
            "        objectClassName = SwiftBoolObject;\n" +
            "        linkOriginPropertyName = (null);\n" +
            "        indexed = NO;\n" +
            "        isPrimary = NO;\n" +
            "        array = YES;\n" +
            "        set = NO;\n" +
            "        optional = NO;\n" +
            "    }\n" +
            "    setCol {\n" +
            "        type = object;\n" +
            "        objectClassName = SwiftBoolObject;\n" +
            "        linkOriginPropertyName = (null);\n" +
            "        indexed = NO;\n" +
            "        isPrimary = NO;\n" +
            "        array = NO;\n" +
            "        set = YES;\n" +
            "        optional = NO;\n" +
            "    }\n" +
            "}"

        XCTAssertEqual(objectSchema.description, expected.replacingOccurrences(of: "    ", with: "\t"))
    }

    func testSubscript() {
        let objectSchema = swiftObjectSchema
        XCTAssertNil(objectSchema["noSuchProperty"])
        XCTAssertEqual(objectSchema["boolCol"]!.name, "boolCol")
    }

    func testEquals() {
        let objectSchema = swiftObjectSchema
        XCTAssert(try! objectSchema == Realm().schema["SwiftObject"]!)
        XCTAssert(try! objectSchema != Realm().schema["SwiftStringObject"]!)
    }
}
