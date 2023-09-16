Object subclass: Info [
    |actions names ops|

    Info class >> new [
        <category: 'instance creation'>
        |info|
        info := super new.
        info init.
        ^info
    ]

    init [
        <category: 'initialization'>

        actions := OrderedCollection new.
        names := OrderedCollection new.
        ops := OrderedCollection new.

        actions add: 'print'; add: 'count'; add: 'min'; add: 'max'; add: 'total'; add: 'avg'; yourself.
        names add: 'type'; add: 'area'; add: 'volume'; yourself.
        ops add: '=='; add: '!='; add: '>='; add: '<='; add: '>'; add: '<'; yourself.
    ]

    readFrom: file [
        |shapesFile shapes information infoOnShapes shapeName shapeString|
        "Opening the file for reading."
        shapesFile := FileStream open: file mode: #read.
        shapes := OrderedCollection new.

        [shapesFile atEnd] whileFalse: [
            "Grabs each line from the file until we run out of lines to grab."
            information := shapesFile nextLine.

            "Creates a new ordered collection with all of our shape info in it."
            infoOnShapes := OrderedCollection new.
            infoOnShapes := information subStrings.

            "shapeName is something like Cube#1 for example"
            shapeName := infoOnShapes at: 1.

            "shapeString is something like box for example"
            shapeString := infoOnShapes at: 2.

            (shapeString = 'box') ifTrue: [
                |myBox length width height|

                "Creates a new instance of the subclass Box."
                myBox := Box new.

                "Find and set the values to their respective
                variables and then convert the strings to floats."
                length := (infoOnShapes at: 3) asNumber.
                width := (infoOnShapes at: 4) asNumber.
                height := (infoOnShapes at: 5) asNumber.

                "Now call setters to populate our new Box instance."
                myBox setName: shapeName.
                myBox setLength: length.
                myBox setWidth: width.
                myBox setHeight: height.

                "Now we add our new shape to our shapes collection."
                shapes add: myBox; yourself.
            ].
            (shapeString = 'sphere') ifTrue: [
                |mySphere radius|

                "Creates a new instance of the subclass Sphere."
                mySphere := Sphere new.

                "Find and set the values to their respective
                variables and then convert the strings to floats."
                radius := (infoOnShapes at: 3) asNumber.

                "Now call setters to populate our new Sphere instance."
                mySphere setName: shapeName.
                mySphere setRadius: radius.

                "Now we add our new shape to our shapes collection."
                shapes add: mySphere; yourself.
            ].
            (shapeString = 'cylinder') ifTrue: [
                |myCylinder radius height|

                "Creates a new instance of the subclass Cylinder."
                myCylinder := Cylinder new.

                "Find and set the values to their respective
                variables and then convert the strings to floats."
                radius := (infoOnShapes at: 3) asNumber.
                height := (infoOnShapes at: 4) asNumber.

                "Now call setters to populate our new Cylinder instance."
                myCylinder setName: shapeName.
                myCylinder setRadius: radius.
                myCylinder setHeight: height.

                "Now we add our new shape to our shapes collection."
                shapes add: myCylinder; yourself.
            ].
            (shapeString = 'torus') ifTrue: [
                |myTorus small_radius big_radius|

                "Creates a new instance of the subclass Torus."
                myTorus := Torus new.

                "Find and set the values to their respective
                variables and then convert the strings to floats."
                small_radius := (infoOnShapes at: 3) asNumber.
                big_radius := (infoOnShapes at: 4) asNumber.

                "Now call setters to populate our new Torus instance."
                myTorus setName: shapeName.
                myTorus setSmallRadius: small_radius.
                myTorus setBigRadius: big_radius.

                "Now we add our new shape to our shapes collection."
                shapes add: myTorus; yourself.
            ].
        ].
        shapesFile close.
        ^shapes
    ]

    printHelp [
        Transcript tab.
        Transcript show: 'count'; cr; tab.
        Transcript show: '*** print the number of all shapes'; cr; tab.
        Transcript show: 'countN'; cr; tab.
        Transcript show: '*** print the number of all shapes that satisfy all N conditions specified below'; cr; tab.
        Transcript show: '*** for example: count3'; cr; tab.
        Transcript show: 'print'; cr; tab.
        Transcript show: '*** print all shapes'; cr; tab.
        Transcript show: 'printN'; cr; tab.
        Transcript show: '*** print all shapes that satisfy all N conditions specified below'; cr; tab.
        Transcript show: '*** for example: print4'; cr; tab.
        Transcript show: 'min'; cr; tab.
        Transcript show: '*** find the minimum surface area and volume of all shapes'; cr; tab.
        Transcript show: 'minN'; cr; tab.
        Transcript show: '*** find the minimum surface area and volume of all shapes that satisfy all N conditions specified below'; cr; tab.
        Transcript show: '*** for example: min2'; cr; tab.
        Transcript show: 'max'; cr; tab.
        Transcript show: '*** find the maximum surface area and volume of all shapes'; cr; tab.
        Transcript show: 'maxN'; cr; tab.
        Transcript show: '*** find the maximum surface area and volume of all shapes that satisfy all N conditions specified below'; cr; tab.
        Transcript show: '*** for example: max3'; cr; tab.
        Transcript show: 'total'; cr; tab.
        Transcript show: '*** find the tatal surface area and volume of all shapes'; cr; tab.
        Transcript show: 'totalN'; cr; tab.
        Transcript show: '*** find the total surface area and volume of all shapes that satisfy all N conditions specified below'; cr; tab.
        Transcript show: '*** for example: total4'; cr; tab.
        Transcript show: 'avg'; cr; tab.
        Transcript show: '*** find the average surface area and volume of all shapes'; cr; tab.
        Transcript show: 'avgN'; cr; tab.
        Transcript show: '*** find the average surface area and volume of all shapes that satisfy all N conditions specified below'; cr; tab.
        Transcript show: '*** for example: avg2'; cr; tab.
        Transcript show: 'quit'; cr; tab.
        Transcript show: '*** quit this program'; cr; tab.
        Transcript show: 'help'; cr; tab.
        Transcript show: '*** print this list'; cr; cr.
        Transcript show: 'Each condition shall be entered in one line and of the following format:'; cr; cr; tab.
        Transcript show: 'name op value'; cr; cr; tab.
        Transcript show: '*** for example: type != box'; cr; tab.
        Transcript show: '                 area <= 1000'; cr; tab.
        Transcript show: '                 volume > 100.5'; cr; cr; tab.
        Transcript show: 'The valid names:'; cr.
        Transcript tab; tab.
        Transcript show: (names at: 1); cr.
        Transcript tab; tab.
        Transcript show: (names at: 2); cr.
        Transcript tab; tab.
        Transcript show: (names at: 3); cr.
        Transcript cr; tab. 
        Transcript show: 'The valid operators:'; cr.
        Transcript tab; tab.
        Transcript show: (ops at: 1); cr.
        Transcript tab; tab.
        Transcript show: (ops at: 2); cr.
        Transcript tab; tab.
        Transcript show: (ops at: 3); cr.
        Transcript tab; tab.
        Transcript show: (ops at: 4); cr.
        Transcript tab; tab.
        Transcript show: (ops at: 5); cr.
        Transcript tab; tab.
        Transcript show: (ops at: 6); cr.
    ]

    getAction: command [
        |i subStringOfAction|
        i := 1.
        [i < command size] whileTrue: [
            ((command at: i) isDigit) ifTrue: [ 
                subStringOfAction := command copyFrom: 1 to: i - 1.
                ^subStringOfAction
             ].
            i := i + 1.
        ].
        "It does not do the last iteration so we take care of it here"
        ((command at: i) isDigit) ifTrue: [
            subStringOfAction := command copyFrom: 1 to: i - 1.
            ^subStringOfAction
        ].
        subStringOfAction := command copyFrom: 1 to: i.
        ^subStringOfAction
    ]

    isValidAction: action [
        |i|
        i := 1.
        [i <= (actions size)] whileTrue: [
            ((actions at: i) = action) ifTrue: [
                ^true
            ].
            i := i + 1.
        ].
        ^false
    ]

    isValidName: name [
        |i|
        i := 1.
        [i <= (names size)] whileTrue: [
            ((names at: i) = name) ifTrue: [
                ^true
            ].
            i := i + 1.
        ].
        ^false
    ]

    isValidOp: op [
        |i|
        i := 1.
        [i <= (ops size)] whileTrue: [
            ((ops at: i) = op) ifTrue: [
                ^true
            ].
            i := i + 1.
        ].
        ^false
    ]

    printValidActions [
        |i|
        i := 1.
        [i < 6] whileTrue: [
            Transcript show: (actions at: i).
            ', ' display.
            i := i + 1.
        ].
        Transcript show: (actions at: i).
    ]

    getTestConditions: testc [
        |line cond i name op value nameOpValueList|
        i := 0.
        cond := OrderedCollection new.
        [i < testc] whileTrue: [
            Transcript show: 'Enter test condition #'.
            (i + 1) display.
            ': ' display.

            "Getting the test condition from the user."
            line := stdin nextLine.
            
            "Now storing each piece of the test condition from the user."
            nameOpValueList := OrderedCollection new.
            nameOpValueList := line subStrings.

            name := nameOpValueList at: 1.

            ((self isValidName: name) = false) ifTrue: [
                Transcript show: name. 
                Transcript show: ': invalid name.'; cr.
            ].

            op := nameOpValueList at: 2.

            ((self isValidOp: op) = false) ifTrue: [
                Transcript show: op. 
                Transcript show: ': invalid operator.'; cr.
            ].

            value := nameOpValueList at: 3.

            "Populating the cond collection with the conditions the user gave."
            cond add: name; add: op; add: value; yourself.

            i := i + 1.
        ].
        ^cond
    ]

    countShapes: shapes conditions: cond [
        |count i shape|
        count := 0.
        i := 1.

        [i <= shapes size] whileTrue: [
            shape := shapes at: i.
            (shape test: cond) ifTrue: [
                count := count + 1.
            ].
            i := i + 1.
        ].
        ^count
    ]

    printShapes: shapes conditions: cond [
        |count i shape|
        count := 0.
        i := 1.

        [i <= shapes size] whileTrue: [
            shape := shapes at: i.
            (shape test: cond) ifTrue: [
                shape getInfo.
            ].
            i := i + 1.
        ].
        ^count
    ]

]

