class TimeLinePicker {
    
    PVector position;
    public TimeLinePicker( PVector position ) {
        this.position = position;
    }
    
    void draw( PGraphics pg ) {
        pg.pushStyle( );
        pg.fill( 255, 0, 0 );
        pg.quad( position.x - 4, position.y, position.x, position.y - 4, position.x + 4, position.y, position.x, position.y + 4 );
        pg.stroke( 255, 0, 0 );
        pg.line( position.x, position.y, position.x, position.y + 10 );
        pg.popStyle( );
    }
    
    void move( float mX ) {
        mX -= timeLineScene.pg( ).width / 2;
        mX -= timeLineHandlerPos.x;
        
        if ( mX >= -480 && mX <= 180 ) {
            position.x = mX;
            float xPos = tlp.position.x + timeLineScene.pg( ).width / 2;
            float xNorm = ( xPos - iX ) / abs( iX - fX );
            for ( SpriteInstanceContainer sic : sih.spritesInstances ) {
                sic.itpr.setTime( xNorm );
                sic.itpr.start( );
                sic.itpr.stop( );
            }
        }
    }
    
    boolean mouseIn( float mX, float mY ) {
        
        mX -= timeLineScene.pg( ).width / 2;
        mY -= timeLineScene.pg( ).height / 2;
        mX -= timeLineHandlerPos.x;
        mY -= timeLineHandlerPos.y - 50;
        
        if ( mX >= position.x - 4 && mX <= position.x + 4 && mY >= position.y - 4 && mY <= position.y + 4 )
            return true;
        return false;
    }
}