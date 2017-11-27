boolean movingTlp = false;

void mouseClicked( ) {
    bh.clickEvent( mouseX, mouseY );
    boolean atLeastOne = false;
    if ( sih.mouseIn( mouseX, mouseY ) ) {
        for ( SpriteInstanceContainer sic : sih.spritesInstances )
            if ( sic.mouseIn( mouseX - spriteInstanceHandlerPos.x, mouseY - spriteInstanceHandlerPos.y - sih.currentScroll ) ) {
                sic.setSelected( true );
                currentSIC = sic;
                atLeastOne = true;
                //ssh.swapFrame( sic.frames.get( 1 ) );
            }
            else {
                sic.setSelected( false );
            }
            if ( !atLeastOne )
                currentSIC = null;
    }
    for ( SpriteInstanceContainer sic : sih.spritesInstances ) {
        for ( TimePicker tp : sic.pickers )
            if ( tp.mouseIn( mouseX, mouseY ) ) {
                tlp.move( tp.position.x );
                ssh.swapFrame( tp.iFrame );
                ssh.sic = sic;
                tp.selected = true;
            } else
                tp.selected = false;
    }
}

void mousePressed( ) {
    bh.mousePressed( mouseX, mouseY );
    if ( tlp.mouseIn( mouseX, mouseY ) )
        movingTlp = true;
}

void mouseDragged( ) {
    if ( movingTlp )
        tlp.move( mouseX );
}

void mouseReleased( ) {
    bh.mouseReleased( );
    movingTlp = false;
}

void mouseWheel( MouseEvent e ) {
    if ( sh.mouseIn( mouseX, mouseY ) ) {
        if ( e.getCount( ) > 0 ) {
            sh.scrollUp( );
        } else {
            sh.scrollDown( );
        }
    } else if ( sih.mouseIn( mouseX, mouseY ) ) {
        if ( e.getCount( ) > 0 ) {
            sih.scrollUp( );
        } else {
            sih.scrollDown( );
        }
    } else if ( mouseX - timeLineHandlerPos.x >= timeLineHandlerPos.x && mouseX - timeLineHandlerPos.x <= timeLineHandlerPos.x + timeLineHandlerContent.width ) { // mouse on time line handler
        if ( mouseY >= timeLineHandlerPos.y  && mouseY <= timeLineHandlerPos.y + timeLineHandlerContent.height )
            if ( e.getCount( ) > 0 ) {
                scrollUpTimeLine( );
            } else {
                scrollDownTimeLine( );
            }    
    }
}