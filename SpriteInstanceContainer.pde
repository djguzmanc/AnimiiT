class SpriteInstanceContainer {
    
    PImage imgIcon;
    PImage original;
    String name;
    
    boolean selected;
    PVector position;
    
    PVector screenPosition;
    CopyOnWriteArrayList<SpriteInstanceContainer> children;
    
    Interpolator itpr;
    CopyOnWriteArrayList<TimePicker> pickers;
    
    boolean isChild;
    
    float originalResizeTarget = 100;
    
    PVector pivot;
    
    // float z;
    
    // PGraphics spriteWrapper;
    
    public SpriteInstanceContainer( String name ) {
        this.name = name;
        imgIcon = loadImage( spritesFolderPath + "/" + name );
        float resizeFactor;
        if ( imgIcon.width > imgIcon.height )
            resizeFactor = 60.0 / imgIcon.width;
        else
            resizeFactor = 60.0 / imgIcon.height;
            
        imgIcon.resize( ( int ) ( imgIcon.width * resizeFactor ), ( int ) ( imgIcon.height * resizeFactor ) );
        original = loadImage( spritesFolderPath + "/" + name );
        
        selected = false;
        screenPosition = pivot = new PVector( 0, 0 );
        children = new CopyOnWriteArrayList<SpriteInstanceContainer>( );
        itpr = new Interpolator( animScene );
        pickers = new CopyOnWriteArrayList<TimePicker>( );
    
        //for ( int i = 0; i < head.length; i++ ) {
        //    frames.add( new InteractiveFrame( animScene ) );
        //    animScene.inputHandler( ).removeGrabber( frames.get( i ) );
        //}
        
        //// head path
        //frames.get( 0 ).setPosition( 5, 0 );
        //frames.get( 1 ).setPosition( 0, 0 );
        //frames.get( 2 ).setPosition( 5, 0 );
        
        //for ( int i = 0; i < head.length; i++ )
        //    itpr.addKeyFrame( frames.get( i ), 1.0 / 2 * i );
            
        //if ( name.equals( "arm.png" ) )
        //    pivot = new PVector( 0, -100 );
            
        ////itpr.start( );
        itpr.setLoop( );
        
        isChild = false;
        
        if ( original.width > original.height )
            resizeFactor = originalResizeTarget / original.width;
        else
            resizeFactor = originalResizeTarget / original.height;
        original.resize( ( int ) ( original.width * resizeFactor ), ( int ) ( original.height * resizeFactor ) );
        
        // z = random( -30, 30 );
        // spriteWrapper = createGraphics( original.width, original.height, P3D );
    }
    
    void _interpolate( Scene s, SpriteInstanceContainer si ) {
        s.pg( ).pushMatrix( );
        s.pg( ).fill( 0, 255, 0 );
        s.pg( ).ellipse( si.pivot.x, si.pivot.y, 5, 5 );
        s.pg( ).translate( si.pivot.x, si.pivot.y );
        s.applyTransformation( si.itpr.frame( ) );
        s.pg( ).image( si.original, si.screenPosition.x - si.pivot.x * 2, si.screenPosition.y - si.pivot.y * 2 );
        for ( SpriteInstanceContainer sic : si.children )
            _interpolate( s, sic );
        s.pg( ).translate( -si.pivot.x, -si.pivot.y );
        s.pg( ).popMatrix( );
    }
    
    void interpolate( Scene s ) {
        _interpolate( s, this );
    }
    
    void addChild( SpriteInstanceContainer si ) {
        si.isChild = true;
        children.add( si );
        sih.addSpriteInstance( si );
    }
    
    void setSelected( boolean a ) {
        selected = a;
        if ( a )
            currentSIC = this;
    }
    
    void draw( PGraphics pg, float x, float y ) {
        position = new PVector( x, y );
        pg.pushStyle( );
        
        if ( !selected )
            pg.fill( 245 );
        else
            pg.fill( 202, 220, 249 );
            
        pg.rect( x, y, 194, 70, 5 );
        
        pg.fill( 80 );
        pg.rect( x + 3, y + 2, 66, 66, 3 );

        pg.image( imgIcon, x + 8 + 28 - imgIcon.width / 2, y + 2 + 2 + 30 - imgIcon.height / 2 );
        
        pg.fill( 255 );
        pg.stroke( 0 );
        pg.rect( x + 94, y + 8, 40, 15 );
        pg.rect( x + 94, y + 8 + 15 + 4, 40, 15 );
        pg.rect( x + 94, y + 8 + 15 + 15 + 8, 40, 15 );
        
        pg.rect( x + 145, y + 7 + 10, 40, 15 );
        pg.rect( x + 145, y + 7 + 15 + 4 + 20, 40, 15 );
        
        pg.fill( 0 );
        pg.text( "X", x + 78, y + 8 + 12 );
        pg.text( "Y", x + 78, y + 8 + 12 + 15 + 4 );
        pg.text( "Z", x + 78, y + 8 + 12 + 15 + 15 + 8 );
        
        pg.textAlign( CENTER, CENTER );
        
        pg.textSize( 9 );
        
        pg.text( "Scale", x + 145, y - 8 + 10, 40, 15 );
        pg.text( "Rot", x + 145, y - 8 + 15 + 4 + 20, 40, 15 );
        
        pg.text( "0.0", x + 94, y + 8, 40, 15 );
        pg.text( "0.0", x + 94, y + 8 + 15 + 4, 40, 15 );
        pg.text( "0.0", x + 94, y + 8 + 15 + 15 + 8, 40, 15 );
        
        pg.text( "0.0%", x + 145, y + 7 + 10, 40, 15 );
        pg.text( "0.0º", x + 145, y + 7 + 15 + 4 + 20, 40, 15 );
        
        pg.popStyle( );
    }
    
    void addNewFrame( PVector position, float time ) {
        for ( TimePicker tp : pickers )
            if ( abs( time - tp.time ) < 0.0001 )
                return;
        
        int index = 0;
        while ( index < pickers.size( ) && time > pickers.get( index ).time )
            index++;
            
        InteractiveFrame nf = new InteractiveFrame( animScene );
            
        if ( index == pickers.size( ) ) {
            println( "added to final" );
            TimePicker tp = new TimePicker( position, pickers.size( ), nf, time );
            itpr.addKeyFrame( nf, time );
            pickers.add( tp );
        } else {
            println( "ups!" );
            while ( itpr.keyFrames( ).size( ) > 0 )
                itpr.removeKeyFrame( 0 );
                
            TimePicker tp = new TimePicker( position, index, nf, time );
            pickers.add( index, tp );
                
            for ( TimePicker t : pickers )
                itpr.addKeyFrame( t.iFrame, t.time );
        }
    }
    
    boolean mouseIn( float mX, float mY ) {
        if ( mX >= position.x && mX <= position.x + spriteInstanceContent.width )
            if ( mY >= position.y && mY <= position.y + 70 )
                return true;
        return false;
    }
}