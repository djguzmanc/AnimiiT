void buttonEventHandler( Button b ) {
    if ( b == fs ) {
        selectFolder( "Select the folder with the sprites:", "folderSelected" );
    } if ( b == createFrame ) {
        if ( currentSIC != null ) {
            float xPos = tlp.position.x + timeLineScene.pg( ).width / 2;
            float xNorm = ( xPos - iX ) / abs( iX - fX );
            
            currentSIC.addNewFrame( new PVector( xPos, 0 ), xNorm );
        }
    } if ( playAnim == b ) {
        sih.startAllInterpolators( );
    } if ( stopAnim == b ) {
        sih.stopAllInterpolators( );
    } if ( scaleUp == b ) {
        if ( currentSIC != null ) {
            ssh.iFrame.scale( 1.1 );
        }
    } if ( scaleDown == b ) {
        if ( currentSIC != null ) {
            ssh.iFrame.scale( 0.9 );
        }
    } else {
        for ( SpriteContainer sc : sh.sprites ) {
            if ( sc.addInstance == b ) {
                if ( currentSIC == null )
                    sih.addSpriteInstance( new SpriteInstanceContainer( sc.name ) );
                else
                    currentSIC.addChild( new SpriteInstanceContainer( sc.name ) );
                return;
            }
        }
    }
}