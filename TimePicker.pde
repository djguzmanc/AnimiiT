class TimePicker {
    
    PVector position;
    int index;
    InteractiveFrame iFrame;
    float time;
    boolean selected;
    
    public TimePicker( PVector position, int index, InteractiveFrame iFrame, float time ) {
        this.position = position;
        this.index = index;
        this.iFrame = iFrame;
        this.time = time;
        selected = false;
    }
    
    void draw( PGraphics pg, float yCoor ) {
        position.y = yCoor;
        pg.pushStyle( );
        if ( !selected )
            pg.fill( 255, 0, 0 );
        else
            pg.fill( 0, 255, 0 );
        pg.stroke( 0 );
        pg.quad( position.x - 4, yCoor, position.x, yCoor - 4, position.x + 4, yCoor, position.x, yCoor + 4 );
        pg.popStyle( );
    }
    
    boolean mouseIn( float mX, float mY ) {
        if ( mX - timeLineHandlerPos.x >= position.x - 4 && mX - timeLineHandlerPos.x <= position.x + 4 )
            if ( mY - timeLineHandlerPos.y >= position.y - 4 && mY - timeLineHandlerPos.y <= position.y + 4 )
                return true;
        return false;
    }
    
}