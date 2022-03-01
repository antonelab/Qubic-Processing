package qubic;

public class QubicGame implements Runnable{
    //Novo odgrani potez
    public Move move;
    //kocka na kojoj se igra
    public Cube cube;
    public Thread hintThread;
    //optimalni sljedeci potez
    public Move hintMove;
    //trenutni igrac
    public Player player1, player2;
    //odreduje koji je igrac na potezu
    public int playerOnMove = 0;
    //oznaka pobjednika
    public Character winner;
    //broj odigranih poteza
    public int moveCount = 0;
    
    //stvara uvijete za početak igre
    public QubicGame(int gameType, Player p1, Player p2)
    {
        //System.out.println("Odaberite verziju igre:");
        //System.out.println("Za igru na kocki 3X3X3 odaberite 3");
        //System.out.println("Za igru na kocki 4X4X4 odaberite 4");
        //System.out.println("Vas odabir: ");
        
        //int gameType;
        //Scanner myInput = new Scanner( System.in );
        //gameType = myInput.nextInt();
        //System.out.println("\n\n");

        if(gameType == 3){
            cube = new Cube3();
            //System.out.println("----IGRA KRIZIC-KRUZIC U 3D NA 3X3X3 KOCKI ZAPOCINJE----\n");
        }
        else{
            cube = new Cube4();
            //System.out.println("----IGRA KRIZIC-KRUZIC U 3D NA 4X4X4 KOCKI ZAPOCINJE----\n");
        }
        player1 = p1;
        player2 = p2;
        winner = null;
        hintMove = null;
    }

    //implementira logiku igre
    public void play()
    {
        Integer result;
        playerOnMove = 0;
        Player current;
        
        //mCube.print();
        result = cube.result();
        while(result == null){
            if(playerOnMove == 0)current = player1;
            else current = player2;
            Hint hint = new Hint(cube.clone(), current, this);
            hintThread = new Thread(hint);  
            hintThread.start();
            while(move == null){
                try
                {
                    Thread.sleep(10);
                }
                catch(InterruptedException ex)
                {
                    hintThread.interrupt();
                    Thread.currentThread().interrupt();
                }
                if(current.name.equals("racunalo")  )
                    move = hintMove;
            }
            hintThread.interrupt();
            hintMove = null;
            char id;
            if(playerOnMove == 0) id = player1.id();
            else id = player2.id();
            cube.play(move,  id);
            moveCount++;
            move = null;
            //cube.print();
            playerOnMove = 1 - playerOnMove;
            result = cube.result();
        }
        if(result == 500)
            winner = player1.id();
        
        else if (result == -500)
            winner = player2.id();
        else
            winner = ' ';
    }   
    
    @Override 
    public void run () {
        play();
        try
        {
            Thread.sleep(10);
        }
        catch(InterruptedException ex)
        {
            Thread.currentThread().interrupt();
        }
    }
    
}
