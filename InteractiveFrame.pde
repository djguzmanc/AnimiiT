public class InteractiveFrame extends Node {
    public InteractiveFrame( Scene s ) {
        super( s );
    }

    // this one gotta be overridden because we want a copied frame (e.g., line 141 above, i.e.,
    // scene.eye().get()) to have the same behavior as its original.
    protected InteractiveFrame( Graph otherGraph, InteractiveFrame otherFrame ) {
        super( otherGraph, otherFrame );
    }

    @Override
    public InteractiveFrame get( ) {
        return new InteractiveFrame( this.graph(), this );
    }

    // behavior is here :P
    @Override
    public void interact( MotionEvent event ) {
        switch ( event.shortcut( ).id( ) ) {
        case PApplet.LEFT:
            rotate( event );
            break;
        case PApplet.RIGHT:
            translate( event );
            break;
        case processing.event.MouseEvent.WHEEL:
            if ( isEye( ) && graph( ).is3D( ) )
                translateZ( event );
            else
                scale( event );
            break;
        }
    }
}