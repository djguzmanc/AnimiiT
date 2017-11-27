import remixlab.core.*;
import remixlab.input.*;
import remixlab.input.event.*;
import remixlab.input.event.KeyEvent;
import remixlab.primitives.*;
import remixlab.primitives.constraint.*;
import remixlab.proscene.*;
import remixlab.timing.*;


import java.util.concurrent.CopyOnWriteArrayList;
import java.util.LinkedList;
import java.io.File;

Scene animScene;
Scene timeLineScene;
Scene spriteScene;
Scene spriteStateScene;

ButtonHandler bh;
Button fs, createFrame, playAnim, stopAnim;
Button scaleUp, scaleDown;

SpriteHandler sh;
SpriteInstanceHandler sih;
SpriteInstanceContainer currentSIC;

PGraphics spriteHandlerContent;
PGraphics spriteInstanceContent;
PGraphics spriteStateHandlerContent;
PGraphics timeLineHandlerContent;

PVector spriteCanvasPos;
PVector timeLineCanvasPos;
PVector animCanvasPos;
PVector spriteHandlerPos;
PVector spriteInstanceHandlerPos;
PVector spriteStateHandlerPos;
PVector timeLineHandlerPos;

String spritesFolderPath;

SpriteStateHandler ssh;

TimeLinePicker tlp;

void setup( ) {
    size( 1200, 800, P3D );
    
    bh = new ButtonHandler( );
    
    PGraphics animCanvas = createGraphics( 1000, 600, P3D );
    PGraphics spriteCanvas = createGraphics( width - animCanvas.width, animCanvas.height ); 
    PGraphics timeLineCanvas = createGraphics( width, height - animCanvas.height );
    
    spriteHandlerContent = createGraphics( spriteCanvas.width, 250 );
    spriteInstanceContent = createGraphics( spriteCanvas.width, 300 );
    
    animCanvasPos = new PVector( );
    
    animScene = new Scene( this, animCanvas, ( int ) animCanvasPos.x, ( int ) animCanvasPos.y );
    InteractiveFrame eye = new InteractiveFrame( animScene );
    animScene.setRadius( 150 );
    animScene.setEye( eye );
    animScene.setDefaultNode( eye );
    animScene.fitBall( );
    animScene.pg( ).imageMode( CENTER );
    
    spriteCanvasPos = new PVector( animScene.pg( ).width, 0 );
    timeLineCanvasPos = new PVector( 0, animScene.pg( ).height );
    spriteHandlerPos = new PVector( animScene.pg( ).width + 1, 48 );
    spriteInstanceHandlerPos = new PVector( animScene.pg( ).width + 1, spriteHandlerPos.y + spriteHandlerContent.height + 1 );
    
    spriteScene = new Scene( this, spriteCanvas, ( int ) spriteCanvasPos.x, ( int ) spriteCanvasPos.y );
    spriteScene.inputHandler( ).removeGrabbers( );
    
    sh = new SpriteHandler( 0, 0 );
    sih = new SpriteInstanceHandler( 0, 0 );
    
    timeLineScene = new Scene( this, timeLineCanvas, ( int ) timeLineCanvasPos.x, ( int ) timeLineCanvasPos.y );
    timeLineScene.inputHandler( ).removeGrabbers( );
    
    spriteStateHandlerContent = createGraphics( 200, timeLineScene.pg( ).height - 4, P3D );
    spriteStateHandlerContent.imageMode( CENTER );
    
    spriteStateHandlerPos = new PVector( 800, 600 );
    spriteStateScene = new Scene( this, spriteStateHandlerContent, ( int ) spriteStateHandlerPos.x + 200, ( int ) spriteStateHandlerPos.y + 2 );
    
    timeLineHandlerPos = new PVector( 0, 650 );
    timeLineHandlerContent = createGraphics( 800, 150, P2D );
        
    fs = bh.addButton( new Button( spriteScene.pg( ), "Select sprites folder", 30, 10, 150, 25, 240, 136, 0, 0 ) );
    
    createFrame = bh.addButton( new Button( timeLineScene.pg( ), "Create picker!", 825, 30, 150, 30, color( 6, 81, 204 ), color( 115, 166, 251 ), 255, 0 ) );
    playAnim = bh.addButton( new Button( timeLineScene.pg( ), "Play Anim", 825, 70, 150, 30, color( 63, 183, 28 ), color( 167, 238, 147 ), 255, 10 ) );
    stopAnim = bh.addButton( new Button( timeLineScene.pg( ), "Stop Anim", 825, 110, 150, 30, color( 238, 40, 50 ), color( 241, 71, 86 ), 255, 10 ) );
    
    scaleUp = bh.addButton( new Button( timeLineScene.pg( ), "+", 845, 150, 50, 30, 160, 210, 0, 10 ) );
    scaleDown = bh.addButton( new Button( timeLineScene.pg( ), "-", 905, 150, 50, 30, 160, 210, 0, 10 ) );
    
    ssh = new SpriteStateHandler( spriteStateScene, null, new InteractiveFrame( animScene ), loadImage( "compass.png" ) );
    
    tlp = new TimeLinePicker( new PVector( -timeLineScene.pg( ).width / 2 + iX, -timeLineScene.pg( ).height / 2 + 40 ) );
    
    smooth( 1 );
    
    // provisional
    // spritesFolderPath = "C:/Users/User/Documents/Processing/ProsceneAnimator/data/enemySprites";
    // SpriteInstanceContainer a = sih.addSpriteInstance( new SpriteInstanceContainer( "body.png" ) );
    // a.addChild( new SpriteInstanceContainer( "arm.png" ) );
    // sih.addSpriteInstance( new SpriteInstanceContainer( "head.png" ) );
    
    // sih.startAllInterpolators( );
}

void draw( ) {
    
    int k = sih.whoIsInterpolating( );
    if ( k != -1 )
        tlp.position.x = sih.spritesInstances.get( k ).itpr.time( ) * abs( iX - fX ) + iX - timeLineScene.pg( ).width / 2;
    
    animScene.pg( ).smooth( 15 );
    animScene.beginDraw( );
    animScene.pg( ).background( 46 );
    animScene.drawAxes( );
    
    // Frame z = nodeInterpolator.frame( );
    // animScene.applyTransformation( z );
    
    for ( SpriteInstanceContainer sic : sih.spritesInstances )
        if ( !sic.isChild )
            sic.interpolate( animScene );
        
    // animScene.pg( ).ellipse( 0, -40, 20, 20 );
    // animScene.pg( ).rect( 0, 0, 20, 30 );
    
    animScene.endDraw( );
    animScene.display( );
    
    timeLineSceneDrawing( );
    spriteSceneDrawing( );
    
    spriteStateScene.beginDraw( );
    spriteStateScene.pg( ).background( 0 );
    //spriteStateScene.drawAxes( );
    spriteStateScene.traverse( );
    spriteStateScene.endDraw( );
    spriteStateScene.display( );
    
    bh.draw( );
    
    image( timeLineHandlerContent, timeLineHandlerPos.x, timeLineHandlerPos.y );
    image( spriteHandlerContent, spriteHandlerPos.x, spriteHandlerPos.y );
    image( spriteInstanceContent, spriteInstanceHandlerPos.x, spriteInstanceHandlerPos.y );
}