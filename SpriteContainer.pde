class SpriteContainer {
    
    PImage img;
    PVector position;
    Button addInstance;
    String name;
    
    public SpriteContainer( String name, PImage img, float x, float y, ButtonHandler bh ) {
        this.name = name;
        this.img = img;
        position = new PVector( x, y );
        addInstance = bh.addButton( new Button( spriteHandlerContent, "+", position.x + 57, position.y + 5, 130, 15, 
            200, 255, 0, 0 ) );
    }
    
    void draw( PGraphics pg ) {
        pg.fill( 245 );
        pg.rect( position.x, position.y, 194, 50, 5 );
        
        pg.fill( 80 );
        pg.rect( position.x + 3, position.y + 2, 46, 46, 3 );

        pg.image( img, position.x + 8 + 18 - img.width / 2, position.y + 2 + 2 + 20 - img.height / 2 );
        
        pg.fill( 255 );
        pg.rect( position.x + 57, position.y + 5 + 20, 130, 15 );
        pg.textAlign( CENTER, CENTER );
        pg.fill( 0 );
        pg.text( name, position.x + 57, position.y + 2 + 20, 130, 15 );
    }
}