// Combined From: ItemView.swift
//
//  ItemView.swift
//  MayISolveThis_MVP
//
//  Created by Wenqing Ge on 2020/12/24.
//

import SwiftUI

struct ItemView: View {
    var item: Item
    var chosen: Item
    
    let ucc=Color.blue.opacity(0.3)
    let cc=Color.red.opacity(0.3)
    
    var body: some View {
        
        let sz:CGFloat=60
        
        HStack{
            ZStack{
                Circle().stroke(lineWidth: 3)
                Text(item.image).font(.largeTitle)
            }.frame(width: sz, height: sz, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .background(item==chosen ? cc: ucc)
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            
        }
    }
}


// Combined From: PersonInfoView.swift
//
//  PersonInfoView.swift
//  MIST_v2
//
//  Created by Wenqing Ge on 2021/2/18.
//

import SwiftUI

struct PersonInfoView: View {
    var person: Person
    
    var body: some View {
        VStack(alignment:.leading){
            Text("\(person.getEmoji()) \(person.name), \(person.age), \(person.gender)")
                .font(.largeTitle)
                .bold()
            Text(person.desc).font(.caption)
            Spacer()
            ProgressView("Happiness: \(person.hpUI)/\(person.requiredHappiness)", value: min(Double(person.requiredHappiness),Double(person.hpUI)), total: Double(person.requiredHappiness))
            ProgressView("Environment: \(person.requiredEnvironment-person.envUI)/\(person.requiredEnvironment)", value: max(0,Double(person.requiredEnvironment-person.envUI)), total: Double(person.requiredEnvironment))
            if __scene.supportMotionControl{
                Text("Multiplier:*\(range[person.layer][1])")
                    .italic()
                    .font(.callout)
            }
            Text(person.hpUI>=Double(person.requiredHappiness) ? person.msgA1 : person.msgA2)
                .italic()
                .font(.callout)
                .foregroundColor(person.hpUI>=Double(person.requiredHappiness) ? .green : .orange)
            Text(person.envUI>person.requiredEnvironment ? person.msgB1 : person.msgB2)
                .italic()
                .font(.callout)
                .foregroundColor(person.envUI>person.requiredEnvironment ? .red : .green)
            Spacer()
        }.padding()
    }
}

// Combined From: MISTPersonNode.swift
//
//  MISTPersonNode.swift
//  MIST_v2
//
//  Created by Wenqing Ge on 2021/1/23.
//

import Foundation
import SpriteKit

class MISTPersonNode:SKNode{
    
    var person:Person
    
    var hpCircle: SKShapeNode
    var envCircle: SKShapeNode
    var display: SKLabelNode
    