|args|
"Smalltalk arguments only grabs the file that is being 
passed in the command line arguments, in this case shapes.dat.
Ordered collections also start at 1 meaning there will be 1 argument"
args := Smalltalk arguments.
(args size ~= 1) ifTrue: [
    'Usage: shape.st sphere.st cylinder.st torus.st box.st -f main.st shape_file' displayNl.
    "This is similar to return -1 in C/C++ where it basically stops execution of the program."
    ObjectMemory quit: 1.
].

|file shapes myObject myShape|
"Grabbing the file we just found from Smalltalk arguments."
file := args at: 1.
(file ~= 'shapes.dat') ifTrue: [
    'Unable to open ' display. 
    file display.
    ' for reading' displayNl.
    ObjectMemory quit: 1.
].

shapes := OrderedCollection new.
"Creating a new instance of the subclass Info."
myObject := Info new.
"We pass the file to readFrom and we are returning an ordered collection of shapes."
shapes := myObject readFrom: file.

[true] whileTrue: [
    |command action line testc numberOfTestConditions i cond count area_min area_max volume_min volume_max shape area volume area_total volume_total|
    testc := 0.

    displayNl.
    'Enter a command: ' display.
    "Gets the command from user input."
    command := stdin nextLine.

    "If the user decides to quit we stop flow of execution."
    (command = 'quit') ifTrue: [ ObjectMemory quit: 1 ].

    "Prints the entire help menu."
    (command = 'help') ifTrue: [ myObject printHelp ].

    "Find what action the user wants, for example if they say min1 the action is min."
    action := myObject getAction: command.

    "Find the number of test conditions the user entered
    by going from 1 spot past the size of action to the end of the 
    command they entered earlier."
    testc := command copyFrom: (action size + 1) to: command size.
    "Since testc was a string now we convert to a number."
    testc := testc asNumber.


    (((myObject isValidAction: action) = false) | (testc < 0)) ifTrue: [
        Transcript show: action.
        Transcript show: ': Invalid action'; cr.
        Transcript show: 'Valid actions:'.
        myObject printValidActions.
        Transcript cr.
        Transcript show: 'Enter help for help'; cr.
    ].
    (action = 'count') ifTrue: [
        cond := myObject getTestConditions: testc.
        count := myObject countShapes: shapes conditions: cond.
        'There are ' display.
        count display.
        ' shapes.' displayNl.
    ].
    (action = 'print') ifTrue: [
        cond := myObject getTestConditions: testc.
        count := myObject countShapes: shapes conditions: cond.

        (count = 0) ifTrue: [ 
            Transcript show: 'There are no shapes satisfying the condition(s)'; cr.
        ].
        myObject printShapes: shapes conditions: cond.
    ].
    (action = 'min') ifTrue: [
        cond := myObject getTestConditions: testc.
        count := myObject countShapes: shapes conditions: cond.

        (count = 0) ifTrue: [ 
            Transcript show: 'There are no shapes satisfying the condition(s)'; cr.
        ].
        area_min := 999999999.
        volume_min := 999999999.

        i := 1.

        [i <= shapes size] whileTrue: [
            shape := shapes at: i.
            (shape test: cond) ifTrue: [
                area := shape getArea.
                (area < area_min) ifTrue: [ area_min := area ].
                volume := shape getVolume.
                (volume < volume_min) ifTrue: [ volume_min := volume ].
            ].
            i := i + 1.
        ].
        'min(Surface Area)=' display.
        ((area_min roundTo: 0.01) asScaledDecimal: 2) displayNl.
        'min(Volume)=' display.
        ((volume_min roundTo: 0.01) asScaledDecimal: 2) displayNl.
    ].
    (action = 'max') ifTrue: [
        cond := myObject getTestConditions: testc.
        count := myObject countShapes: shapes conditions: cond.

        (count = 0) ifTrue: [ 
            Transcript show: 'There are no shapes satisfying the condition(s)'; cr.
        ].
        area_max := -999999999.
        volume_max := -999999999.

        i := 1.

        [i <= shapes size] whileTrue: [
            shape := shapes at: i.
            (shape test: cond) ifTrue: [
                area := shape getArea.
                (area > area_max) ifTrue: [ area_max := area ].
                volume := shape getVolume.
                (volume > volume_max) ifTrue: [ volume_max := volume ].
            ].
            i := i + 1.
        ].
        'max(Surface Area)=' display.
        ((area_max roundTo: 0.01) asScaledDecimal: 2) displayNl.
        'max(Volume)=' display.
        ((volume_max roundTo: 0.01) asScaledDecimal: 2) displayNl.
    ].
    ((action = 'total') | (action = 'avg')) ifTrue: [
        cond := myObject getTestConditions: testc.
        count := myObject countShapes: shapes conditions: cond.

        (count = 0) ifTrue: [ 
            Transcript show: 'There are no shapes satisfying the condition(s)'; cr.
        ].
        area_total := 0.
        volume_total := 0.

        i := 1.

        [i <= shapes size] whileTrue: [
            shape := shapes at: i.
            (shape test: cond) ifTrue: [
                area_total := area_total + (shape getArea).
                volume_total := volume_total + (shape getVolume).
            ].
            i := i + 1.
        ].

        (action = 'total') ifTrue: [
            'total(Surface Area)=' display.
            ((area_total roundTo: 0.01) asScaledDecimal: 2) displayNl.
            'total(Volume)=' display.
            ((volume_total roundTo: 0.01) asScaledDecimal: 2) displayNl.
        ].
        (action = 'avg') ifTrue: [
            'avg(Surface Area)=' display.
            (((area_total / count) roundTo: 0.01) asScaledDecimal: 2) displayNl.
            'avg(Volume)=' display.
            (((volume_total / count) roundTo: 0.01) asScaledDecimal: 2) displayNl.
        ].
    ].
].

