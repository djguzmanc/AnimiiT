class SpriteStateHandler extends NodeP5 {
    
    PImage sprite;
    InteractiveFrame iFrame;
    SpriteInstanceContainer sic;
    
    public SpriteStateHandler( Scene scene, SpriteInstanceContainer sic, InteractiveFrame iFrame, PImage img ) {
        super( scene );
        this.iFrame = iFrame;
        sprite = img;
        sprite.resize( 200, 200 );
        this.sic = sic;
    }
    
    void swapFrame( InteractiveFrame frame ) {
        iFrame = frame;
    }

    @Override
    public void interact( MotionEvent2 event ) {
        switch ( event.shortcut( ).id( ) ) {
        case LEFT:
            for ( SpriteInstanceContainer sic : sih.spritesInstances ) {
                sic.itpr.start( );
                sic.itpr.stop( );
            }
            rotateZ( event );
            iFrame.rotateZ( event );
            break;
        case RIGHT:
            for ( SpriteInstanceContainer sic : sih.spritesInstances ) {
                sic.itpr.start( );
                sic.itpr.stop( );
            }
            iFrame.translateX( event );
            iFrame.translateY( event );
            break;
         case processing.event.MouseEvent.WHEEL:
            // scaling bug!! event with 8 id is not captured
            iFrame.scale( event );
            break;
        }
    }

    @Override
    protected void display( PGraphics pg ) {
        pg.imageMode( CENTER );
        pg.image( sprite, 0, 0 );
        pg.fill( 255, 0, 0 );
        pg.textSize( 25 );
        pg.text( "N", -10, -100 );
    }
}