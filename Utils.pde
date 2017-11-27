void folderSelected( File selection ) {
    if ( selection == null ) {
        println( "Window was closed or the user hit cancel." );
    } else {
        println( "User selected " + selection.getAbsolutePath( ) );
        spritesFolderPath = selection.getAbsolutePath( );
        final File folder = new File( selection.getAbsolutePath( ) );
        listFilesForFolder( folder );
    }
}

public void listFilesForFolder( final File folder ) {
    sh.emptySpriteList( );
    for ( final File fileEntry : folder.listFiles( ) )
        if ( !fileEntry.isDirectory( ) ) {
            String nameData[] = fileEntry.getName( ).split( "[.]+" );
            if ( nameData[ nameData.length - 1 ].equals( "png" ) ||
                    nameData[ nameData.length - 1 ].equals( "jpg" ) ||
                        nameData[ nameData.length - 1 ].equals( "tga" ) ||
                            nameData[ nameData.length - 1 ].equals( "gif" ) ) {
                                sh.addSpriteContainer( loadImage( folder.getName( ) + "/" + fileEntry.getName( ) ), fileEntry.getName( ), bh );
                            }
            else
                println( "File " + fileEntry.getName( ) + " type not supported. Ignoring..." );
        }
}