void spriteSceneDrawing( ) {
    pushStyle( );
    spriteScene.beginDraw( );
    
    spriteScene.pg( ).background( 240 );
    
    spriteScene.pg( ).noFill( );
    spriteScene.pg( ).stroke( 0 );
    spriteScene.pg( ).rect( -spriteScene.pg( ).width / 2, -spriteScene.pg( ).height / 2, spriteScene.pg( ).width, spriteScene.pg( ).height - 1 );
    
    spriteScene.pg( ).noStroke( );
    spriteScene.pg( ).fill( 210 );
    spriteScene.pg( ).rect( -spriteScene.pg( ).width / 2 + 1, -spriteScene.pg( ).height / 2, spriteScene.pg( ).width, 45 );
    
    spriteHandlerContent.beginDraw( );
    spriteHandlerContent.background( 0 );
    sh.draw( spriteHandlerContent );
    spriteHandlerContent.endDraw( );    
    
    spriteInstanceContent.beginDraw( );
    spriteInstanceContent.background( 0 );
    sih.draw( spriteInstanceContent );
    spriteInstanceContent.endDraw( );
    
    spriteScene.endDraw( );
    spriteScene.display( );
    popStyle( );
}