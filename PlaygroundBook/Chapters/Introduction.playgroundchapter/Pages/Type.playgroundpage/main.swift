/*:
 # Types of items
 Press **Run my code** and try to place down each item. Choose the most proper item.
 
 # Note
- You can disable Show Result to improve performance if necessary.

- You can also resize the scene.
*/

//#-code-completion(everything,hide)

//#-hidden-code
import Mist

var p1=MISTPerson(x: 300, y: 500, requiredHappiness: 50, requiredEnvironment: 50, name: "Left")
var p2=MISTPerson(x: 700, y: 500, requiredHappiness: 50, requiredEnvironment: 50, name: "Right")
var p3=MISTPerson(x: 500, y: 300, requiredHappiness: 50, requiredEnvironment: 50, name: "Down")
var p4=MISTPerson(x: 500, y: 700, requiredHappiness: 50, requiredEnvironment: 50, name: "Up")

var i1=MISTItemCircle(name: "Circle", image: "○", cost: 0, provideHappiness: 50, consumeEnvironment: 50, radius: 200)

var i2=MISTItemSquare(name: "Square", image: "☐", cost: 0, provideHappiness: 50, consumeEnvironment: 50, length: 200)

var i3=MISTItemDiamond(name: "Diamond", image: "◇", cost: 0, provideHappiness: 50, consumeEnvironment: 50, radius: 200)

var i4=MISTItemCustom(name: "Custom", image: "🀅", cost: 0, provideHappiness: 50, consumeEnvironment: 50, arg: {
    Person -> Bool in
    return true
}).setDesc(desc: "This applies to everything on the screen")

let scene=MISTGameScene(badget: 1000, people: [p1,p2,p3,p4], availableItem: [i1,i2,i3,i4])
//#-end-hidden-code

scene.resize(length: /*#-editable-code*/500/*#-end-editable-code*/)
startMISTScene(scene: scene, sceneName: "Types of Item")

