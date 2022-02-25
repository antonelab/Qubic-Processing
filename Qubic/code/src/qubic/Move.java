package qubic;

public class Move {
    private int mLevel;
    private int mRow;
    private int mColumn;

    //KONSTRUKTORI
    public Move(){
        mLevel = 0;
        mRow = 0;
        mColumn = 0;
    }
    
    public Move(String line){
        String[] elements = line.split(",");
        mLevel = Integer.parseInt(elements[0]);
        mRow = Integer.parseInt(elements[1]);
        mColumn = Integer.parseInt(elements[2]);
    }
    
    public Move(int i, int j, int k){
        mLevel = i;
        mRow = j;
        mColumn = k;
    }
    //vracaju pripadnu varijablu clanicu
    public int level(){return mLevel;}
    public int row(){return mRow;}
    public int column(){return mColumn;}
    
    //pretvara Move u String
    //sluzi za ispis
    public String toString()
    {
        return mLevel + "," + mRow + "," + mColumn;
    }
    //mislim da je i ovo potrebno
    @Override
    public boolean equals(Object o) {
        if (o == this) {
            return true;
        }
        if (!(o instanceof Move)) {
            return false;
        }
        Move m = (Move) o;
        return this.toString().equals(m.toString());
    }
}
