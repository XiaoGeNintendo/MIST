
/*:
 This is an extra level based on the story of *Village Shibadong*. It's optional and a bit hard.
 */

//#-hidden-code
import Mist
import SpriteKit
import CoreGraphics
//#-end-hidden-code

//#-editable-code
var pl1=MISTPerson(x: 100, y: 100, requiredHappiness: 100, requiredEnvironment: 150, name: "Ookami").setGender(gender: "F")
var pl2=MISTPerson(x: 350, y: 210, requiredHappiness: 100, requiredEnvironment: 150, name: "Doragon").setGender(gender: "F")
var pl3=MISTPerson(x: 265, y: 200, requiredHappiness: 100, requiredEnvironment: 150, name: "Ninetail").setGender(gender: "F")
var pl4=MISTPerson(x: 430, y: 413, requiredHappiness: 120, requiredEnvironment: 110, name: "Hikari").setGender(gender: "F")
var pl5=MISTPerson(x: 288, y: 625, requiredHappiness: 120, requiredEnvironment: 90, name: "Rinko").setGender(gender: "F")
var pl6=MISTPerson(x: 317, y: 818, requiredHappiness: 120, requiredEnvironment: 85, name: "Rinri")
var pl7=MISTPerson(x: 334, y: 900, requiredHappiness: 120, requiredEnvironment: 100, name: "Dairy")

var pm1=MISTPerson(x: 440, y: 888, requiredHappiness: 100, requiredEnvironment: 100, name: "Zzzyt")
var pm2=MISTPerson(x: 565, y: 919, requiredHappiness: 100, requiredEnvironment: 100, name: "Zhuky")

var pr1=MISTPerson(x: 663, y: 727, requiredHappiness: 130, requiredEnvironment: 75, name: "MonkeyKing")
var pr2=MISTPerson(x: 600, y: 888, requiredHappiness: 130, requiredEnvironment: 60, name: "HDD")
var pr3=MISTPerson(x: 525, y: 691, requiredHappiness: 150, requiredEnvironment: 100, name: "CarottX")
var pr4=MISTPerson(x: 887, y: 543, requiredHappiness: 100, requiredEnvironment: 100, name: "Prince")
var pr5=MISTPerson(x: 727, y: 644, requiredHappiness: 100, requiredEnvironment: 100, name: "ZHD")
var pp=MISTPerson(x: 955, y: 85, requiredHappiness: 30, requiredEnvironment: 100, name: "Claire Zhang").setGender(gender: "F")

var i1=MISTItemCircle(name: "Rice", image: "🍚", cost: 8000, provideHappiness: 35, consumeEnvironment: 20, radius: 225).setRangeColor(col: SKColor.init(red: 0.97, green: 0.88, blue: 0.91, alpha: 0.3))
var i2=MISTItemSquare(name: "Flue-cured Tobacco", image: "🪄", cost: 22000, provideHappiness: 40, consumeEnvironment: 30, length: 300).setRangeColor(col: SKColor.init(red: 0.13, green: 0.44, blue: 0.26, alpha: 0.3))
var i3=MISTItemCircle(name: "Kiwi", image: "🥝", cost: 40000, provideHappiness: 50, consumeEnvironment: 20, radius: 500).setRangeColor(col: SKColor.init(red: 0.03, green: 0.88, blue: 0.56, alpha: 0.3))
var i4=MISTItemDiamond(name: "Mine", image: "⛏", cost: 3500, provideHappiness: 40, consumeEnvironment: 60, radius: 500).setDesc(desc: "Open up a gold mine to earn money the quick way")

var i5=MISTItemCustom(name: "Tourist Attraction", image: "📷", cost: 60000, provideHappiness: 30, consumeEnvironment: 30, arg: {
    Person -> Bool in
    return true
}).setDesc(desc: "Applies to everyone in the village")

var i6=MISTItemSquare(name: "One-to-one Donation", image: "💎", cost: 2000, provideHappiness: 10, consumeEnvironment: 0, length: 100).setRangeColor(col: SKColor.init(red: 0, green: 0, blue: 1, alpha: 0.3)).setDesc(desc: "Directly give money to certain communities to help them grow")

var i7=MISTItemSquare(name: "Five Improvement", image: "🧰", cost: 10000, provideHappiness: 20, consumeEnvironment: 5, length: 300).setDesc(desc: "Five Improvement stands for Toilet Improvement, Water Supply Improvement,\n Farm Animal Improvement, Kitchen Improvement, Traffic Improvement").setRangeColor(col: SKColor.init(red: 0.8, green: 0.1, blue: 0.1, alpha: 0.3))

let scene=MISTGameScene(badget: 125000, people: [pl1,pl2,pl3,pl4,pl5,pl6,pl7,pm1,pm2,pr1,pr2,pr3,pr4,pr5,pp], availableItem: [i1,i2,i3,i4,i5,i6,i7])
scene.resize(length: 500)
startMISTScene(scene: scene, sceneName: "Village Fantasy")
//#-end-editable-code
