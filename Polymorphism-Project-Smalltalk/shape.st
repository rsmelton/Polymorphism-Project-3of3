Object subclass: Shape [
    | name |

    Shape class >> new [
        <category: 'instance creation'>
        | shape |
        shape := super new.
        shape init.
        ^shape
    ]

    init [
        <category: 'initialization'>
        name := ''.
    ]

    setName: nameOfShape [ 
        <category: 'accessing'>
        name := nameOfShape.
    ]

    getName [ 
        <category: 'accessing'>
        ^name 
    ]
]