
/*:
 # Welcome to MIST
 **Welcome to the world of MayISolveIt(MIST)**
 
 In this game, you are going to play the role as a young man who wants to help his hometown using resources from the government and his creativity.
 
 First things first, you will learn about the basic of controls.
 
 # Control
 Press **Run my code** to run the scene
 
 First, **press** on the item in the item bar until it is *not transparent* to select it.
 
 Did you see the canvas below? **Press** anywhere on the canvas to place down your item!
 
 **Drag** any placed item to move its position! **Drag it out of the scene** to remove it!
 
 **Press** on a person to see his/her stat.
 
 When a person is in the intersection circle, it will be affected. Its happiness will increase and environment point will drop accordingly.
 
 Your task is to make everyone happy while maintaining the balance of the environment! Oh, keep an eye on your badget too! 😉
 
 # Now...
 Try to place down a **train station** between the three people and see what happens!
 
 Then try to replace it with some **factories** and see people's reaction!
 
 Although factories are cheaper, and building a lot will improve the local economy, but they are not sustainable, so that's a NO. 🙅‍♂️
 # Note
 - Background picture was taken by Wenqing Ge at Mt.Wuxiang, Nanjing, China and is blurred intentionally.
 - When the scene size is too big or too small for the screen, you can modify the width and height to make it more comfortable. This does not influence gameplay.
 - You can turn off "Show Results" to improve performance
 */

//#-code-completion(everything,hide)
//#-hidden-code
import Mist
var p=MISTPerson(x: 300, y: 300, requiredHappiness: 50, requiredEnvironment: 100, name: "Villager A").setDesc(description: "I am just a normal villager :)").setAge(age: 10)
var p2=MISTPerson(x: 700, y: 300, requiredHappiness: 50, requiredEnvironment: 75, name: "Villager B").setDesc(description: "I am just a normal villager :)").setGender(gender: "F").setAge(age: 20)
var p3=MISTPerson(x: 500, y: 100, requiredHappiness: 75, requiredEnvironment: 100, name: "Villager C").setDesc(description: "I am just a normal villager :)").setAge(age: 50)

var item=MISTItemCircle(name: "Train Station", image: "🚞", cost: 800, provideHappiness: 120, consumeEnvironment: 20, radius: 300)
var item2=MISTItemCircle(name: "Factory", image: "🏭", cost: 200, provideHappiness: 40, consumeEnvironment: 50, radius: 240)

var scene=GameScene(1000,[p,p2,p3],[item,item2],false)
//#-end-hidden-code
scene.resize(length: /*#-editable-code*/500/*#-end-editable-code*/)
startMISTScene(scene: scene, sceneName: "Test Village")

//: [Next: Types](Type)
