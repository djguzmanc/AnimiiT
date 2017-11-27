class ButtonHandler {
    
    CopyOnWriteArrayList<Button> buttons;
    
    public ButtonHandler( ) {
        buttons = new CopyOnWriteArrayList<Button>( );
    }
    
    void draw( ) {
        for ( Button b : buttons ) 
            b.drawButton( );
    }
    
    Button addButton( Button b ) {
        buttons.add( b );
        return b;
    }
    
    void clickEvent( float mX, float mY ) {
        for ( Button b : buttons ) {
            if ( b.mouseIn( mX, mY ) ) {
                buttonEventHandler( b );
                return;
            }
        }
    }
    
    void mousePressed( float mX, float mY ) {
        for ( Button b : buttons ) 
            if ( b.mouseIn( mX, mY ) )
                b.setHover( true );
            else
                b.setHover( false );
    }
    
    void mouseReleased( ) {
        for ( Button b : buttons )
            b.setHover( false );
    }
    
}