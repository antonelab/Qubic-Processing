package qubic;

public class Hint implements Runnable{
    private Cube cube;
    private Player player;
    private QubicGame game;
    
    Hint(Cube cube, Player player, QubicGame game){
        this.cube = cube;
        this.player = player;
        this.game = game;
    }
    
    @Override 
    public void run () {
        Move hint = player.hint(cube);
        try
        {
            Thread.sleep(10);
            game.hintMove = hint;
            //System.out.println(hint);
        }
        catch(InterruptedException ex)
        {
            Thread.currentThread().interrupt();
        }
    }
    
}
