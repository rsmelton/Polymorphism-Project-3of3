Shape subclass: Cylinder [
    |name radius height PI|

    init [
        <category: 'initialization'>
        radius := 0.0.
        height := 0.0.
        PI := 3.14159265358979323846.
        ^ super init
    ]

    setRadius: radiusOfCylinder [
        radius := radiusOfCylinder.
    ]

    getRadius [
        ^radius
    ]

    setHeight: heightOfCylinder [
        height := heightOfCylinder.
    ]

    getHeight [
        ^height
    ]

    getArea [
        |surfaceArea|
        surfaceArea := (2 * PI * radius * height) + (2 * PI * (radius * radius)).
        ^surfaceArea
    ]

    getVolume [
        |volume|
        volume := PI * (radius * radius) * height.
        ^volume
    ]

    "Function similar to compare function built into C++"
    compare: string1 secondString: string2 [
        |i asciiOfFirstString asciiOfSecondString|
        i := 1.
        "We loop over the sizes of both strings since if one string
        runs out of characters to compare this means they were the same
        until they ran out meaning the string with more characters is greater."
        [(i <= string1 size) & (i <= string2 size)] whileTrue: [
            asciiOfFirstString := (string1 at: i) asciiValue.
            asciiOfSecondString := (string2 at: i) asciiValue.
            "
            'is ascii of first character ' display.
            (string1 at: i) display.
            ': ' display.
            asciiOfFirstString display.
            ' >, <, or equal to ascii of secong character ' display.
            (string2 at: i) display.
            ': ' display.
            asciiOfSecondString displayNl.
            "
            (asciiOfFirstString > asciiOfSecondString) ifTrue: [ ^1 ].
            (asciiOfFirstString < asciiOfSecondString) ifTrue: [ ^-1 ].
            i := i + 1.
        ].
        ((string1 size) > (string2 size)) ifTrue: [ ^1 ].
        ((string1 size) < (string2 size)) ifTrue: [ ^-1 ].
        "Returns 0 if we get through the loop and past the ifs cause 
        this means the strings were equal."
        ^0
    ]

    comparisonOfTypes: op type: typeOfShapeToBeComparedWith [
        |valueFromComparedStrings|

        "We call it once here instead of every time in the if branches."
        valueFromComparedStrings := self compare: 'cylinder' secondString: typeOfShapeToBeComparedWith.

        "Doing something similar to compare function built in C++"
        (op = '==') ifTrue: [
            (valueFromComparedStrings = 0) ifTrue: [ ^true ] ifFalse: [ ^false ].
        ].
        (op = '!=') ifTrue: [
            (valueFromComparedStrings ~= 0) ifTrue: [ ^true ] ifFalse: [ ^false ].
        ].
        (op = '>=') ifTrue: [
            ((valueFromComparedStrings = 1) | (valueFromComparedStrings = 0)) ifTrue: [ ^true ] ifFalse: [ ^false ].
        ].
        (op = '<=') ifTrue: [
            ((valueFromComparedStrings = -1) | (valueFromComparedStrings = 0)) ifTrue: [ ^true ] ifFalse: [ ^false ].
        ].
        (op = '>') ifTrue: [
            (valueFromComparedStrings = 1) ifTrue: [ ^true ] ifFalse: [ ^false ].
        ].
        (op = '<') ifTrue: [
            (valueFromComparedStrings = -1) ifTrue: [ ^true ] ifFalse: [ ^false ].
        ].
    ]

    comparisonOfValues: op firstValue: value secondValue: valueToBeComparedWith [
        "The values being compared will either be two areas or two volumes being compared."
        "Using one function instead of two considering the code would be the same."
        (op = '==') ifTrue: [
            (value = valueToBeComparedWith) ifTrue: [ ^true ] ifFalse: [ ^false ].
        ].
        (op = '!=') ifTrue: [
            (value ~= valueToBeComparedWith) ifTrue: [ ^true ] ifFalse: [ ^false ].
        ].
        (op = '>=') ifTrue: [
            (value >= valueToBeComparedWith) ifTrue: [ ^true ] ifFalse: [ ^false ].
        ].
        (op = '<=') ifTrue: [
            (value <= valueToBeComparedWith) ifTrue: [ ^true ] ifFalse: [ ^false ].
        ].
        (op = '>') ifTrue: [
            (value > valueToBeComparedWith) ifTrue: [ ^true ] ifFalse: [ ^false ].
        ].
        (op = '<') ifTrue: [
            (value < valueToBeComparedWith) ifTrue: [ ^true ] ifFalse: [ ^false ].
        ].
    ]

    test: cond [  
        |i|
        i := 1.

        [i <= cond size] whileTrue: [
            |name op|
            name := cond at: i.
            i := i + 1.
            op := cond at: i.
            i := i + 1.
            (name = 'type') ifTrue: [
                |typeToBeComparedWith|
                typeToBeComparedWith := cond at: i.

                (self comparisonOfTypes: op type: typeToBeComparedWith) ifFalse: [ ^false ].
            ].
            (name = 'area') ifTrue: [
                |areaToBeComparedWith myArea|
                areaToBeComparedWith := cond at: i.
                areaToBeComparedWith := areaToBeComparedWith asNumber.

                myArea := self getArea.
                (self comparisonOfValues: op firstValue: myArea secondValue: areaToBeComparedWith) ifFalse: [ ^false ].
            ].
            (name = 'volume') ifTrue: [
                |volumeToBeComparedWith myVolume|
                volumeToBeComparedWith := cond at: i.
                volumeToBeComparedWith := volumeToBeComparedWith asNumber.

                myVolume := self getVolume.
                (self comparisonOfValues: op firstValue: myVolume secondValue: volumeToBeComparedWith) ifFalse: [ ^false ].
            ].
            i := i + 1.
        ].
        ^true
    ]

    getInfo [
        |nameOfShape surfaceArea volume|
        nameOfShape := self getName.
        surfaceArea := self getArea.
        volume := self getVolume.

        'Cylinder: ' display.
        nameOfShape display.
        ', Radius=' display.
        ((radius roundTo: 0.01) asScaledDecimal: 2) display.
        ', Height=' display.
        ((height roundTo: 0.01) asScaledDecimal: 2) displayNl.
        '        Surface Area: ' display.
        ((surfaceArea roundTo: 0.01) asScaledDecimal: 2) display.
        ', Volume: ' display.
        ((volume roundTo: 0.01) asScaledDecimal: 2) displayNl.
    ]
]