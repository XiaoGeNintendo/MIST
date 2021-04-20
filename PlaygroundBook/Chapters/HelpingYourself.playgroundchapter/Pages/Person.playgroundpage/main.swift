
/*:
 # Coding 101 - Person
 Sometimes the people live too far and it's hard to benefit them all. In this way, we usually move them together, by building new houses or new district.
 
 In this scene, you will try to use this to your work as well as learn how a person is created in MIST!
 
 The world of MIST is a 2D-coordinate space.The bottom-left corner is (0,0) and the top-right corner is (1000,1000).
 
 A person is created using the function `MISTPerson`. You can also append supplement information like description, age, gender, displayed icon using the `set` function.
 
 # Objective
 Try to move all people closer so that you can finish the scene!
 
 # Note
 Try to use the auto-complete to explore what you can do!
 */

//#-hidden-code
import Mist
import SpriteKit
import CoreGraphics
//#-end-hidden-code

// You can create a person by using MISTPerson
var p=MISTPerson(x: /*#-editable-code*/880/*#-end-editable-code*/, y: /*#-editable-code*/30/*#-end-editable-code*/, requiredHappiness: 50, requiredEnvironment: 100, name: "Hikari")/*#-editable-code*/.setDesc(description: "I live in a far-away place :(").setAge(age: 10)/*#-end-editable-code*/
var p2=MISTPerson(x: /*#-editable-code*/725/*#-end-editable-code*/, y: /*#-editable-code*/660/*#-end-editable-code*/, requiredHappiness: 50, requiredEnvironment: 100, name: "Ninetail")/*#-editable-code*/.setDesc(description: "I live in a far-away place :(").setAge(age: 10).setGender(gender: "F")/*#-end-editable-code*/
var p3=MISTPerson(x: /*#-editable-code*/100/*#-end-editable-code*/, y: /*#-editable-code*/125/*#-end-editable-code*/, requiredHappiness: 50, requiredEnvironment: 100, name: "Doragon")/*#-editable-code*/.setDesc(description: "I live in a far-away place :(").setAge(age: 65).setEmoji(normal:"👨‍🦳",happy:"👨‍👩‍👧‍👦",sad:"😅")/*#-end-editable-code*/

// You can create an item using MISTItem
var item=MISTItemCircle(name: "Train Station", image: "🚞", cost: 800, provideHappiness: 120, consumeEnvironment: 20, radius: 300)

// Create a game scene and resize it
var scene=MISTGameScene(badget: 1000, people: [p,p2,p3], availableItem: [item])
scene.resize(length: /*#-editable-code*/500/*#-end-editable-code*/)

// Start the scene
startMISTScene(scene: scene, sceneName: "A New Gathering")

//: [Next: Items](Item)