    init(p:Person){
        self.person=p
        self.hpCircle=SKShapeNode()
        self.envCircle=SKShapeNode()
        self.display=SKLabelNode()
        super.init()
        
        self.position=CGPoint(x: p.x, y: p.y)
        self.name=p.name
        
        self.display.text=p.getEmoji()
        self.display.verticalAlignmentMode = .center
        self.display.horizontalAlignmentMode = .center
        self.addChild(display)
        
        // initalize the circles
//        let arc1=UIBezierPath(arcCenter: CGPoint(x: 0,y: 0), radius: 20, startAngle: 0.0, endAngle: CGFloat(.pi*2*((p.happiness/p.requiredHappiness))), clockwise: true).cgPath
        self.hpCircle.lineWidth=5
        self.hpCircle.strokeColor=SKColor.orange
//        self.hpCircle.path=arc1
        self.addChild(hpCircle)
        
//        let arc2=UIBezierPath(arcCenter: CGPoint(x: 0,y: 0), radius: 25, startAngle: 0, endAngle: max(0,CGFloat(.pi*2*(1-(p.environment/p.requiredEnvironment)))), clockwise: true).cgPath
        self.envCircle.lineWidth=5
        self.envCircle.strokeColor=SKColor.green
//        self.envCircle.path=arc2
        self.addChild(envCircle)
        
        //adding action for arc length
        self.run(SKAction.customAction(withDuration: 100000) { (node, time) in
            let x=node as! MISTPersonNode
            if x.person.happiness < x.person.hpUI{
                x.person.happiness += min(x.person.hpUI-x.person.happiness,2)
            } else {
                x.person.happiness += max(x.person.hpUI-x.person.happiness,-2)
            }
            
            if Int(x.person.environment) < x.person.envUI{
                x.person.environment += min(x.person.envUI-x.person.environment,2)
            } else {
                x.person.environment += max(x.person.envUI-x.person.environment,-2)
            }
            
            x.hpCircle.path=UIBezierPath(arcCenter: CGPoint(x: 0,y: 0), radius: 20, startAngle: 0.0, endAngle: CGFloat(.pi*2*((p.happiness/Double(p.requiredHappiness)))), clockwise: true).cgPath
            
            let val = .pi*2*(1-(p.environment/Double(p.requiredEnvironment)))
            
            x.envCircle.path=UIBezierPath(arcCenter: CGPoint(x: 0,y: 0), radius: 25, startAngle: 0, endAngle: max(0,CGFloat(val)), clockwise: true).cgPath
        })
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// Combined From: Item.swift
//
//  Item.swift
//  MIST_v2
//
//  Created by Wenqing Ge on 2021/2/23.
//

import Foundation
import CoreGraphics
import SpriteKit

public class Item:Identifiable, Equatable, Hashable{
    /// X position
    public var x: CGFloat=0
    /// Y position
    public var y: CGFloat=0
    
    /// Item's name
    public var name: String
    /// Item's icon
    public var image: String
    
    /**
    Types of hitbox
     */
    public var type:Int
    
    /// badget cost
    public var cost:Int
    /// happiness provided
    public var provideHP:Int
    /// environment consumed
    public var consumeEnv:Int
    
    /// radius or length
    public var rA:CGFloat
    var rB:CGFloat
    /// Custom detection function
    public var rC:((Person) -> Bool) = nilFunc
    public var id=UUID()
    
    /// Description
    public var desc: String = ""
    
    /// color of range circle
    public var rangeColor: SKColor = SKColor.init(red: 0.1, green: 0.8, blue: 0.77, alpha: 0.5)
    
    public init(name: String, image: String, type: Int, cost: Int, provideHP: Int, consumeEnv: Int, rA: CGFloat, rB: CGFloat) {
        self.name=name
        self.image=image
        self.type=type
        self.cost=cost
        self.provideHP=provideHP
        self.consumeEnv=consumeEnv
        self.rA=rA
        self.rB=rB
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
        hasher.combine(name)
        hasher.combine(image)
        hasher.combine(type)
        hasher.combine(provideHP)
        hasher.combine(consumeEnv)
        hasher.combine(rA)
        hasher.combine(rB)
        hasher.combine(cost)
    }
    
    /// Returns true if a person is in the range of affection
    public func isCollide(p: Person) -> Bool{
        if type==1{
            return pow(p.x-x,2)+pow(p.y-y,2)<=pow(rA,2)
        }else if type==2{
            return abs(p.x-x)+abs(p.y-y)<=rA
        }else if type==3{
            return max(abs(p.x-x),abs(p.y-y))<=rA
        }else{
            return rC(p)
        }
    }
    
    /// set description
    public func setDesc(desc: String) -> Item{
        self.desc=desc
        return self
    }
    
    /// set collision function
    public func setRC(arg: @escaping (Person) -> Bool) -> Item{
        self.rC=arg
        return self
    }
    
    /// set color of range display
    public func setRangeColor(col: SKColor) -> Item{
        self.rangeColor=col
        return self
    }
    
    /// clone an item
    public func copy() -> Item{
        return Item(name: name, image: image, type: type, cost: cost, provideHP: provideHP, consumeEnv: consumeEnv, rA: rA, rB: rB).setDesc(desc: desc).setRC(arg: rC).setRangeColor(col: rangeColor)
    }
}

public func == (a:Item,b:Item) ->Bool{
    return a.id==b.id
}

// Combined From: Person.swift
//
//  Person.swift
//  MIST_v2
//
//  Created by Wenqing Ge on 2021/2/23.
//

import Foundation
import CoreGraphics

public class Person{
    /// X position of the person
    public var x:CGFloat
    /// Y position of the person
    public var y:CGFloat
    /// required Happiness
    public var requiredHappiness:Int
    /// required Environment
    public var requiredEnvironment:Int
    
    var happiness:Double=0
    var environment:Double=0
    
    /// Current Happiness
    public var hpUI:Double=0
    /// Current Environment
    public var envUI:Int=0
    
    /// Name
    public var name:String
    
    var id=UUID()
    
    // Town center layer
    public var layer = 0
    //decoration information
    /// Age
    public var age: Int = 18
    /// Gender
    public var gender: String = "M"
    /// Message when happy enough
    public var msgA1: String = "I greatly appreciate your help! 🥰"
    /// Message when not happy enough
    public var msgA2: String = "I hope I can be more happy... 😅"
    /// Message when environment is bad
    public var msgB1: String = "Urgh! I cannot live in such a poor environment 🤢"
    /// Message when environment if acceptable
    public var msgB2: String = "The environment around me is acceptable ☺️"
    /// Character description
    public var desc: String = ""
    
    public var image: [String] = ["🙂","😃","🤢"]
    public init(x: CGFloat,y: CGFloat, requiredHappiness: Int, requiredEnvironment: Int, name: String){
        self.x=x
        self.y=y
        self.requiredHappiness=requiredHappiness
        self.requiredEnvironment=requiredEnvironment
        self.name=name
    }
    
    /// set gender
    public func setGender(gender: String) -> Person{
        self.gender=gender
        return self
    }
    
    /// set age
    public func setAge(age: Int) -> Person{
        self.age=age
        return self
    }
    
    /// set custom message
    public func setMessage(happy: String, not_happy: String, bad_environment: String, good_environment: String) -> Person{
        self.msgA1=happy
        self.msgA2=not_happy
        self.msgB1=bad_environment
        self.msgB2=good_environment
        return self
    }
    
    /// set description
    public func setDesc(description: String) -> Person{
        self.desc=description
        return self
    }
    
    /// set icon
    public func setEmoji(normal: String, happy: String, sad: String) -> Person{
        self.image=[normal,happy,sad]
        return self
    }
    
    /// Get current displayed icon
    public func getEmoji() -> String{
        if envUI>requiredEnvironment{
            return image[2]
        } else if hpUI>=Double(requiredHappiness){
            return image[1]
        } else{
            return image[0]
        }
    }
}

// Combined From: MISTCenterNode.swift
//
//  MISTCenterNode.swift
//  MIST_v2
//
//  Created by Wenqing Ge on 2021/2/23.
//

import Foundation
import SpriteKit

class MISTCenterNode:SKNode{
    
    
    override init(){
        super.init()
        
        for i in range{
            let circle=SKShapeNode(circleOfRadius: CGFloat(i[0]))
            circle.position=CGPoint(x: 0, y: 0)
            circle.fillColor=SKColor.init(red: CGFloat(0.5*i[1]), green: 0, blue: 0, alpha: 0.3)
            addChild(circle)
        }
    }
    
    func getLayer(_ p:Person) -> Int{
        let x=position.x
        let y=position.y
        
        var id=0
        for i in range{
            let dis=sqrt(pow(p.x-x,2)+pow(p.y-y,2))
            if Double(dis)<=i[0]{
                return id
            }
            
            id+=1
        }
        
        return -1
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// Combined From: MISTItemNode.swift
//
//  MISTPersonNode.swift
//  MIST_v2
//
//  Created by Wenqing Ge on 2021/1/23.
//

import Foundation
import SpriteKit

class MISTItemNode:SKNode{
    
    var item:Item
    
    var rangeDis: SKShapeNode
    var display: SKLabelNode
    
    init(p:Item){
        self.item=p
        self.rangeDis=SKShapeNode()
        self.display=SKLabelNode()
        super.init()
        self.position=CGPoint(x: p.x, y: p.y)
        self.name=p.id.uuidString
        
        self.display.position=CGPoint(x: 0, y: 0)
        self.display.text=p.image
        self.display.verticalAlignmentMode = .center
        self.display.horizontalAlignmentMode = .center
        self.display.zPosition+=1
        self.addChild(display)
        
        //adding range display
        
        if p.type==1{
            rangeDis=SKShapeNode(circleOfRadius: p.rA)
            rangeDis.position=CGPoint(x: 0, y: 0)
            rangeDis.strokeColor=SKColor.red
            rangeDis.glowWidth=1
            rangeDis.fillColor=p.rangeColor
            self.addChild(rangeDis)
        } else if p.type==2{
            rangeDis=SKShapeNode(rectOf: CGSize(width: 2*p.rA/sqrt(2),height: 2*p.rA/sqrt(2)))
            rangeDis.position=CGPoint(x: 0, y: 0)
            rangeDis.strokeColor=SKColor.red
            rangeDis.glowWidth=1
            rangeDis.fillColor=p.rangeColor
            rangeDis.zRotation = .pi/4
            self.addChild(rangeDis)
        } else if p.type==3{
            rangeDis=SKShapeNode(rectOf: CGSize(width: 2*p.rA,height: 2*p.rA))
            rangeDis.position=CGPoint(x: 0, y: 0)
            rangeDis.strokeColor=SKColor.red
            rangeDis.glowWidth=1
            rangeDis.fillColor=p.rangeColor
            self.addChild(rangeDis)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// Combined From: ViewRefresher.swift
//
//  ViewRefresher.swift
//  MayISolveThis_MVP
//
//  Created by Wenqing Ge on 2020/12/25.
//

import Foundation
import SwiftUI

class ViewRefresher: ObservableObject {
    
    var toShow: Person? = nil
    var present: Bool = false
    var toPresent: Item? = nil
    /**
     0 = No sheet should be displaying
     1 = Display Item Sheet
     2 = Display Person Sheet
     */
    var mode: Int = 0
    
    func reloadView(show:Person){
        __scene.error=""
        toShow=show
        present=true
        mode = 2
        objectWillChange.send()
    }
    func reloadView(_ str:String) {
        __scene.error=str
        toShow=nil
        present=false
        mode = 0
        objectWillChange.send()
    }
}

// Combined From: MotionDataProcessor.swift
//
//  MotionDataProcessor.swift
//  MIST_v2
//
//  Created by Wenqing Ge on 2021/2/23.
//

import Foundation
import CoreMotion

var motion=CMMotionManager()
var timer: Timer? = nil

func logMotion(){
    if motion.isDeviceMotionAvailable{
        motion.deviceMotionUpdateInterval=1/24.0
        motion.showsDeviceMovementDisplay=true
        motion.startDeviceMotionUpdates(using: .xMagneticNorthZVertical)
        
        print("Starting processing motion control")
        timer = Timer(fire: Date(), interval: 1/24.0, repeats: true, block: { (timer) in
            if let data = motion.deviceMotion{
                let pitch=data.attitude.pitch
                let roll=data.attitude.roll
                __scene.rotationLR=roll
                __scene.rotationUD = -pitch
            }
        })
        
        RunLoop.current.add(timer!, forMode: RunLoop.Mode.default)
    }else{
        print("Seems motion control is not supported")
    }
}


// Combined From: GameObject.swift
//
//  GameObject.swift
//  MayISolveThis_MVP
//
//  Created by Wenqing Ge on 2020/12/24.
//

import Foundation
import UIKit
import CoreGraphics
import SpriteKit

func nilFunc(p: Person) -> Bool{
    return false
}

/**
 Returns a/b in double
 */
func CLC(_ a: Int,_ b: Int) -> Double{
    return Double(a)/Double(b)
}

func -(a:Int,b:Double) -> Double{
    return Double(a)-b
}

public let NilItem=Item(name: "Nothing selected..", image: "?", type: 1, cost:0, provideHP: 0, consumeEnv: 0, rA: 0, rB: 0)

public let TGI=Item(name: "Factory", image: "🚗", type: 1, cost:120, provideHP: 50, consumeEnv: 50,rA:100,rB:0).setRangeColor(col: SKColor.red).setDesc(desc: "2021-02-24 21:43:43.549125+0800 MIST_v2[1395:35396] Metal API Validation Enabled")

public let TGP=Person(x: 100.0, y: 50.0, requiredHappiness: 100, requiredEnvironment: 100, name: "Hello").setDesc(description: "This is a test message xcode file edit view find navigate editor product debug source control window help")

public let TGP2=Person(x: 200.0, y: 50.0, requiredHappiness: 70, requiredEnvironment: 100, name: "Hello").setDesc(description: "This is a test message xcode file edit view find navigate editor product debug source control window help").setEmoji(normal: "a", happy: "b", sad: "c")

public let TGS = GameScene(1000, [TGP,TGP2],
                    [TGI],true)

public var __scene=TGS

let __glbrefresh=ViewRefresher()

public var WIDTH = 1000, HEIGHT = 1000


public let range=[
    [0,1],
    [10,2],
    [50,1.5],
    [100,1.2],
    [200,1],
    [500,0.8],
    [1000,0.5]
]

// Combined From: MISTOpen.swift
//
//  MISTOpen.swift
//  MIST_v2
//
//  Created by Wenqing Ge on 2021/2/20.
//
//  Mainly helper functions that are used in Creative Mode
import Foundation
import CoreGraphics
import PlaygroundSupport

/// Create a person
public func MISTPerson(x: CGFloat, y: CGFloat, requiredHappiness: Int, requiredEnvironment: Int, name: String) -> Person{
    return Person(x: x, y: y, requiredHappiness: requiredHappiness, requiredEnvironment: requiredEnvironment, name: name)
}

/// Create a facility with circle detection shape
public func MISTItemCircle(name: String, image: String, cost: Int, provideHappiness: Int, consumeEnvironment: Int, radius: CGFloat) -> Item{
    return Item(name: name, image: image, type: 1, cost: cost, provideHP: provideHappiness, consumeEnv: consumeEnvironment, rA: radius, rB: 0)
}

/// Create a facility with diamond dection shape
public func MISTItemDiamond(name: String, image: String, cost: Int, provideHappiness: Int, consumeEnvironment: Int, radius: CGFloat) -> Item{
    return Item(name: name, image: image, type: 2, cost: cost, provideHP: provideHappiness, consumeEnv: consumeEnvironment, rA: radius, rB: 0)
}

/// Create a facility with square dection shape
public func MISTItemSquare(name: String, image: String, cost: Int, provideHappiness: Int, consumeEnvironment: Int, length: CGFloat) -> Item{
    return Item(name: name, image: image, type: 3, cost: cost, provideHP: provideHappiness, consumeEnv: consumeEnvironment, rA: length, rB: 0)
}

/// Create a facility with custom dection shape
public func MISTItemCustom(name: String, image: String, cost: Int, provideHappiness: Int, consumeEnvironment: Int, arg: @escaping (Person) -> Bool) -> Item{
    return Item(name: name, image: image, type: 4, cost: cost, provideHP: provideHappiness, consumeEnv: consumeEnvironment, rA: 0, rB: 0).setRC(arg: arg)
}

/// Create a game scene
public func MISTGameScene(badget: Int, people: [Person], availableItem: [Item]) -> GameScene{
    return GameScene(badget, people, availableItem, false)
}

/// Start a scene
public func startMISTScene(scene: GameScene, sceneName: String){
    __scene=scene
    __scene.townName=sceneName
//    __scene.supportMotionControl=supportMotionControl
    
    PlaygroundPage.current.setLiveView(ContentView())
}

// Combined From: GameScene.swift
//
//  GameScene.swift
//  MIST_v2
//
//  Created by Wenqing Ge on 2021/2/23.
//

import Foundation
import CoreGraphics

public class GameScene{
    /// Current used money
    public var money:Int=0
    /// Budget of the user
    public var maxmoney:Int
    
    /// People in the scene
    public var people:[Person]
    /// Placed item in the scene
    public var placedItem:[Item]=[]
    /// Current Chosen Item. `NilItem` if not chosen
    public var chosenItem:Item=NilItem
    /// Available items
    public var availableItem:[Item]
    
    var error=""
    var firstLoad=true
    
    var uiOffset:CGFloat = 0
    
    /// Whether motion control is supported
    public var supportMotionControl = false
    
    /**
     Left is negative right is positive, in radians
     */
    var rotationLR:Double = 0
    /**
     Down is positive, up is negative, in radians
     */
    var rotationUD:Double = 0
    
    public var townName: String = "Unnamed MIST Scene"
    
    public func getHelped() -> Int{
        var ok=0
        for i in __scene.people{
            if i.hpUI >= Double(i.requiredHappiness) && i.envUI <= i.requiredEnvironment{
                ok+=1
            }
        }
        
        return ok
    }
    
    public func resize(length: Int){
        let width = CGFloat(length)
        let height = CGFloat(length)
        
        for i in people{
            i.x=i.x/CGFloat(WIDTH)*width
            i.y=i.y/CGFloat(HEIGHT)*height
        }
        
        for i in availableItem{
            i.rA=i.rA/CGFloat(WIDTH)*width
        }
        
        WIDTH = length
        HEIGHT = length
    }
    
    public init(_ maxmoney:Int, _ people:[Person],_ availableItem:[Item],_ motionControl: Bool){
        self.people=people
        self.maxmoney=maxmoney
        self.availableItem=availableItem
        self.supportMotionControl=motionControl
    }
}

// Created: ItemScene.swift
//
// 2021/2/28

class ItemBarNode: SKNode{
    var item: Item
    var dis: SKLabelNode
    
    init(item: Item){
        self.item=item
        self.dis=SKLabelNode()
        super.init()
        
        self.dis.text=item.image
        self.dis.alpha=(item==__scene.chosenItem ? 1 : 0.5)
        addChild(dis)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ItemScene: SKScene{
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else{
            return //Touch unavailable
        }
        
        let loc = touch.location(in: self)
        
        //check if move
        let cur=self.atPoint(loc)
        
        if cur.parent is ItemBarNode{
            let x=cur.parent as! ItemBarNode
            __scene.chosenItem=x.item
            __glbrefresh.reloadView("")
        }
    }
    
    override func didMove(to view: SKView){
        var pos=30
        for i in __scene.availableItem{
            let item=ItemBarNode(item: i)
            item.position=CGPoint(x: pos, y: 10)
            pos+=50
            
            addChild(item)
        }
    }
}
// Combined From: MISTScene.swift
//
//  MISTScene.swift
//  MIST_v2
//
//  Created by Wenqing Ge on 2021/1/23.
//

import Foundation
import SpriteKit

class MISTScene : SKScene{
    var item=SKNode()
    var person=SKNode()
    
    var bg: SKSpriteNode = SKSpriteNode(imageNamed: "lake")
    var bg2: [SKSpriteNode] = []
  
    var lbl: SKLabelNode = SKLabelNode()
    
    var centerNode = MISTCenterNode()
    
//
    override func didMove(to view: SKView) {
        if(__scene.supportMotionControl && __scene.firstLoad){
            logMotion()
        }
        
        item.name="Item"
        person.name="Person"
        
        bg.size=CGSize(width: WIDTH+100, height: HEIGHT)
        bg.anchorPoint = .zero
        bg.position=CGPoint(x: -50, y: 0)
        
        addChild(bg)
        
        if(__scene.supportMotionControl){
            addChild(centerNode)
        }
        
        makeScrollingBG()
        
        addChild(item)
        addChild(person)
        loadScene(animated: __scene.firstLoad)
        
        lbl.position=CGPoint(x: 0, y: 0)
        lbl.horizontalAlignmentMode = .left
        lbl.text=__scene.townName
        
        addChild(lbl)
    }

    let BGBLK:CGFloat = 48
    
    func makeScrollingBG(){
        let ok = __scene.getHelped() == __scene.people.count
        
        for i in stride(from: CGFloat(-64), through: CGFloat(WIDTH), by: BGBLK){
            for j in stride(from: CGFloat(-64), through: CGFloat(HEIGHT), by: BGBLK){
                let node=SKSpriteNode(imageNamed: "dot")
                node.anchorPoint = .zero
                node.position = CGPoint(x: i + __scene.uiOffset, y: j + __scene.uiOffset)
                node.size = CGSize(width: 32, height: 32)
                node.color = (ok ? SKColor.green : SKColor.yellow)
                node.colorBlendFactor = 0.2
//                node.blendMode =
                node.alpha = 0.5
                bg2.append(node)
                addChild(node)
            }
        }
    }
    
    func calcOffset(_ val: Double) -> CGFloat{
        let pi:Double = .pi/2
        let v=min(pi, max(-pi,val))
        return CGFloat(v/pi*100)
    }
    
    override func update(_ currentTime: TimeInterval) {
        __scene.uiOffset = __scene.uiOffset+1
        
        for i in bg2{
            i.run(SKAction.moveBy(x: 1, y: 1, duration: 0))
        }
        
        if __scene.uiOffset == BGBLK{
            __scene.uiOffset -= BGBLK
            for i in bg2{
                i.run(SKAction.moveBy(x: -BGBLK, y: -BGBLK, duration: 0))
            }
        }
        
        centerNode.position=CGPoint(x: calcOffset(__scene.rotationLR) + CGFloat(WIDTH/2), y: calcOffset(__scene.rotationUD) + CGFloat(HEIGHT/2))
        updateHumanLayer()
    }
    
    func updateHumanLayer(){
        if __scene.supportMotionControl{
            for i in __scene.people{
                let layer=centerNode.getLayer(i)
                if layer != i.layer{
                    //manual update happiness
                    var sm=0
                    for j in __scene.placedItem{
                        if j.isCollide(p: i){
                            sm+=j.provideHP
                        }
                    }
                    i.hpUI=(Double(sm)*range[layer][1])
                    i.layer=layer
                    
                    __glbrefresh.reloadView("")
                }
            }
        }
    }
    
    func loadScene(animated: Bool){
        
        __scene.firstLoad=false
        
        for i in __scene.people{
            addPerson(p: i, animate: animated)
        }
        
        for i in __scene.placedItem{
            addItem(i: i, animate: false)
        }
    }
    
    func addPerson(p:Person, animate: Bool){
        let node=MISTPersonNode(p: p)
        
        person.addChild(node)
        
//        node.run(SKAction.repeatForever(SKAction.moveBy(x: 10, y: 10, duration: 5)))
        if animate{
            node.setScale(0)
            let action=SKAction.scale(to: 1, duration: 0.3)
            action.timingMode = .easeInEaseOut
            node.run(action)
        }
        
    }

    func addItem(i:Item, animate: Bool){
        let node=MISTItemNode(p: i)
        
        item.addChild(node)
        
        if animate{
            node.setScale(0)
            let action=SKAction.scale(to: 1, duration: 0.3)
            action.timingMode = .easeInEaseOut
            node.run(action)
        }
    }
    
    func distance(a:CGFloat,b:CGFloat,c:CGFloat,d:CGFloat) -> CGFloat{
        return sqrt(pow(c-a, 2)+pow(d-b,2))
    }
    
    let DISMIN:CGFloat = 30.0
    
    func checkDis(_ x: CGFloat, _ y: CGFloat) -> Bool{
        for i in __scene.placedItem{
            if distance(a: x,b: y,c: i.x,d: i.y) <= DISMIN{
                return false
            }
        }
        
        for i in __scene.people{
            if distance(a: x,b: y,c: i.x,d: i.y) <= DISMIN{
                return false
            }
        }
        
        return true
    }
    
    var moveElement:MISTItemNode?=nil
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let ele=moveElement else{
            return
        }
        
        ele.setScale(1)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let ele=moveElement else {
            return
        }
        
        guard let touch = touches.first else{
            return
        }
        
        ele.position=touch.location(in: self)
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let ele=moveElement else{
            return
        }
        
        guard let touch = touches.first else{
            return
        }
        
        moveElement=nil
        
        let loc=touch.location(in: self)
        
        if loc.x>CGFloat(WIDTH) || loc.x<0 || loc.y>CGFloat(HEIGHT) || loc.y<0{
            //this will remove the item
            __glbrefresh.reloadView("\(ele.item.name) was removed")
//            run(SKAction.playSoundFileNamed("remove", waitForCompletion: false))
            return
        }
        
        if checkDis(loc.x,loc.y) == false{
            placeItem(loc: CGPoint(x: ele.item.x,y: ele.item.y), item: ele.item)
            __glbrefresh.reloadView("Facility too close to human/facility")
            return
        }
        
        placeItem(loc: loc, item: ele.item)
//        fatalError("Cannot find given item")
    }
    
    /**
        This function will place down an item. Showing errors if not possible
     */
    func placeItem(loc: CGPoint, item: Item){
        if __scene.money + item.cost > __scene.maxmoney{
            __glbrefresh.reloadView("Not enough badget")
            return
        }
        
        let cp=item.copy()
        cp.id=UUID()
        cp.x=loc.x
        cp.y=loc.y
        
        if checkDis(cp.x,cp.y) == false{
            __glbrefresh.reloadView("Facility too close to human/facility")
            return
        }
        
        __scene.placedItem.append(cp)
        __scene.money+=item.cost
    
        addItem(i: cp, animate: true)
        
        //change people's information
        for i in 0..<__scene.people.count{
            let p=__scene.people[i]
            if cp.isCollide(p: __scene.people[i]){
                p.hpUI+=Double(cp.provideHP)*range[p.layer][1]
                p.envUI+=cp.consumeEnv
                
                if p.hpUI>=Double(p.requiredHappiness){
//                    run(SKAction.playSoundFileNamed("success", waitForCompletion: false))
                }
            }
        }
        
//        run(SKAction.playSoundFileNamed("place", waitForCompletion: false))
        
        __glbrefresh.reloadView("")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        guard let touch = touches.first else{
            return //Touch unavailable
        }
        
        let loc = touch.location(in: self)
        
        //check if move
        let cur=self.atPoint(loc)
        if cur.parent is MISTItemNode && cur is SKLabelNode{
            //a move is detected
            moveElement=(cur.parent as! MISTItemNode)
            let ele=moveElement!
            
            for i in 0..<__scene.placedItem.count{
                let obj=__scene.placedItem[i]
                if obj.id==ele.item.id{
                    __scene.money-=ele.item.cost
                    
                    //change people's information
                    for j in 0..<__scene.people.count{
                        if ele.item.isCollide(p: __scene.people[j]){
                            __scene.people[j].hpUI-=Double(ele.item.provideHP)*range[__scene.people[j].layer][1]
                            __scene.people[j].envUI-=ele.item.consumeEnv
                        }
                    }
                    
                    __scene.placedItem.remove(at: i)
                    break
                }
            }
            
            cur.run(SKAction.scale(to: 2, duration: 0.1))
            
            
            return
        }
        
        if cur.parent is MISTPersonNode{
            //a view information is clicked
            let move=cur.parent as! MISTPersonNode
            
            __glbrefresh.reloadView(show: move.person)
            
            return
        }
        
        if __scene.chosenItem == NilItem{
            __glbrefresh.reloadView("Please select a facility first")
            
            return //Nil Item. Don't want to place it anyway
        }
        //place item instead
        placeItem(loc: loc, item: __scene.chosenItem)
    }
    
}

// Combined From: ItemInfoView.swift
//
//  ItemInfoView.swift
//  MIST_v2
//
//  Created by Wenqing Ge on 2021/2/18.
//

import SwiftUI

struct ItemInfoView: View {
    var item: Item
    
    var body: some View {
        VStack(alignment:.leading){
            Text("\(item.image) \(item.name)")
                .font(.largeTitle)
                .bold()
            Text(item.desc)
                .font(.caption)
            if item != NilItem{
                Text("💸Cost: \(item.cost)")
                .font(.title2)
                Text("💮Offer Happiness: \(item.provideHP)")
                    .font(.title2)
                Text("♻️Damage to the ENV: \(item.consumeEnv)")
                    .font(.title2)
                if item.type==1{
                    Text("⭕️Detection: Circle")
                        .font(.title2)
                    Text("🔆Radius:\(item.rA)")
                        .font(.title2)
                    Text("Count if the person's Euclidean distance to this node is smaller than radius")
                        .italic()
                        .font(.footnote)
                }else if item.type==2{
                    Text("🚸Detection: Diamond")
                        .font(.title2)
                    Text("🔆Radius:\(item.rA)")
                        .font(.title2)
                    Text("Count if the person's Manhattan distance to this node is smaller than radius")
                        .italic()
                        .font(.footnote)
                }else if item.type==3{
                    Text("🅾️Detection: Square")
                        .font(.title2)
                    Text("🔆Length:\(item.rA)")
                        .font(.title2)
                    Text("Count if the person's Chebyshev distance to this node is smaller than length")
                        .italic()
                        .font(.footnote)
                }else{
                    Text("❔Detection: Custom")
                        .font(.title2)
                    Text("A custom detection function is used. No range will be displayed")
                        .italic()
                        .font(.footnote)
                }
            }
        }.padding()
    }
}



// Combined From: ContentView.swift
//
//  ContentView.swift
//  MIST_v2
//
//  Created by Wenqing Ge on 2021/1/23.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    var game: SKScene {
        let scene = MISTScene()
        scene.size = CGSize(width: WIDTH, height: HEIGHT)
        scene.scaleMode = .fill
        return scene
    }

    var item: SKScene{
        let scene = ItemScene()
        scene.size = CGSize(width: WIDTH, height: 60)
        scene.scaleMode = .fill
        return scene
    }
    
    @ObservedObject var model=__glbrefresh
    
    @State var show2: Bool = false
    @State var itemTD: Item? = nil
    
    func getStatus() -> String{
        let ok=__scene.getHelped()
        
        if ok==__scene.people.count{
            return "✅ Scene cleared!"
        } else {
            return "\(ok)/\(__scene.people.count) helped"
        }
    }
    var body: some View {
        VStack{
            Text("Budget Used:$\(__scene.money)/\(__scene.maxmoney)")
            
//            HStack(alignment:.center){
//                ForEach(__scene.availableItem, id:\.self){
//                    item in
//
//                    ItemView(item: item, chosen: __scene.chosenItem)
//                        .onTapGesture{
//                            withAnimation{
//                                __scene.chosenItem=item
//                            }
//                            model.reloadView("")
//                        }
//                        .onLongPressGesture(minimumDuration: 0.5){
//                            model.toPresent=item
//                            model.mode=1
//                            model.present=true
//                            model.objectWillChange.send()
//                        }
//
//                }
//            }
            
            SpriteView(scene: item)
                .frame(width: CGFloat(WIDTH), height: 60)
                .edgesIgnoringSafeArea(.all)
            
            
            ItemInfoView(item: __scene.chosenItem).animation(.default)

            
            Text("\(getStatus())")
                .animation(.default)
            
            Spacer()
            SpriteView(scene: game)
                .frame(width: CGFloat(WIDTH), height: CGFloat(HEIGHT))
                .edgesIgnoringSafeArea(.all)
            
            Text("\(__scene.error)")
                .foregroundColor(.red)
            Spacer()
        }
        .sheet(isPresented: $model.present, content: {
            
            if model.mode == 1{
                ItemInfoView(item: model.toPresent!)
            } else {
                PersonInfoView(person: model.toShow!)
            }
        })
    }
}

