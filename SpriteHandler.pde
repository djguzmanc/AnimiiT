class SpriteHandler {
    
    PVector position;
    CopyOnWriteArrayList<SpriteContainer> sprites;
    
    float targetScroll;
    float currentScroll;
    
    public SpriteHandler( float x, float y ) {
        position = new PVector( x, y );
        sprites = new CopyOnWriteArrayList<SpriteContainer>( );
        targetScroll = 0;
        currentScroll = 0;
    }
    
    void addSpriteContainer( PImage img, String name, ButtonHandler bh ) {
        float resizeFactor;
        if ( img.width > img.height )
            resizeFactor = 40.0 / img.width;
        else
            resizeFactor = 40.0 / img.height;
            
        img.resize( ( int ) ( img.width * resizeFactor ), ( int ) ( img.height * resizeFactor ) );
        SpriteContainer sc = new SpriteContainer( name, img, position.x + 2, position.y + 50 * 1.15 * sprites.size( ) + 10, bh );
        sprites.add( sc );
    }
    
    void emptySpriteList( ) {
        sprites = new CopyOnWriteArrayList<SpriteContainer>( );
    }
    
    void draw( PGraphics pg ) {
        pg.pushStyle( );
        
        pg.translate( 0, currentScroll );
        
        pg.fill( 150 );
        pg.noStroke( );
        pg.rect( position.x, position.y, spriteScene.pg( ).width - 2, spriteHandlerContent.height + 50 * sprites.size( ) );
        
        if ( sprites.size( ) == 0 ) {
            pg.textAlign( CENTER, CENTER );
            pg.fill( 0 );
            pg.text( "You haven't selected any sprites folder", position.x, position.y, spriteScene.pg( ).width - 2, spriteHandlerContent.height );
        }
        
        for ( int i = 0; i < sprites.size( ); i++ )
            sprites.get( i ).draw( pg );
            
        pg.popStyle( );
        
        if ( abs( currentScroll - targetScroll ) < 2 )
            return;
        if ( currentScroll > targetScroll )
            currentScroll -= 4;
        else
            currentScroll += 4;
    }
    
    boolean mouseIn( float mX, float mY ) {
        if ( mX >= spriteHandlerPos.x && mX <= spriteHandlerPos.x + spriteHandlerContent.width )
            if ( mY >= spriteHandlerPos.y && mY <= spriteHandlerPos.y + spriteHandlerContent.height )
                return true;
        return false;
    }
    
    void scrollUp( ) {
        if ( position.y + 50 * 1.15 * sprites.size( ) + 10 + targetScroll > spriteHandlerContent.width + 40 )
            targetScroll -= 12;
    }
    
    void scrollDown( ) {
        if ( targetScroll < 0 )
            targetScroll += 12;
    }
}