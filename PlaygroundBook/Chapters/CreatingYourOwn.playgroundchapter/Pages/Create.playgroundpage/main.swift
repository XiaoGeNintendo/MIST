
/*:
 Let's end by showing off a sandbox!
 
 You must have a lot to try, now let's making them a reality.
 
 Last but not least, thank you for playing this little project!
 
 # Final Note
 - Use `MISTPerson` to create a person
 - Use `MISTItem<Type>` to create a facility
 - Create a scene by `MISTGameScene` and start it by `startMISTScene`
 - Always refer to auto-complete to see what you can do. There's a lot I didn't show you...
 - Use supplement information like description to make the scene more lively
 */

//#-hidden-code
import Mist
import SpriteKit
import CoreGraphics
//#-end-hidden-code

//#-editable-code
var p=MISTPerson(x: 880, y: 30, requiredHappiness: 50, requiredEnvironment: 100, name: "Hikari").setDesc(description: "I live in a far-away place :(").setAge(age: 10)
var p2=MISTPerson(x: 725, y: 660, requiredHappiness: 50, requiredEnvironment: 100, name: "Ninetail").setDesc(description: "I live in a far-away place :(").setAge(age: 10).setGender(gender: "F")
var p3=MISTPerson(x: 100, y: 125, requiredHappiness: 50, requiredEnvironment: 100, name: "Doragon").setDesc(description: "I live in a far-away place :(").setAge(age: 65).setEmoji(normal:"👨‍🦳",happy:"👨‍👩‍👧‍👦",sad:"😅")


var i1=MISTItemCircle(name: "Circle", image: "○", cost: 555, provideHappiness: 50, consumeEnvironment: 50, radius: 200)

var i2=MISTItemSquare(name: "Square", image: "☐", cost: 625, provideHappiness: 50, consumeEnvironment: 50, length: 200)

var i3=MISTItemDiamond(name: "Diamond", image: "◇", cost: 800, provideHappiness: 50, consumeEnvironment: 50, radius: 200)

var i4=MISTItemCustom(name: "Custom", image: "🀅", cost: 1000, provideHappiness: 50, consumeEnvironment: 50, arg: {
    Person -> Bool in
    return true
}).setDesc(desc: "This applies to everything on the screen")

let scene=MISTGameScene(badget: 1000, people: [p,p2,p3], availableItem: [i1,i2,i3,i4])
scene.resize(length: 500)

startMISTScene(scene: scene, sceneName: "My own village")
//#-end-editable-code
