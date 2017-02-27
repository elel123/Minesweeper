

import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs; //ArrayList of just the minesweeper buttons that are mined

public void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to declare and initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int r = 0; r < buttons.length; r++)
        for(int c = 0; c < buttons[r].length; c++)
            buttons[r][c] = new MSButton(r, c);    
    bombs = new ArrayList <MSButton>();

    for(int i=0;i<40;i++)
        setBombs();
}

public void setBombs()
{
    //your code
    int row = (int)(Math.random() * NUM_ROWS) ;
    int column = (int)(Math.random() * NUM_COLS);
    if(bombs.contains(buttons[row][column]) == false)
        bombs.add(buttons[row][column]);
    else 
    {
        setBombs();
    }

}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
    //your code here
}
public void displayWinningMessage()
{
    //your code here
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        //your code here
        if(keyPressed == true)
        {
            marked = !marked;
            if(marked == false)
                clicked = false;
        }
        else if(bombs.contains(this))
            displayLosingMessage();
        else if(countBombs(r, c) > 0)
            setLabel(countBombs(r, c) + "");
        else
        {
            for(int j = -1; j <= 1; j++)
                for(int i = -1; i <= 1; i++)
                    if(isValid(r + i, c + j) && buttons[r + i][c + j].isClicked() == false)
                        buttons[r + i][c + j].mousePressed();
        }
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        //your code here
        if(r < NUM_ROWS && c < NUM_COLS && c >= 0 && r >= 0)
            return true;
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        //your code here
        if(isValid(row, col + 1))
            if(bombs.contains(buttons[row][col + 1]))
                numBombs++;
        if(isValid(row - 1, col + 1))
            if(bombs.contains(buttons[row - 1][col + 1]))
                numBombs++;
        if(isValid(row + 1, col + 1))
            if(bombs.contains(buttons[row + 1][col + 1]))
                numBombs++;
        if(isValid(row + 1, col))
            if(bombs.contains(buttons[row + 1][col]))
                numBombs++;
        if(isValid(row - 1, col))
            if(bombs.contains(buttons[row - 1][col]))
                numBombs++;
        if(isValid(row, col - 1))
            if(bombs.contains(buttons[row][col - 1]))
                numBombs++;
        if(isValid(row + 1, col - 1))
            if(bombs.contains(buttons[row + 1][col - 1]))
                numBombs++;
        if(isValid(row - 1, col - 1))
            if(bombs.contains(buttons[row - 1][col - 1]))
                numBombs++;


        return numBombs;
    }
}



