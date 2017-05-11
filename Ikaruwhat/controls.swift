//
//  controls.swift
//  Ikaruwhat

import SpriteKit

enum PlayerMovementDirection { case left, right, none }
enum PlayerBattleCommand      { case fire, swap, fire_swap, bomb, fire_bomb, none }

var currentMovementInput = PlayerMovementDirection.none
var currentCommandInput  = PlayerBattleCommand.none

class MoveLeftButton: SKSpriteNode {
  
  init(color: SKColor, size: CGSize) {
    super.init(texture: nil, color: color, size: size)
    isUserInteractionEnabled = true
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      currentMovementInput = .left
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    currentMovementInput = .none
  }
  
  required init?(coder aDecoder: NSCoder) { fatalError() }
};

class MoveRightButton: SKSpriteNode {
  
  init(color: SKColor, size: CGSize) {
    super.init(texture: nil, color: color, size: size)
    isUserInteractionEnabled = true
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      currentMovementInput = .right
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    currentMovementInput = .none
  }
  
  required init?(coder aDecoder: NSCoder) { fatalError() }
};

class FireButton: SKSpriteNode {
  
  private var fingerIsCentered = true
  private var startingPosition = CGPoint.zero
  private let dragDistance     = CGFloat(5)
  
  init(color: SKColor, size: CGSize) {
    super.init(texture: nil, color: color, size: size)
    isUserInteractionEnabled = true
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    if let touch = touches.first {
      startingPosition = touch.location(in: self)
      currentCommandInput = .fire
    }
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let touch = touches.first else { return }
    
    let pos = touch.location(in: self)
    
    maybeCenterFinger: do {
      
      if fingerIsCentered { continue }
      
      var yIsGood = false
      var xIsGood = false
      
      if pos.y <= startingPosition.y + dragDistance && pos.y >= startingPosition.y - dragDistance {
        yIsGood = true
      }
      if pos.x <= startingPosition.x + dragDistance && pos.x >= startingPosition.x - dragDistance {
        xIsGood = true
      }
      
      if yIsGood && xIsGood { fingerIsCentered = true }
    }
    
    maybeFireAndSwap: do {
      if fingerIsCentered == false { continue }
      
      var doSwap = false
      
      if      pos.y >= startingPosition.y + dragDistance || pos.y <= startingPosition.y - dragDistance {
        doSwap = true
      }
      else if pos.x >= startingPosition.x + dragDistance || pos.x <= startingPosition.x - dragDistance {
        doSwap = true
      }
      
      if doSwap {
        fingerIsCentered    = false
        currentCommandInput = .fire_swap
      }
    }
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    fingerIsCentered = true
    startingPosition = CGPoint.zero
    currentCommandInput = .none
  }
  
}
  required init?(coder aDecoder: NSCoder) { fatalError() }
};

class ChangeColorButton: SKSpriteNode {
  
  init(color: SKColor, size: CGSize) {
    super.init(texture: nil, color: color, size: size)
    isUserInteractionEnabled = true
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    if currentCommandInput == .fire { currentCommandInput = .fire_swap }
    else { currentCommandInput = .swap }
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    if currentCommandInput == .fire { return }
    else { currentCommandInput = .none }
  }
  
  required init?(coder aDecoder: NSCoder) { fatalError() }
};

class BombButton: SKSpriteNode {
  
  init(color: SKColor, size: CGSize) {
    super.init(texture: nil, color: color, size: size)
    isUserInteractionEnabled = true
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
  }
  
  required init?(coder aDecoder: NSCoder) { fatalError() }
}
;


