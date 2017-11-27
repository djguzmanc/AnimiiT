class SpriteInstanceHandler {
    
    PVector position;
    CopyOnWriteArrayList<SpriteInstanceContainer> spritesInstances;
    
    float targetScroll;
    float currentScroll;
    
    public SpriteInstanceHandler( float x, float y ) {
        position = new PVector( x, y );
        spritesInstances = new CopyOnWriteArrayList<SpriteInstanceContainer>( );
        targetScroll = 0;
        currentScroll = 0;
    }
    
    SpriteInstanceContainer addSpriteInstance( SpriteInstanceContainer si ) {
        spritesInstances.add( si );
        return si;
    }
    
    void startAllInterpolators( ) {
        for ( SpriteInstanceContainer sic : spritesInstances )
            sic.itpr.start( );
    }
    
    void stopAllInterpolators( ) {
        for ( SpriteInstanceContainer sic : spritesInstances )
            sic.itpr.stop( );
    }
    
    int whoIsInterpolating( ) {
        for ( int i = 0; i < spritesInstances.size( ); i++ )
            if ( spritesInstances.get( i ).itpr.started( ) )
                return i;
        return -1;
    }
    
    void draw( PGraphics pg ) {
        pg.pushStyle( );
        
        pg.translate( 0, currentScroll );
        
        pg.fill( 6, 18, 38 );
        pg.noStroke( );
        pg.rect( position.x, position.y, spriteScene.pg( ).width - 2, spriteHandlerContent.height + 70 * spritesInstances.size( ) + 100 );
        
        if ( spritesInstances.size( ) == 0 ) {
            pg.textAlign( CENTER, CENTER );
            pg.fill( 255 );
            pg.text( "You haven't added any sprite instance", position.x, position.y, spriteScene.pg( ).width - 2, spriteHandlerContent.height );
        }
        
        for ( int i = 0; i < spritesInstances.size( ); i++ )
            spritesInstances.get( i ).draw( pg, position.x + 2, position.y + 60 * 1.25 * i + 10 );
            
        pg.popStyle( );
        
        if ( abs( currentScroll - targetScroll ) < 2 )
            return;
        if ( currentScroll > targetScroll )
            currentScroll -= 4;
        else
            currentScroll += 4;
    }
    
    boolean mouseIn( float mX, float mY ) {
        if ( mX >= spriteInstanceHandlerPos.x && mX <= spriteInstanceHandlerPos.x + spriteInstanceContent.width )
            if ( mY >= spriteInstanceHandlerPos.y && mY <= spriteInstanceHandlerPos.y + spriteInstanceContent.height )
                return true;
        return false;
    }
    
    void scrollUp( ) {
        if ( spriteHandlerContent.height + 70 * spritesInstances.size( ) + 100 + targetScroll > spriteInstanceContent.width + 300 )
            targetScroll -= 12;
    }
    
    void scrollDown( ) {
        if ( targetScroll < 0 )
            targetScroll += 12;
    }
}