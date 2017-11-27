void keyPressed( ) {
    if ( key == CODED && currentSIC != null ) {
        if ( keyCode == UP )
            currentSIC.pivot.y -= 4;
        else if ( keyCode == DOWN )
            currentSIC.pivot.y += 4;
        else if ( keyCode == LEFT )
            currentSIC.pivot.x -= 4;
        else if ( keyCode == RIGHT )
            currentSIC.pivot.x += 4;
    }
}