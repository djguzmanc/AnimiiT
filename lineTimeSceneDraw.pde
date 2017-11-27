int iX = 120, fX = 780;
int spaces = 20;

float timeLineCurrentScroll = 0;
float timeLineTargetScroll = 0;

void scrollUpTimeLine( ) {
    if ( timeLineHandlerContent.height + 25 * sih.spritesInstances.size( ) + 10 + timeLineTargetScroll > timeLineHandlerContent.height + 140 )
        timeLineTargetScroll -= 12;
}

void scrollDownTimeLine( ) {
    if ( timeLineTargetScroll < 0 )
        timeLineTargetScroll += 12;
}

void timeLineSceneDrawing( ) {
    timeLineScene.beginDraw( );
    timeLineScene.pg( ).background( 240 );
    
    timeLineScene.pg( ).fill( 15 );
    timeLineScene.pg( ).rect( 200, -timeLineScene.pg( ).height / 2, 400, timeLineScene.pg( ).height );
    
    timeLineScene.pg( ).fill( 255 );
    timeLineScene.pg( ).text( "Interpolation Controls", 215, -timeLineScene.pg( ).height / 2 + 15 );
    
    timeLineScene.pg( ).fill( 1, 17, 35 );
    timeLineScene.pg( ).noStroke( );
    timeLineScene.pg( ).rect( -timeLineScene.pg( ).width / 2, -timeLineScene.pg( ).height / 2, 800, 25 );
    timeLineScene.pg( ).fill( 255 );
    timeLineScene.pg( ).text( "Time line Controls", -timeLineScene.pg( ).width / 2 + 15, -timeLineScene.pg( ).height / 2 + 15 );
    
    // time line
    timeLineScene.pg( ).stroke( 0 );
    timeLineScene.pg( ).line( -timeLineScene.pg( ).width / 2 + iX, -timeLineScene.pg( ).height / 2 + 40, -timeLineScene.pg( ).width / 2 + fX, -timeLineScene.pg( ).height / 2 + 40 );
    
    for ( int i = iX; i <= fX; i += abs( iX - fX ) / spaces )
        timeLineScene.pg( ).line( -timeLineScene.pg( ).width / 2 + i, -timeLineScene.pg( ).height / 2 + 36, -timeLineScene.pg( ).width / 2 + i, -timeLineScene.pg( ).height / 2 + 44 );
    
    timeLineScene.pg( ).fill( 0 );
    timeLineScene.pg( ).text( "0", -timeLineScene.pg( ).width / 2 + iX - 3, -timeLineScene.pg( ).height / 2 + 34 );
    timeLineScene.pg( ).text( "1", -timeLineScene.pg( ).width / 2 + fX - 3, -timeLineScene.pg( ).height / 2 + 34 );
    
    tlp.draw( timeLineScene.pg( ) );
    
    timeLineHandlerContent.beginDraw( );
    timeLineHandlerContent.background( 255 );
    
    timeLineHandlerContent.translate( 0, timeLineCurrentScroll );
    
    for ( int i = 0; i < sih.spritesInstances.size( ); i++ ) {
        timeLineHandlerContent.stroke( 0 );
        timeLineHandlerContent.line( iX - 20, i * 25 + 20, fX, i * 25 + 20 );
        
        timeLineHandlerContent.noStroke( );
        timeLineHandlerContent.fill( 190 );
        timeLineHandlerContent.rect( 10, i * 25 + 10, 100, 20 );
        
        timeLineHandlerContent.textAlign( CENTER, CENTER );
        timeLineHandlerContent.fill( 0 );
        timeLineHandlerContent.text( sih.spritesInstances.get( i ).name.split( "[.]+" )[ 0 ], 10, i * 25 + 8, 100, 20 );
    }
    
    int minSize = sih.spritesInstances.size( );
    if ( minSize < 6 )
        minSize = 7;
    
    timeLineHandlerContent.stroke( 210 );
    for ( int j = iX; j <= fX; j += abs( iX - fX ) / spaces )
            for ( int k = -10; k < 25 * ( minSize + 1 ); k += 8 )
                timeLineHandlerContent.line( j, k, j, k + 5 );
                
    timeLineHandlerContent.stroke( 255, 0, 0 );
    for ( int k = -10; k < 25 * ( minSize + 1 ); k += 8 )
        timeLineHandlerContent.line( tlp.position.x + 600, k, tlp.position.x + 600, k + 5 );
        
    for ( int i = 0; i < sih.spritesInstances.size( ); i++ ) {
        for ( TimePicker tp : sih.spritesInstances.get( i ).pickers ) {
            tp.draw( timeLineHandlerContent, i * 25 + 20 );
        }
    }
    
    timeLineHandlerContent.endDraw( );
    
    timeLineScene.endDraw( );
    timeLineScene.display( );
    
    if ( abs( timeLineCurrentScroll - timeLineTargetScroll ) < 2 )
            return;
    if ( timeLineCurrentScroll > timeLineTargetScroll )
        timeLineCurrentScroll -= 4;
    else
        timeLineCurrentScroll += 4;
}