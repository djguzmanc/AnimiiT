class Button {
    
    PGraphics pg;
    
    PVector position;
    PVector size;
    
    String label;
    
    color backgroundColor;
    color pressedColor;
    color fontColor;
    
    int round;
    
    boolean pressed;
    
    public Button( PGraphics pg, String label, float x, float y, float width, float height, color backgroundColor, color pressedColor, color fontColor, int round ) {
        this.pg = pg;
        this.label = label;
        position = new PVector( x, y );
        size = new PVector( width, height );
        this.backgroundColor = backgroundColor;
        this.pressedColor = pressedColor;
        this.fontColor = fontColor;
        pressed = false;
        this.round = round;
    }
    
    public Button( float x, float y ) {
        position = new PVector( x, y );
        size = new PVector( 100, 30 );
        backgroundColor = color( 180 );
        pressedColor = color( 100 );
        fontColor = color( 0 );
        label = "Button";
        pressed = false;
        round = 15;
    }
    
    void drawButton( ) {
        pg.beginDraw( );
        pg.pushStyle( );
        
        if ( pg == spriteHandlerContent )
            pg.translate( 0, sh.currentScroll );
        
        pg.noStroke( );
        if ( !pressed )
            pg.fill( backgroundColor );
        else
            pg.fill( pressedColor );
            
        pg.rect( position.x, position.y, size.x, size.y, round );
        
        pg.textAlign( CENTER, CENTER );
        pg.fill( fontColor );
        pg.text( label, position.x, position.y - 2, size.x, size.y );
        
        pg.popStyle( );
        pg.endDraw( );
    }
    
    void setHover( boolean a ) {
        pressed = a;
    }
    
    boolean mouseIn( float mX, float mY ) {
        
        if ( pg == animScene.pg( ) ) {
            mX -= animCanvasPos.x;
            mY -= animCanvasPos.y;
        }
        else if( pg == spriteScene.pg( ) ) {
            mX -= spriteCanvasPos.x;
            mY -= spriteCanvasPos.y;
        }
        else if ( pg == spriteHandlerContent ) {
            if ( !sh.mouseIn( mX, mY ) )
                return false;
                
            mX -= spriteHandlerPos.x;
            mY -= spriteHandlerPos.y;
            mY -= sh.currentScroll;
        }
        else if( pg == timeLineScene.pg( ) ) {
            mX -= timeLineCanvasPos.x;
            mY -= timeLineCanvasPos.y;
        }
        
        if ( mX >= position.x && mX <= position.x + size.x
                && mY >= position.y && mY <= position.y + size.y )
                    return true;
        return false;
    }
}