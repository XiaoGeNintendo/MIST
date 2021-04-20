/*:
 # Coding 101 - Items
 Have you ever heard of the term *Suit one's measures to local conditions*? We shall develop a plan according to the local conditions.
 
 In this page, you will revisit a scene and try to make small changes to the facilities so that they meet your requirements.
 
 # Objective
 Try to explore the use of items, following the previous page!
 
 Need some hint? Check your auto-complete or last page's work!
*/


//#-hidden-code
import Mist
import SpriteKit
import CoreGraphics
//#-end-hidden-code

// defining people
var p1=MISTPerson(x: 300, y: 500, requiredHappiness: 375, requiredEnvironment: 220, name: "Rinri")
var p2=MISTPerson(x: 700, y: 500, requiredHappiness: 500, requiredEnvironment: 350, name: "Rinko")
var p3=MISTPerson(x: 500, y: 300, requiredHappiness: 225, requiredEnvironment: 120, name: "Momiji")
var p4=MISTPerson(x: 500, y: 700, requiredHappiness: 530, requiredEnvironment: 600, name: "Aya")

//#-editable-code
var i1=MISTItemCircle(name: "Circle", image: "○", cost: 555, provideHappiness: 50, consumeEnvironment: 50, radius: 200)

var i2=MISTItemSquare(name: "Square", image: "☐", cost: 625, provideHappiness: 50, consumeEnvironment: 50, length: 200)

var i3=MISTItemDiamond(name: "Diamond", image: "◇", cost: 800, provideHappiness: 50, consumeEnvironment: 50, radius: 200)

var i4=MISTItemCustom(name: "Custom", image: "🀅", cost: 1000, provideHappiness: 50, consumeEnvironment: 50, arg: {
    Person -> Bool in
    return true
}).setDesc(desc: "This applies to everything on the screen")
//#-end-editable-code

let scene=MISTGameScene(badget: 1000, people: [p1,p2,p3,p4], availableItem: [i1,i2,i3,i4])


scene.resize(length: /*#-editable-code*/500/*#-end-editable-code*/)
startMISTScene(scene: scene, sceneName: "Suit your measure")

